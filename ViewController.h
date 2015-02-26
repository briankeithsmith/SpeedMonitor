//
//  ViewController.h
//  SpeedMonitor
//
//  Created by Brian Smith on 2/22/15.
//  Copyright (c) 2015 Brian Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UserInfoViewController.h"

@interface ViewController : UIViewController 

@property (retain) CLLocationManager* locationManager;
@property (retain) UIButton* speedLabel;
@property (retain) UIButton* latLabel;
@property (retain) UIButton* lonLabel;
@property (retain) UIButton* headLabel;
@property (retain) UIButton* viewButton;
@property (retain) UserInfoViewController* userInfoView;
@end

