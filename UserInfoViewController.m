//
//  UserInfoViewController.m
//  SpeedMonitor
//
//  Created by Brian Smith on 2/22/15.
//  Copyright (c) 2015 Brian Smith. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)foo:(id)sender {
    NSLog(self.txtUserName.text);
    [UIView animateWithDuration:0.1
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect newFrame = self.view.bounds;
                         newFrame.origin.x = self.view.bounds.size.width;
                         self.view.frame = newFrame;
                         self.view.alpha=0.0;
                     }
     
                     completion:^(BOOL finished){
                         [self.view removeFromSuperview];
                     }];
    
}
- (void) setHeading:(double) heading{
    NSLog(@"heading was changed to %f",heading);
    [self setArrowHeading:-heading];
}
- (void) setArrowHeading:(double) degrees{
    double radians = degrees / 180.0 * M_PI;
    [UIView animateWithDuration: 1.0
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.imgArrowView.layer.transform = CATransform3DMakeRotation(radians, 0, 0, 1);
                     }
                     completion:^(BOOL finished){
                     }];
}
@end
