//
//  FirstViewController.m
//  TvhClient-Tv
//
//  Created by Luis Fernandes on 10/09/2015.
//  Copyright © 2015 Luis Fernandes. All rights reserved.
//

#import "FirstViewController.h"
#import "TVHServer.h"
#import <MobileVLCKit.h>

@interface FirstViewController () <VLCMediaPlayerDelegate> {
    VLCMediaPlayer *_mediaplayer;
}
@property (nonatomic, strong) TVHServer *tvhServer;
@property (weak, nonatomic) id <TVHTagStore> tagStore;
@end

@implementation FirstViewController

- (id <TVHTagStore>)tagStore {
    if ( _tagStore == nil) {
        _tagStore = [self.tvhServer tagStore];
    }
    return _tagStore;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    TVHServerSettings *settings = [[TVHServerSettings alloc] initWithSettings:@{TVHS_SERVER_NAME:@"london",
                                                                               TVHS_IP_KEY:@"bananapi1",
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
                                                                                }];
    self.tvhServer = [[TVHServer alloc] initWithSettings:settings];
    
    if( [self.tagStore delegate] ) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didLoadTags)
                                                     name:TVHTagStoreDidLoadNotification
                                                   object:self.tagStore];
    } else {
        [self.tagStore setDelegate:self];
    }
    
    
}


- (IBAction)test:(id)sender {
    [[self.tvhServer tagStore] fetchTagList];
    
    /* setup the media player instance, give it a delegate and something to draw into */
    _mediaplayer = [[VLCMediaPlayer alloc] init];
    _mediaplayer.delegate = self;
    _mediaplayer.drawable = self.movieView;
    
    /* create a media object and give it to the player */
    _mediaplayer.media = [VLCMedia mediaWithURL:[NSURL URLWithString:@"http://192.168.2.54:9981/stream/channel/ad3b0c90ee951c38ac6f5f8b6452fb3c"]];
    
    [_mediaplayer play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willLoadTags {
    
}

- (void)didLoadTags {
    NSLog(@"%@", [self.tagStore tags]);
}

- (void)didErrorLoadingTagStore:(NSError*)error {
    
}

@end
