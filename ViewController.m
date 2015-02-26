//
//  ViewController.m
//  SpeedMonitor
//
//  Created by Brian Smith on 2/22/15.
//  Copyright (c) 2015 Brian Smith. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@end

@implementation ViewController


- (UIButton*)addButton:(NSString*) buttonText
             left:(CGFloat) left
              top:(CGFloat) top
            width:(CGFloat) width
           height:(CGFloat) height
{
    //Create Button
    UIButton* b=[[UIButton alloc]init];
    [b setTitle : buttonText
        forState:UIControlStateNormal];
    //color
    [b setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
    
    //location
    [b setFrame:CGRectMake(left,top,width,height)];
    
    [self.view addSubview:b];
    return b;
    
}

-(void) flipView:(UIButton*) sender{
    NSLog(@"Flip View");
    if (self.userInfoView==nil)
    {
          self.userInfoView=[[UserInfoViewController alloc]initWithNibName:@"UserInfoViewController" bundle:nil];
    }

    CGRect initialFrame=self.view.bounds;
    initialFrame.origin.x=self.view.bounds.size.width;
    
    self.userInfoView.view.frame=initialFrame; //frame off to the right of the window
    self.userInfoView.view.alpha=0.0;
    [self.view addSubview:self.userInfoView.view];
    [UIView animateWithDuration:1.0 animations:^{
        self.userInfoView.view.frame=self.view.bounds;
        self.userInfoView.view.alpha=1.0;
    }];
    
}

-(void) toggleGPS:(UIButton*) sender{
    NSLog(@"tapped");
    NSLog(sender.titleLabel.text);
    if ([sender.titleLabel.text isEqualToString:@"GPS (off)"]){
        //turn it on
        self.locationManager=[[CLLocationManager alloc]init];
        self.locationManager.distanceFilter=kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        
        self.locationManager.delegate=self;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
        //sender.titleLabel.text=@"GPS (on)";
        [sender setTitle:@"GPS (on)" forState:UIControlStateNormal];
        // Start heading updates.

        [self.locationManager startUpdatingHeading];
       
    }
    else
    {
        //turn it off
        [sender setTitle:@"GPS (off)" forState:UIControlStateNormal];
        //sender.titleLabel.text=@"GPS (off)";
        [self.locationManager stopUpdatingLocation];
    }
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton* startButton=[self addButton:@"GPS (off)" left:0 top:0 width:self.view.bounds.size.width/2 height:100];
    
    [startButton addTarget:self action:@selector(toggleGPS:) forControlEvents:UIControlEventTouchUpInside];
    
    self.speedLabel=[self addButton:@"0 MPH"
                               left:0
                                top:0
                              width:self.view.bounds.size.width
                             height:self.view.bounds.size.height/2];
    self.speedLabel.titleLabel.font=[UIFont systemFontOfSize:50];
    [self.view sendSubviewToBack:self.speedLabel];

    self.latLabel=[self addButton:@"0.00"
                             left:0
                              top:200
                            width:self.view.bounds.size.width/2
                           height:100];
    self.lonLabel=[self addButton:@"0.00"
                             left:self.view.bounds.size.width/2
                              top:200
                            width:self.view.bounds.size.width/2
                           height:100];
    
    self.headLabel=[self addButton:@"0.00"
                             left:self.view.bounds.size.width/2
                              top:400
                            width:self.view.bounds.size.width/2
                           height:100];
    

    
    
    self.viewButton=[self addButton:@"Other View"
                               left:self.view.bounds.size.width/2
                                top:0
                              width:self.view.bounds.size.width/2
                             height:100];
        [self.viewButton addTarget:self action:@selector(flipView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view sendSubviewToBack:self.latLabel];
    [self.view sendSubviewToBack:self.lonLabel];
    [self.view sendSubviewToBack:self.headLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//handle location stuff
/*
 *  locationManager:monitoringDidFailForRegion:withError:
 *
 *  Discussion:
 *    Invoked when a region monitoring error has occurred. Error types are defined in "CLError.h".
 */
- (void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region
              withError:(NSError *)error{
    
}

/*
 *  locationManager:didUpdateLocations:
 *
 *  Discussion:
 *    Invoked when new locations are available.  Required for delivery of
 *    deferred locations.  If implemented, updates will
 *    not be delivered to locationManager:didUpdateToLocation:fromLocation:
 *
 *    locations is an array of CLLocation objects in chronological order.
 */
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
        for (CLLocation* location in locations)
        {
            NSLog(@"Longitude %f Latitude %f",
                  location.coordinate.longitude,
                  location.coordinate.latitude);
           
            double metersPerSecond=location.speed;
            double milesPerHour=metersPerSecond*2.23694;
            NSLog(@"Speed = %f",milesPerHour);
            NSString* speedlabel=[NSString stringWithFormat:@"%0.0f MPH",milesPerHour];
            [self.speedLabel setTitle:speedlabel forState:UIControlStateNormal];
            NSString* lat=[NSString stringWithFormat:@"%f", location.coordinate.latitude];
            NSString* lon=[NSString stringWithFormat:@"%f", location.coordinate.longitude];
            [self.latLabel setTitle:lat forState:UIControlStateNormal];
            [self.lonLabel setTitle:lon forState:UIControlStateNormal];
    
            
        }
    

}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading {
    NSString* heading=[NSString stringWithFormat:@"%f", newHeading.trueHeading];
    NSString* magheading=[NSString stringWithFormat:@"%f", newHeading.magneticHeading];
    NSLog(@"%f - %f",heading,magheading);
    [self.headLabel setTitle:heading forState:UIControlStateNormal ];
    if (self.userInfoView!=nil){
        [self.userInfoView setHeading:newHeading.magneticHeading];
    }
    
    
}


@end
