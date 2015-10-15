//
//  PPSliderControl.m
//  PPHeadViewControll
//
//  Created by ppan on 15/10/15.
//  Copyright © 2015年 ppan. All rights reserved.
//

#import "PPSliderControl.h"
#define  kSliderWith  (int)([UIScreen mainScreen].bounds.size.width/_numberPage)
#define kSliderHeight [UIScreen mainScreen].bounds.size.height
#define kSelfHeigh    self.frame.size.height
#define kSelfWith     self.frame.size.width

@implementation PPSliderControl

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andPageNum:(int)pageNum {

    self = [self initWithFrame:frame];
    _numberPage = pageNum;
    
    _sliderImageView = [[UIImageView alloc]initWithFrame:frame];
    _sliderImageView.layer.cornerRadius = 10;
    _sliderImageView.layer.masksToBounds = YES;
    [_sliderImageView setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:_sliderImageView];
    [self creatUI];
    return self;
}

- (void)creatUI {

    CGRect leftRect = CGRectMake(0, 0, kSliderWith, kSliderHeight);
    CGRect rightRect = CGRectMake(0, 0, self.bounds.size.width, kSliderHeight);
    
    _rightView = [[UIView alloc]initWithFrame:rightRect];
    [_rightView setBackgroundColor:[UIColor clearColor]];
    _rightView.layer.cornerRadius = 10;
    _rightView.clipsToBounds = YES;
    [self addSubview:_rightView];
    
    _leftView = [[UIView alloc]initWithFrame:leftRect];
    [_leftView setBackgroundColor:[UIColor clearColor]];
    _leftView.layer.cornerRadius = 10;
    _leftView.clipsToBounds = YES;
    [self addSubview:_leftView];
    
    _sliderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 60, 60)];
    _sliderImageView.layer.cornerRadius = 30;
    _sliderImageView.layer.masksToBounds = YES;
    [self addSubview:_sliderImageView];
    int with = self.frame.size.width / _numberPage;
    int x = with * _sliderIndex;
    [UIView animateWithDuration:0.1 animations:^{
        [_sliderImageView setFrame:CGRectMake(x, 0, with, kSelfHeigh)];
    }];
    
    //给每个view 加上不同的颜色
    for (NSInteger i = 0; i < _numberPage; i++) {
        CGRect rect;
        if (i == 1) {
            rect = CGRectMake(10 + i *(kSliderWith +10), -10, 60, 60);
            UIView *view = [[UIView alloc]initWithFrame:rect];
            view.layer.cornerRadius = 30;
            view.layer.masksToBounds = YES;
            view.tag = i + kViewTag;
            [self addSubview:view];
        }else {
        
            rect = CGRectMake(10 + i *(kSliderWith +10), 0, 40, 40);
            UIView *view = [[UIView alloc]initWithFrame:rect];
            view.layer.cornerRadius = 20;
            view.layer.masksToBounds = YES;
            view.tag = i + kViewTag;
            [self addSubview:view];
        }
    }
    
}

- (void)setSliderImageviewWithImages:(NSArray *)images {

    for (NSInteger i = 0; i < _numberPage; i++) {
        
        UIView *view = (UIView *)[self viewWithTag:i+kViewTag];
        view.backgroundColor = images[i];
    }
}

- (void)moveSliderToIndex:(int)index animated:(BOOL)animated {

    _sliderIndex = index;
    self.bgIsSelected = YES;
    [UIView animateWithDuration:0.1 animations:^{
        int width = kSelfWith / _numberPage;
        int x = width *_sliderIndex;
        [_sliderImageView setFrame:CGRectMake(x, 0, width, kSelfHeigh)];
    }];
    [self changeBackViewFrame];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.touchIsEnd = NO;
    
   // beganPoint = CGPointMake(_sliderImageView.frame.origin.x, _sliderImageView.frame.origin.y);
    CGPoint movedPoint = [[touches anyObject] locationInView:self];
    CGRect sliderFrame = [_sliderImageView frame];
    float x = movedPoint.x - sliderFrame.size.width / 2;
    if (x < 0)
        x = 0;
    else if (x > self.frame.size.width - sliderFrame.size.width)
        x = self.frame.size.width - sliderFrame.size.width;
    
    sliderFrame.origin.x = x;
    _sliderIndex = round(x / kSliderWith);
    [_sliderImageView setFrame:sliderFrame];
    [self changeBackViewFrame];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    self.touchIsEnd = NO;
    
    CGPoint movedPoint = [[touches anyObject] locationInView:self];
    
    CGRect sliderFrame = [_sliderImageView frame];
    float x = movedPoint.x - sliderFrame.size.width / 2;
    if (x < 0)
        x = 0;
    else if (x > self.frame.size.width - sliderFrame.size.width)
        x = self.frame.size.width - sliderFrame.size.width;
    
    sliderFrame.origin.x = x;
    [_sliderImageView setFrame:sliderFrame];
    
    [self computeCurrentPage:touches isEnd:NO];
    [self changeBackViewFrame];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.touchIsEnd = NO;
    [self touchesEnded:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.touchIsEnd = YES;
    [self computeCurrentPage:touches isEnd:YES];
    
    if (!self.bgIsSelected)
    {
        [self changeBackViewFrame];
    }
    [super touchesEnded:touches withEvent:event];
}
- (void)computeCurrentPage :(NSSet*)touch isEnd:(BOOL)isEnd {

    self.bgIsSelected = NO;
    float center_x = [_sliderImageView frame].origin.x + [_sliderImageView frame].size.width/2;
    
    for (NSInteger i = 0; i <_numberPage; i++) {
        float max_x = (i+1)*kSelfWith/_numberPage;
        if (center_x <= max_x) {
            _sliderIndex = (int)i;
            [UIView animateWithDuration:0.1 animations:^{
                CGRect sliderFrame = [_sliderImageView frame];
                sliderFrame.origin.x = i * kSelfWith/_numberPage;
                [_sliderImageView setFrame:sliderFrame];
                 self.touchIsEnd = YES;
            }];
            break;
        }
    }
}

- (void)changeBackViewFrame {

    CGRect leftFrame = CGRectMake(0, 0, _sliderImageView.frame.origin.x + kSliderWith, kSliderHeight);
    [self.leftView setFrame:leftFrame];
    
    CGRect rightFrame = CGRectMake(leftFrame.size.width - kSliderWith, 0, kSelfWith-leftFrame.size.width, kSliderHeight);
    [self.rightView setFrame:rightFrame];
    for (NSInteger i = 0; i < _numberPage; i++) {
        UIView *view = [self viewWithTag:i+kViewTag];
        if (!view) {
            break;
        }
        if (i < self.sliderIndex || i > self.sliderIndex) {
        
            [UIView animateWithDuration:0.1 animations:^{
                view.alpha = 0.5;
                view.frame = CGRectMake(i*(kSliderWith+10), 0, 40, 40);
                view.layer.cornerRadius = 20;
            }];
            
        }else if (i == self.sliderIndex) {
            if (_delegate && [_delegate respondsToSelector:@selector(didSelectdIndex:)]) {
                
                [_delegate didSelectdIndex:_sliderIndex];
            }
            [UIView animateWithDuration:0.1 animations:^{
                view.alpha = 1;
                view.frame = CGRectMake(i*(kSliderWith+10), -10, 60, 60);
                view.layer.cornerRadius = 30;
            }];

        }
    }
}

@end
