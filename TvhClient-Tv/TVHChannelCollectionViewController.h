//
//  TVHChannelCollectionViewController.h
//  TvhClient-Tv
//
//  Created by Luis Fernandes on 12/09/2015.
//  Copyright © 2015 Luis Fernandes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVHTagStore.h"
#import "TVHChannelStore.h"

@interface TVHChannelCollectionViewController : UICollectionViewController <TVHTagStoreDelegate, TVHChannelStoreDelegate>

@end
