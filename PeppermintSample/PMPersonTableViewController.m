//
//  PMPersonTableViewController.m
//  PeppermintSample
//
//  Created by Sanad on 10/2/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import "PMPersonTableViewController.h"
#import "PMPersonRecord.h"
#import "PMPersonRecordCollection.h"
#import "PMPersonRecordCell.h"
#import "PMAddressBookPermissionsManager.h"
#import "PMPersonRecordFactory.h"
#import "PMHelper.h"
#import "UIColor-Expanded.h"
#import "PMSearchController.h"
#import "MBProgressHUD.h"
#import "PMLoadingContactsViewController.h"
#import "PMContactsDefaultViewController.h"
#import "PMRecordingViewController.h"
#import "PMGlobalConstants.h"

@implementation PMPersonTableViewController{
    NSArray *_filteredArray;
    PMLoadingContactsViewController *_loadingContactsVC;
    PMSearchController *_searchController;
    PMContactsDefaultViewController *_contactsDefaultVC;
}

static NSInteger _rowHeight = 77;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _filteredArray = [[NSArray alloc] init];
    
    _searchController = [[PMSearchController alloc] initWithSearchResultsController:nil];
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.delegate = self;
    _searchController.searchBar.delegate = self;
    _searchController.searchBar.placeholder = @"Search for Contacts";
    _searchController.searchResultsUpdater = self;
    
    
    //Since the search view covers the table view when active we make the table view controller define the presentation context:
    self.definesPresentationContext = YES;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    _searchController.hidesNavigationBarDuringPresentation = false;
    
    self.navigationItem.titleView = _searchController.searchBar;
    
    [_searchController.searchBar sizeToFit];
    
    
    [_searchController.searchBar setShowsCancelButton:NO animated:false];
    
    if(!_contactsDefaultVC){
        _contactsDefaultVC  = [[PMContactsDefaultViewController alloc] init];
        [self.tableView addSubview:_contactsDefaultVC.view];
        [self addChildViewController:_contactsDefaultVC];
        [_contactsDefaultVC didMoveToParentViewController:self];
        
        _contactsDefaultVC.view.frame = CGRectMake(0, 0, [PMHelper appFrameWidth], [PMHelper appFrameHeight] - [PMHelper getStatusBarHeight] - CGRectGetHeight(_searchController.searchBar.frame));
        [_contactsDefaultVC.view sizeToFit];
        
        _contactsDefaultVC.view.alpha = 0.0;
        
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onContactsDefaultTapped)];
        
        [_contactsDefaultVC.view addGestureRecognizer:tapRecognizer];
        
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO
                                            withAnimation:UIStatusBarAnimationFade];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    
    [PMAddressBookPermissionsManager requestionAddressBookPermissionWithGrantedBlock:^{
        
        if([_searchController.searchBar.text isEqualToString:@""])
            [self showLoadingContacts];
        
        if(![[PMPersonRecordFactory sharedInstance] isConstructed]){
            [[PMPersonRecordFactory sharedInstance] construct];
            [self.tableView reloadData];
        }
        [self performSelector:@selector(hideLoadingContacts) withObject:nil afterDelay:1.0];
        
    } deniedBlock:^{
        
        
        NSString *prodName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
        
        NSString *alertText = [NSString stringWithFormat:@"You must give the app permission to access your contacts. To give this app access, please go to settings app > %@", prodName];
        
        UIAlertView *cantAccessContactsAlert = [[UIAlertView alloc] initWithTitle: @"Cannot Access your contacts" message: alertText delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
        
        [cantAccessContactsAlert show];
        
        
    }];
}

-(void)onContactsDefaultTapped{
    [_searchController.searchBar resignFirstResponder];
}


-(void)showLoadingContacts{
    _loadingContactsVC = [[PMLoadingContactsViewController alloc] init];
    UIViewController *rootViewController = (UIViewController *)[PMHelper getRootViewController];
    [[PMHelper getRootViewController] addChildViewController:_loadingContactsVC];
    _loadingContactsVC.view.alpha = 0.0;
    [rootViewController.view addSubview:[_loadingContactsVC view]];
    [_loadingContactsVC didMoveToParentViewController:self];
    _loadingContactsVC.view.frame = rootViewController.view.frame;
    [UIView animateWithDuration:0.5 animations:^{
        _loadingContactsVC.view.alpha = 1.0;
    }];
}

-(void)hideLoadingContacts{
    [UIView animateWithDuration:0.5 animations:^{
        _loadingContactsVC.view.alpha = 0.0;
        _contactsDefaultVC.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        [_loadingContactsVC.view removeFromSuperview];
        [_loadingContactsVC removeFromParentViewController];
        _loadingContactsVC = nil;
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _filteredArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"personRecordCellIdentifier";
    
    
    PMPersonRecordCell *cell = (PMPersonRecordCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Create a new Candy Object
    PMPersonRecord *personRecord = [_filteredArray objectAtIndex:indexPath.row];
    
    // Configure the cell
    
    cell.fullNameLabel.text = personRecord.fullName;
    cell.valueLabel.text = personRecord.value;
    
    if(personRecord.photo){
        cell.photoImageView.image = personRecord.photo;
    }
    else{
        cell.photoImageView.image = [UIImage imageNamed:@"avatar"];
    }
    
    cell.photoImageView.layer.cornerRadius = 8.0;
    cell.photoImageView.layer.masksToBounds = YES;
    cell.photoImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.photoImageView.layer.borderWidth = 2.0;
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:cell.frame];
    backgroundView.backgroundColor = [UIColor colorWithHexString:global_colorMonteCarlo];
    cell.selectedBackgroundView = backgroundView;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PMPersonRecord *personRecord = [_filteredArray objectAtIndex:indexPath.row];
    
    PMRecordingViewController *_recordingVC = [[PMRecordingViewController alloc] initWithPersonRecord:personRecord];
    
    [self.navigationController pushViewController:_recordingVC animated:YES];
}

#pragma mark - UITableViewDelegate Methods


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _rowHeight;
}

#pragma mark - UISearchControllerDelegate methods

- (void)didPresentSearchController:(UISearchController *)searchController{
    searchController.searchBar.showsCancelButton = false;
}

#pragma mark - UISearchBarDelegate methods
- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText{
    
}


#pragma mark - UISearchResultsUpdating methods
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    [PMAddressBookPermissionsManager requestionAddressBookPermissionWithGrantedBlock:^{
        
        [_searchController.searchBar setShowsCancelButton:NO animated:false];
        NSString *searchString = _searchController.searchBar.text;
        _filteredArray = [[PMPersonRecordCollection sharedInstance] recordsWithName:searchString];
        
        
        [_contactsDefaultVC onContactFound:(_filteredArray.count > 0 || [searchString isEqualToString:@""])];
        
        [self.tableView reloadData];
        [self.tableView sendSubviewToBack:_contactsDefaultVC.view];
        
        
    } deniedBlock:^{
        
        
        NSString *prodName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
        
        NSString *alertText = [NSString stringWithFormat:@"You must give the app permission to access your contacts. To give this app access, please go to settings app > %@", prodName];
        
        UIAlertView *cantAccessContactsAlert = [[UIAlertView alloc] initWithTitle: @"Cannot Access your contacts" message: alertText delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
        
        [cantAccessContactsAlert show];
        
        
    }];
    
    
}

#pragma mark - Keyboard show and hide
- (void) keyboardWillShow: (NSNotification*) n{
    
    NSDictionary* d = [n userInfo];
    CGRect keyboardFrame = [[d objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrame = [self.view.superview convertRect:keyboardFrame fromView:nil];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _contactsDefaultVC.view.center = CGPointMake(_contactsDefaultVC.view.center.x, ([PMHelper appFrameHeight] - CGRectGetHeight(keyboardFrame) - (_contactsDefaultVC.topLabel.frame.origin.y/2))/2);
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void) keyboardWillHide: (NSNotification*) n{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    _contactsDefaultVC.view.center = CGPointMake([PMHelper appFrameWidth]/2, ([PMHelper appFrameHeight] - [PMHelper getStatusBarHeight] - CGRectGetHeight(_searchController.searchBar.frame))/2);
}

@end
