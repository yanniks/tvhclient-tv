//
//  FirstViewController.h
//  TvhClient-Tv
//
//  Created by Luis Fernandes on 10/09/2015.
//  Copyright © 2015 Luis Fernandes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVHTagStore.h"

@interface FirstViewController : UIViewController <TVHTagStoreDelegate>
@property (weak, nonatomic) IBOutlet UIView *movieView;


@end

