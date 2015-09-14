//
//  FirstViewController.h
//  TvhClient-Tv
//
//  Created by Luis Fernandes on 10/09/2015.
//  Copyright © 2015 Luis Fernandes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVHChannel.h"

@interface TVHMovieViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UIView *movieView;
@property (nonatomic, strong) TVHChannel *channel;

@end

