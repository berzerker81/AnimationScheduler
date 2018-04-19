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

-(__autoreleasing Animator*)moveTo:(CGPoint)moveTo
                          duration:(CGFloat)duration
                             delay:(CGFloat)delay;

-(__autoreleasing Animator*)moveBy:(CGPoint)moveBy
                          duration:(CGFloat)duration
                             delay:(CGFloat)delay;

//받은 좌표를 SuperView 기준좌표로 변환하여 움직인다.
-(__autoreleasing Animator*)defaultCoordi:(CGSize)defaultCoordi //기준 좌표(받은 좌표)
                                   moveTo:(CGPoint)moveTo       //기준 좌표 기준 이동할 지점
                                 duration:(CGFloat)duration
                                    delay:(CGFloat)delay;

//비율로 텍스트들을 흐르게 만든다.
-(ScheduleAnimator*)scheduleTexts:(NSArray*)texts
                             font:(UIFont*)font
                      startOffset:(CGPoint)start
                        endOffset:(CGPoint)end
                            speed:(CGFloat)speed;

@end
