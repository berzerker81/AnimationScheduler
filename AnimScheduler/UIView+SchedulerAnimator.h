//
//  UIView+SchedulerAnimator.h
//  AnimScheduler
//
//  Created by 장웅 on 2018. 4. 19..
//  Copyright © 2018년 장웅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleAnimator.h"
//Cocos2d Animation Style
@interface UIView (SchedulerAnimator)

-(__autoreleasing Animator*)moveTo:(CGPoint)moveTo duration:(CGFloat)duration delay:(CGFloat)delay;
-(__autoreleasing Animator*)moveBy:(CGPoint)moveBy duration:(CGFloat)duration delay:(CGFloat)delay;

//비율로 텍스트들을 흐르게 만든다.
-(ScheduleAnimator*)scheduleTexts:(NSArray*)texts
                             font:(UIFont*)font
                      startOffset:(CGPoint)start
                        endOffset:(CGPoint)end
                            speed:(CGFloat)speed;

@end
