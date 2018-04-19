//
//  ViewController.m
//  AnimScheduler
//
//  Created by 장웅 on 2018. 4. 18..
//  Copyright © 2018년 장웅. All rights reserved.
//

#import "ViewController.h"
#import "ScheduleAnimator.h"
#import "UIView+SchedulerAnimator.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *movieView;

@end

@implementation ViewController
{
    ScheduleAnimator * anim;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    
//    UILabel * label = [[UILabel alloc] init];
//    [label setText:@"Ani"];
//    [label sizeToFit];
//    label.center = self.view.center;
//    [self.view addSubview:label];
    
    
    
//    ani = [[ScheduleAnimator alloc] init];
//    ani.delegate = self;
//    ani.loop = NO;
//    [ani addAnimator:[label moveBy:CGPointMake(-50, -50) duration:1.0 delay:0]];
//    [ani addAnimator:[label moveBy:CGPointMake(50, 50) duration:1.0 delay:0]];
//    [ani commit];
//
////    Animator * a1 = [[Animator alloc] initWithAnimFunc:^{
////        label.center = CGPointMake(0, 100);
////    } duration:2.0 delay:0 targetView:label complete:^{
////        label.center = self.view.center;
////    }];
////
////    Animator * a2 = [[Animator alloc] initWithAnimFunc:^{
////        label.center = CGPointMake(label.center.x, label.center.y + 100);
////    } duration:2.0 delay:0 targetView:label];
////
////    ani = [[ScheduleAnimator alloc] init];
////    ani.delegate = self;
//////    ani.loop = YES;
////    [ani addAnimator:a1];
////    [ani addAnimator:a2];
////    [ani commit];
//
//
//
//
//
////    Animator * a1 = [[Animator alloc] initWithAnimFunc:^{
////        label.center = CGPointMake(label.center.x - 100, label.center.y);
////    } duration:2.0 delay:0 targetView:label];
////
////    Animator * a2 = [[Animator alloc] initWithAnimFunc:^{
////        label.center = CGPointMake(label.center.x, label.center.y + 100);
////    } duration:2.0 delay:0 targetView:label];
////
////    Animator * a3 = [[Animator alloc] initWithAnimFunc:^{
////        label.center = CGPointMake(label.center.x+100, label.center.y);
////    } duration:2.0 delay:0 targetView:label];
////
////    Animator * a4 = [[Animator alloc] initWithAnimFunc:^{
////        label.center = CGPointMake(label.center.x, label.center.y - 100);
////    } duration:2.0 delay:0 targetView:label];
////
////
////    ani = [[ScheduleAnimator alloc] init];
////    ani.loop = YES;
////    [ani addAnimator:a1];
////    [ani addAnimator:a2];
////    [ani addAnimator:a3];
////    [ani addAnimator:a4];
////    [ani commit];
    
}
- (IBAction)anistop:(id)sender {
    [anim stop];
    anim = nil;
}
- (IBAction)startPetAnimate:(UIButton*)sender
{
    ScheduleAnimator * scheduler = [[ScheduleAnimator alloc] init];
    scheduler.scheduleID = 100;
    
    NSString    * path = [[NSBundle mainBundle] pathForResource:@"bgle" ofType:@"png"];
    UIImage     * image = [UIImage imageWithContentsOfFile:path];
    UIImageView * imgView = [[UIImageView alloc] initWithImage:image];
    
    [self.movieView addSubview:imgView];
    imgView.center = CGPointMake(self.movieView.bounds.size.width, 0);
    
    Animator * ani1 = [imgView defaultCoordi:CGSizeMake(1000, 1000) moveTo:CGPointMake(0, 1000) duration:2.0 delay:0];
    Animator * ani2 = [imgView defaultCoordi:CGSizeMake(1000, 1000) moveTo:CGPointMake(500, 500) duration:2.0 delay:0];
    Animator * ani3 = [imgView defaultCoordi:CGSizeMake(1000, 1000) moveTo:CGPointMake(1000, 500) duration:2.0 delay:0];
    Animator * ani4 = [imgView defaultCoordi:CGSizeMake(1000, 1000) moveTo:CGPointMake(1000, 1000) duration:2.0 delay:0];
    [scheduler addAnimator:ani1];
    [scheduler addAnimator:ani2];
    [scheduler addAnimator:ani3];
    [scheduler addAnimator:ani4];
    scheduler.loop = YES;
    [scheduler commit];
}

- (IBAction)aniStart:(id)sender {
    anim = [self.view scheduleTexts:@[@"123",@"1234",@"12345",@"123456"]
                               font:[UIFont fontWithName:@"Arial" size:10]
                        startOffset:CGPointMake(1.0, 0.5)
                          endOffset:CGPointMake(0.0, 0.5)
                              speed:1.0
            ];
    anim.loop = YES;
    anim.delegate = self;
    
    [anim commit];
}


-(void)aniStop:(id)sender
{
    NSLog(@"ani end");
}

-(void)ScheduleAnimationComplete
{
    NSLog(@"Ani Chain End");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
