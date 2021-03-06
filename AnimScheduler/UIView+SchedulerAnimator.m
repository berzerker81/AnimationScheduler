//
//  UIView+SchedulerAnimator.m
//  AnimScheduler
//
//  Created by 장웅 on 2018. 4. 19..
//  Copyright © 2018년 장웅. All rights reserved.
//

#import "UIView+SchedulerAnimator.h"

@implementation UIView (SchedulerAnimator)

-(__autoreleasing Animator*)moveTo:(CGPoint)moveTo duration:(CGFloat)duration delay:(CGFloat)delay
{
    Animator * animator = [[Animator alloc] initWithAnimFunc:^{
        self.center = moveTo;
    } duration:duration delay:delay targetView:self];
    return animator;
}

-(__autoreleasing Animator*)moveTo:(CGPoint)moveTo duration:(CGFloat)duration delay:(CGFloat)delay fade:(bool)fadeIn
{
    self.layer.opacity = fadeIn ? 0.0 : 1.0;
    CGPoint originPos = self.center;
    Animator * animator = [[Animator alloc] initWithAnimFunc:^{
        self.center = moveTo;
        self.layer.opacity = fadeIn ? 1.0 : 0.0;
    } duration:duration delay:delay targetView:self complete:^{
//        self.center = originPos;
//        self.layer.opacity = fadeIn ? 0.0 : 1.0;
    }];
    return animator;
}

-(__autoreleasing Animator*)moveToAndBack:(CGPoint)moveTo duration:(CGFloat)duration delay:(CGFloat)delay fade:(bool)fadeIn
{
    self.layer.opacity = fadeIn ? 0.0 : 1.0;
    CGPoint originPos = self.center;
    Animator * animator = [[Animator alloc] initWithAnimFunc:^{
        self.center = moveTo;
        self.layer.opacity = fadeIn ? 1.0 : 0.0;
    } duration:duration delay:delay targetView:self complete:^{
                self.center = originPos;
                self.layer.opacity = fadeIn ? 0.0 : 0.0;
    }];
    return animator;
}


-(__autoreleasing Animator*)moveToAndBack:(CGPoint)moveTo duration:(CGFloat)duration delay:(CGFloat)delay
{
    
    CGPoint originPos = self.center;
    
    Animator * animator = [[Animator alloc] initWithAnimFunc:^{
        self.center = moveTo;
    } duration:duration delay:delay targetView:self complete:^{
        self.center = originPos;
    }];
    
    return animator;
}

-(__autoreleasing Animator*)defaultCoordi:(CGSize)defaultCoordi //기준 좌표(받은 좌표)
                                   moveTo:(CGPoint)moveTo       //기준 좌표 기준 이동할 지점
                                 duration:(CGFloat)duration
                                    delay:(CGFloat)delay
{
    CGSize superViewSize = self.superview.frame.size;
    CGPoint coord = CGPointMake(moveTo.x * superViewSize.width / defaultCoordi.width,
                                moveTo.y * superViewSize.height / defaultCoordi.height);
    
    return [self moveTo:coord duration:duration delay:delay];
}

-(__autoreleasing Animator*)moveBy:(CGPoint)moveBy duration:(CGFloat)duration delay:(CGFloat)delay
{
    Animator * animator = [[Animator alloc] initWithAnimFunc:^{
        self.center = CGPointMake(self.center.x + moveBy.x, self.center.y + moveBy.y);
    } duration:duration delay:delay targetView:self];
    return animator;
}

-(ScheduleAnimator*)scheduleTexts:(NSArray*)texts
                             font:(UIFont*)font
                      startOffset:(CGPoint)start
                        endOffset:(CGPoint)end
                            speed:(CGFloat)speed
{
    NSMutableArray * mLabels = [NSMutableArray arrayWithCapacity:texts.count];
    
    ScheduleAnimator * anim = [[ScheduleAnimator alloc] init];
    
    for (NSString* text in texts)
    {
        UILabel * label = [[UILabel alloc] init];
        [label setFont:font];
        [label setText:text];
        [label sizeToFit];
        CGPoint startPos = CGPointMake(self.frame.size.width * start.x, self.frame.size.height * start.y);
        CGPoint endPos   = CGPointMake(self.frame.size.width * end.x, self.frame.size.height * end.y);

        CGFloat quFrameW = self.frame.size.width / 2;
        
        CGPoint fadeInPos  = CGPointMake(startPos.x - quFrameW, startPos.y);
        
        [label setCenter:startPos];
        [mLabels addObject:label];
        
        [self addSubview:label];
        

        
        Animator * fadeIn =  [label moveTo:fadeInPos duration:speed delay:0 fade:YES];
        Animator * fadeOut = [label moveToAndBack:endPos duration:speed delay:0.5 fade:NO];
        label.layer.opacity = 0;
        [anim addAnimator:fadeIn];
        [anim addAnimator:fadeOut];
    }
    
    anim.store = [NSMutableArray arrayWithArray:mLabels];
    mLabels = nil;
    
    return anim;
}

@end
