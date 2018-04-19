//
//  ViewController.m
//  AnimScheduler
//
//  Created by 장웅 on 2018. 4. 18..
//  Copyright © 2018년 장웅. All rights reserved.
//

#import "ViewController.h"
#import "ScheduleAnimator.h"

@interface ViewController ()

@end

@implementation ViewController
{
    ScheduleAnimator * ani;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UILabel * label = [[UILabel alloc] init];
    [label setText:@"Ani"];
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];
    
    
    Animator * a1 = [[Animator alloc] initWithAnimFunc:^{
        label.center = CGPointMake(label.center.x - 100, label.center.y);
    } duration:2.0 delay:0 targetView:label];
    
    Animator * a2 = [[Animator alloc] initWithAnimFunc:^{
        label.center = CGPointMake(label.center.x, label.center.y + 100);
    } duration:2.0 delay:0 targetView:label];
    
    ani = [[ScheduleAnimator alloc] init];
    
    [ani addAnimator:a1];
    [ani addAnimator:a2];
    [ani commit];
    
}
- (IBAction)anistop:(id)sender {
    [ani stop];
}



-(void)aniStop:(id)sender
{
    NSLog(@"ani end");
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
