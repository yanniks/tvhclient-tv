//
//  TVHChannelTagViewCell.h
//  TvhClient-Tv
//
//  Created by Luis Fernandes on 13/09/2015.
//  Copyright © 2015 Luis Fernandes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVHChannelStore.h"
#import "TVHTag.h"
#import "TVHChannelCollectionViewController.h"

@interface TVHChannelTagViewCell : UICollectionViewCell <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) id <TVHChannelStore> channelStore;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) TVHChannelCollectionViewController *collectionViewController;
- (void)configureWithTag:(TVHTag*)tag;
@end
