//
//  TVHChannelViewCell.m
//  TvhClient-Tv
//
//  Created by Luis Fernandes on 12/09/2015.
//  Copyright © 2015 Luis Fernandes. All rights reserved.
//

#import "TVHChannelViewCell.h"

@implementation TVHChannelViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.channelImage.adjustsImageWhenAncestorFocused = true;
    self.channelImage.clipsToBounds = false;
}


@end
