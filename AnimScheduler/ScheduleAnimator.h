//
//  ScheduleAnimator.h
//  AnimScheduler
//
//  Created by 장웅 on 2018. 4. 18..
//  Copyright © 2018년 장웅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^AnimationFunc)(void);

@interface Animator:NSObject
@property(nonatomic) CGFloat duration;
@property(nonatomic) CGFloat delay;
@property(strong) AnimationFunc animFunc;
@property(weak,readonly) UIView* targetView;
-(Animator*)initWithAnimFunc:(AnimationFunc)func duration:(CGFloat)duration delay:(CGFloat)dealy targetView:(UIView*)targetView;
@end

@interface ScheduleAnimator : NSObject
-(void)addAnimator:(Animator*)anim;
-(void)commit;
-(void)stop;
@end


