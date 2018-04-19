//
//  ScheduleAnimator.m
//  AnimScheduler
//
//  Created by 장웅 on 2018. 4. 18..
//  Copyright © 2018년 장웅. All rights reserved.
//

#import "ScheduleAnimator.h"

@implementation ScheduleAnimator
{
    NSMutableArray  * animArray;
    bool             stop;
    Animator * currentAnimator;
    NSUInteger       currentIndex;
}
void * animatorCtx;

-(id)init
{
    self = [super init];
    
    animArray = [NSMutableArray array];
    currentIndex = 0;
    
    return self;
}

-(void)dealloc
{
    [animArray removeAllObjects];
    animArray = nil;
    currentAnimator = nil;
    
    for (UILabel * label in self.store)
    {
        [label removeFromSuperview];
    }
    
    [self.store removeAllObjects];
}

-(void)addAnimator:(Animator *)anim
{
    [animArray addObject:anim];
}

-(void)commit
{
    stop = NO;
    [self animloop:currentIndex];
}

-(void)animloop:(NSUInteger)animIndex
{

    Animator * anim = animArray[currentIndex];
    currentAnimator = anim;
    [UIView beginAnimations:@"anim" context:nil];
//    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationDuration:anim.duration];
    [UIView setAnimationDelay:anim.delay];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationEnd:)];
    
    anim.animFunc();
    
    [UIView commitAnimations];
}

-(void)animationEnd:(NSString*)aniID
{
    if(stop){
        
        [self completeAnimation];
        
        return;
    }
    
    if(currentAnimator.complete)
    {
        currentAnimator.complete();
    }
    
    currentIndex++;
    
//    NSLog(@"Ani Idx %d",currentIndex);
    
    if(currentIndex < animArray.count)
    {
        [self commit];
    }else
    {
        if(self.loop == NO)
        {
            [self completeAnimation];
            return;
        }
        
        currentIndex = 0;
        [self commit];
    }
}

-(void)stop
{
    [currentAnimator.targetView.layer removeAllAnimations];
    stop = YES;
//    [UIView setAnimationsEnabled:NO];
}

-(void)completeAnimation
{
    if(self.delegate && [(id)self.delegate respondsToSelector:@selector(ScheduleAnimationComplete)])
    {
        [(id)self.delegate ScheduleAnimationComplete];
    }
    
    if(self.delegate && [(id)self.delegate respondsToSelector:@selector(ScheduleAnimationCompleteID:)])
    {
        [(id)self.delegate ScheduleAnimationCompleteID:self.scheduleID];
    }
}


@end


@implementation Animator
-(Animator*)initWithAnimFunc:(AnimationFunc)func
                    duration:(CGFloat)duration
                       delay:(CGFloat)dealy
                  targetView:(UIView*)targetView
{
    self = [super init];
    
    _targetView = targetView;
    _animFunc   = func;
    _duration   = duration;
    _delay      = dealy;
    
    return self;
}

-(Animator*)initWithAnimFunc:(AnimationFunc)func
                    duration:(CGFloat)duration
                       delay:(CGFloat)dealy
                  targetView:(UIView*)targetView
                    complete:(AnimationComplete)complete
{
    self = [super init];
    
    _targetView = targetView;
    _animFunc   = func;
    _duration   = duration;
    _delay      = dealy;
    _complete   = complete;
    
    return self;
}


-(void)dealloc
{
    _animFunc = nil;
    _complete = nil;
    
}


@end
