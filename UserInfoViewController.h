//
//  UserInfoViewController.h
//  SpeedMonitor
//
//  Created by Brian Smith on 2/22/15.
//  Copyright (c) 2015 Brian Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;

- (IBAction)foo:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrowView;

- (void) setHeading:(double) heading;

@end
