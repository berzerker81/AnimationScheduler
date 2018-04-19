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
typedef void(^AnimationComplete)(void);

@interface Animator:NSObject
@property(nonatomic) CGFloat duration;
@property(nonatomic) CGFloat delay;
@property(strong,readonly) AnimationFunc animFunc;
@property(strong,readonly) AnimationComplete complete;
@property(weak,readonly) UIView* targetView;
-(Animator*)initWithAnimFunc:(AnimationFunc)func
                    duration:(CGFloat)duration
                       delay:(CGFloat)dealy
                  targetView:(UIView*)targetView;

-(Animator*)initWithAnimFunc:(AnimationFunc)func
                    duration:(CGFloat)duration
                       delay:(CGFloat)dealy
                  targetView:(UIView*)targetView
                    complete:(AnimationComplete)complete;
@end

@protocol ScheduleAnimatorDelegate
@optional
-(void)ScheduleAnimationComplete;
@end
@interface ScheduleAnimator : NSObject
@property(weak)      id<ScheduleAnimatorDelegate> delegate;
@property(nonatomic) bool loop;
@property(nonatomic) NSMutableArray * store;

-(void)addAnimator:(Animator*)anim;
-(void)commit;
-(void)stop;
@end


