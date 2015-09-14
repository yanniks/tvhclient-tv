//
//  FirstViewController.m
//  TvhClient-Tv
//
//  Created by Luis Fernandes on 10/09/2015.
//  Copyright © 2015 Luis Fernandes. All rights reserved.
//

#import "TVHMovieViewController.h"
#import "TVHChannel.h"
#import <TVVLCKit.h>

@interface TVHMovieViewController () <VLCMediaPlayerDelegate> {
    VLCMediaPlayer *_mediaplayer;
}

@end

@implementation TVHMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* setup the media player instance, give it a delegate and something to draw into */
    _mediaplayer = [[VLCMediaPlayer alloc] init];
    _mediaplayer.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    _mediaplayer.drawable = self.movieView;
    _mediaplayer.media = [VLCMedia mediaWithURL:[NSURL URLWithString:self.channel.streamURL]];
    
    [_mediaplayer play];
}

- (void)viewWillDisappear:(BOOL)animated {
    [_mediaplayer stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
