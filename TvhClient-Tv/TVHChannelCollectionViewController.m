//
//  TVHChannelCollectionViewController.m
//  TvhClient-Tv
//
//  Created by Luis Fernandes on 12/09/2015.
//  Copyright © 2015 Luis Fernandes. All rights reserved.
//

#import "TVHChannelCollectionViewController.h"
#import "UIImageView+WebCache.h"
#import "TVHImageCache.h"

#import "TVHChannelTagViewCell.h"
#import "TVHChannelHeaderCell.h"
#import "TVHSingletonServer.h"
#import "TVHSettings.h"
#import "TVHTag.h"
#import "TVHMovieViewController.h"


@interface TVHChannelCollectionViewController ()
@property (weak, nonatomic) id <TVHTagStore> tagStore;
@property (strong, nonatomic) NSArray *tags;

@end

@implementation TVHChannelCollectionViewController


- (id <TVHTagStore>)tagStore {
    if ( _tagStore == nil) {
        _tagStore = [[TVHSingletonServer sharedServerInstance] tagStore];
    }
    return _tagStore;
}



- (void)initDelegate {
    if( [self.tagStore delegate] ) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didLoadTags)
                                                     name:TVHTagStoreDidLoadNotification
                                                   object:self.tagStore];
    } else {
        [self.tagStore setDelegate:self];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDelegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resetControllerData)
                                                 name:TVHWillDestroyServerNotification
                                               object:nil];

    
    TVHSettings *settings = [TVHSettings sharedInstance];
    if( [settings selectedServer] == NSNotFound ) {
        NSDictionary *new = [settings newServer];
        NSDictionary *server = @{TVHS_SERVER_NAME:@"london",
                                 TVHS_IP_KEY:@"localhost",
                                 TVHS_PORT_KEY:@"9981",
                                 TVHS_HTSP_PORT_KEY:@"9982",
                                 TVHS_USERNAME_KEY:@"",
                                 TVHS_PASSWORD_KEY:@"",
                                 TVHS_USE_HTTPS:@"",
                                 TVHS_SERVER_WEBROOT:@"",
                                 TVHS_VLC_NETWORK_LATENCY:@"999",
                                 TVHS_VLC_DEINTERLACE: @"0",
                                 TVHS_SSH_PF_HOST:@"",
                                 TVHS_SSH_PF_PORT:@"",
                                 TVHS_SSH_PF_USERNAME:@"",
                                 TVHS_SSH_PF_PASSWORD:@"",
                                 TVHS_SERVER_VERSION:@"A15",
                                 TVHS_API_VERSION:@15
                                 };
        if ( ! [new isEqualToDictionary:server] ) {
            NSInteger selectedServer = [settings setServerProperties:server forServerId:-1];
            [settings setSelectedServer:selectedServer];
        }
    }
    
    // Uncomment the following line to preserve selection between presentations
    //self.clearsSelectionOnViewWillAppear = NO;
    
    [self resetControllerData];
}

- (void)resetControllerData {
    self.tags = nil;
    [self initDelegate];
    [self.tagStore fetchTagList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didLoadTags {
    self.tags = [[self.tagStore tags] copy];
    [self.collectionView reloadData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Play Movie"]) {
        TVHMovieViewController *movieController = (TVHMovieViewController*)[segue destinationViewController];
        movieController.channel = self.selectedChannel;
    }
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        TVHChannelHeaderCell *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ChannelHeaderCell" forIndexPath:indexPath];
        TVHTag *tag = [self.tags objectAtIndex:indexPath.section];
        headerView.tagName.text = tag.name;
        
        reusableview = headerView;
    }
    
    return reusableview;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.tags count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TVHChannelTagViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagChannelCell" forIndexPath:indexPath];
    
    TVHTag *tag = [self.tags objectAtIndex:indexPath.section];
    cell.collectionViewController = self;
    [cell configureWithTag:tag];
    
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canFocusItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark <UICollectionViewDelegate>
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
