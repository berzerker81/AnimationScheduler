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
}
void * animatorCtx;

-(id)init
{
    self = [super init];
    
    animArray = [NSMutableArray array];
    
    return self;
}

-(void)dealloc
{
    [animArray removeAllObjects];
    animArray = nil;
    currentAnimator = nil;
}

-(void)addAnimator:(Animator *)anim
{
    [animArray addObject:anim];
}

-(void)commit
{
    stop = NO;
    [self animloop:[animArray firstObject]];
}

-(void)animloop:(Animator*)anim
{
    currentAnimator = anim;
    [animArray removeObject:animArray.firstObject];
    [UIView beginAnimations:@"anim" context:animatorCtx];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationDuration:anim.duration];
    [UIView setAnimationDelay:anim.delay];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationEnd:)];
    
    anim.animFunc();
    
    [UIView commitAnimations];
}

-(void)animationEnd:(NSString*)aniID
{
    if(stop) return;
    if(animArray.count)
    {
        [self commit];
    }
}

-(void)stop
{
    [currentAnimator.targetView.layer removeAllAnimations];
    stop = YES;
    [UIView setAnimationsEnabled:NO];
}


@end


@implementation Animator
-(Animator*)initWithAnimFunc:(AnimationFunc)func duration:(CGFloat)duration delay:(CGFloat)dealy targetView:(UIView*)targetView;
{
    self = [super init];
    _targetView = targetView;
    _animFunc = func;
    _duration = duration;
    _delay    = dealy;
    
    return self;
}

-(void)dealloc
{
    _animFunc = nil;
}


@end
