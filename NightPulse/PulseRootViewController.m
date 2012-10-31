//
//  PulseRootViewController.m
//  NightPulse
//
//  Created by Sachin Nene on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PulseRootViewController.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "NearbyVenueTableCell.h"
#import "NightPulseAppDelegate.h"

//#import "TempController.h"
@interface PulseRootViewController ()

- (void)refresh:(NSString *)searchTerm;

- (Venue *)getVenue:(NSIndexPath *)indexPath;

@end


@implementation PulseRootViewController

#if USE_PULL_TO_REFRESH
@synthesize reloading=_reloading;
@synthesize refreshHeaderView;
//@synthesize hasHeaderRow;
@synthesize venueImage;
@synthesize currentVenueIndexPath;
#endif
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    DebugLog(@"initWithNibName");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //UIImageView * logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NightPulseNavBar"]];
        //[self.navigationItem setTitleView:logo];
        //[logo release];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    DebugLog(@"Loading Pulse Root");
    [self.tableView setBackgroundColor:[UIColor blackColor]];

#if USE_PULL_TO_REFRESH
    if (refreshHeaderView == nil) {
        refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, 320.0f, self.tableView.bounds.size.height)];
        refreshHeaderView.backgroundColor = [UIColor colorWithWhite:0 alpha:.85]; //[UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        refreshHeaderView.bottomBorderThickness = 1.0;
        [self.tableView addSubview:refreshHeaderView];
        self.tableView.showsVerticalScrollIndicator = YES;
    }
#endif
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(updateNearbyVenues) 
                                                 name:kNotificationReceivedVenues
                                               object:nil];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self refresh:nil];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma Helper
- (Venue *)getVenue:(NSIndexPath *)indexPath {
    NightPulseAppDelegate * appDelegate = (NightPulseAppDelegate*)[UIApplication sharedApplication].delegate;
    NSArray * venues = [appDelegate getVenues];
    int index = indexPath.row;
    NSLog(@"Returning venue at index %d", index);
    return ((Venue *) [venues objectAtIndex:index]);
}

- (void)refresh:(NSString *)searchTerm {
    [((NightPulseAppDelegate *)[UIApplication sharedApplication].delegate) refreshVenues:nil];
}

-(void)updateNearbyVenues {
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NearbyVenueTableCell *cell = (NearbyVenueTableCell *) [self.tableView dequeueReusableCellWithIdentifier:@"NearbyVenueTableCell"];
    if (cell == nil) {
        cell = [[NearbyVenueTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NearbyVenueTableCell"];

        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NearbyVenueTableCell" owner:nil options:nil];

        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[NearbyVenueTableCell class]]) {
                cell = (NearbyVenueTableCell *) currentObject;
            }
        }
        
    }
    // does nothing
    [cell setBackgroundColor:[UIColor blueColor]];
    
    // hack
    NightPulseAppDelegate * appDelegate = (NightPulseAppDelegate*)[UIApplication sharedApplication].delegate;
    NSArray * venues = [appDelegate getVenues];
//    cell.textLabel.text = [NSString stringWithFormat:@"Row %f", indexPath.row];
    if (indexPath.row < venues.count) {
//        cell.textLabel.text = [self getVenue:indexPath].name;
        Venue *venue = [self getVenue:indexPath];
        cell.venueName.text = venue.name;
        cell.venueDistance.text = [NSString stringWithFormat:@"%ld m", venue.distance];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NightPulseAppDelegate * appDelegate = (NightPulseAppDelegate*)[UIApplication sharedApplication].delegate;
    NSArray * venues = [appDelegate getVenues];
    return venues.count;
//    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setCurrentVenueIndexPath:indexPath];
    NSLog(@"Selecting and saving index path: %@", indexPath);
    CameraViewController * camera = [[CameraViewController alloc] init];
    [camera setDelegate:self];
    //[self.navigationController pushViewController:camera animated:YES];
    modalNav = [[UINavigationController alloc] initWithRootViewController:camera];
    [modalNav setDelegate:self];
    modalNav.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    //[camera.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(dismissModalViewControllerAnimated:)]];
    
    [self presentModalViewController:modalNav animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma Search Delegate Methods


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     // called when keyboard search button pressed
{
    DebugLog(@"searchBarSearchButtonClicked : %@", searchBar.text);
    [self refresh:searchBar.text];
}

#if USE_PULL_TO_REFRESH
#pragma mark ScrollView Callbacks
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	if (scrollView.isDragging) {
		if (refreshHeaderView.state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_reloading) {
            NSLog(@"ScrollView: EGO refreshHeaderView going to normal");
			[refreshHeaderView setState:EGOOPullRefreshNormal];
		} else if (refreshHeaderView.state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_reloading) {
            NSLog(@"ScrollView: EGO refreshHeaderView going to pulling");
			[refreshHeaderView setState:EGOOPullRefreshPulling];
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (scrollView.contentOffset.y <= - 65.0f && !_reloading) {
		_reloading = YES;
        //[delegate didPullToRefreshDoActivityIndicator];
        [refreshHeaderView setState:EGOOPullRefreshLoading];
        [UIView animateWithDuration:.5
                              delay:0
                            options: UIViewAnimationCurveLinear
                         animations:^{
                             [self.tableView setContentInset:UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0)];
                         } 
                         completion:^(BOOL finished){
                             NSLog(@"EGO Refresh view: content inset at 60 - calling reloadTableViewDataSource");
                             [self reloadTableViewDataSource];
                             [UIView animateWithDuration:0.2
                                                   delay:1
                                                 options: UIViewAnimationCurveLinear
                                              animations:^{
                                                  [self.tableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
                                              }
                                              completion:^(BOOL finished) {
                                                  NSLog(@"EGO Refresh view: content inset at 0");
                                                  [refreshHeaderView setState:EGOOPullRefreshNormal];
                                                  _reloading = NO;
                                              }
                              ];
                         }
         ];
	}
}

#pragma mark refreshHeaderView Methods

- (void)dataSourceDidFinishLoadingNewData{
    
    [self.tableView reloadData];
    if (_reloading) {
    	[UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.3];
        [self.tableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
        [UIView commitAnimations];
        
        [refreshHeaderView setState:EGOOPullRefreshNormal];
        
    }
	_reloading = NO;
}

- (void) reloadTableViewDataSource
{
//    [self.delegate didPullToRefresh];
    [self refresh:nil];
}
#endif

#pragma mark CameraDelegate 
-(void)didCancelCaptureImage {
    [self dismissModalViewControllerAnimated:YES];
}

-(void)didCaptureImage:(UIImage *)image {
    [self setVenueImage:image];
    
    CheckInViewController *checkInViewController = [[CheckInViewController alloc] init];
    checkInViewController.checkIn.userId = @"bobo";
    checkInViewController.checkIn.pulseImage = image;
    NSLog(@"indexPath: %@ venue: %@", currentVenueIndexPath, [self getVenue:currentVenueIndexPath]);
    [checkInViewController setVenue:[self getVenue:currentVenueIndexPath]];
    [checkInViewController setDelegate:self];
    [modalNav pushViewController:checkInViewController animated:YES];
    [checkInViewController release];
}

#pragma mark CheckInDelegate
-(void)didCheckIn {
#if 0
    POIViewController * poiController = [[POIViewController alloc] init];
    [poiController setVenue:[self getVenue:currentVenueIndexPath]];
    [poiController setVenueImage:[self venueImage]];
    [modalNav pushViewController:poiController animated:YES];
#else
    // dismiss whole pulse nav
    [self performSelector:@selector(closePulseNav) withObject:self afterDelay:1];
    [[NSNotificationCenter defaultCenter] postNotificationName: kNotificationPulseSent
                                                        object:nil];
#endif
}

-(void)closePulseNav {
    [modalNav dismissModalViewControllerAnimated:YES];
    [self.tabBarController setSelectedIndex:0]; // go to map
}
@end
