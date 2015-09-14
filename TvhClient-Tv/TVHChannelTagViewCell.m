//
//  TVHChannelTagViewCell.m
//  TvhClient-Tv
//
//  Created by Luis Fernandes on 13/09/2015.
//  Copyright © 2015 Luis Fernandes. All rights reserved.
//

#import "TVHChannelTagViewCell.h"
#import "UIImageView+WebCache.h"
#import "TVHImageCache.h"

#import "TVHChannelViewCell.h"
#import "TVHSingletonServer.h"
#import "TVHMovieViewController.h"

@interface TVHChannelTagViewCell()
@property (strong, nonatomic) NSArray *channels;
@property (nonatomic, weak) TVHTag *tag;
@end

@implementation TVHChannelTagViewCell

- (id <TVHChannelStore>)channelList {
    if ( _channelStore == nil) {
        _channelStore = [[TVHSingletonServer sharedServerInstance] channelStore];
    }
    return _channelStore;
}

- (void)configureWithTag:(TVHTag*)tag {
    self.tag = tag;
    self.channels = [tag channels];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.channels count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TVHChannelViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChannelCell" forIndexPath:indexPath];
    
    TVHChannel *channel = [self.channels objectAtIndex:indexPath.item];
    NSLog(@"%@", channel.name);
    cell.channelName.text = channel.name;
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (![cell isKindOfClass:[TVHChannelViewCell class]]) {
        NSLog(@"This is suppose to be a channel view cell!");
    }
    
    TVHChannel *channel = [self.channels objectAtIndex:indexPath.item];
    TVHChannelViewCell *channelCell = (TVHChannelViewCell*)cell;
    
    if (channelCell.channelImage.image != nil) {
        return ;
    }
    
    [channelCell.channelImage sd_setImageWithURL:[NSURL URLWithString:channel.imageUrl] placeholderImage:[UIImage imageNamed:@"tag.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error && image) {
            channelCell.channelImage.image = [TVHImageCache resizeImage:image];
        }
    } ];
}

- (UIView*)preferredFocusedView {
    return self.collectionView;
}

#pragma mark - Navigation

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.collectionViewController.selectedChannel = [self.channels objectAtIndex:indexPath.row];
    [self.collectionViewController performSegueWithIdentifier:@"Play Movie" sender:self];
}


@end
