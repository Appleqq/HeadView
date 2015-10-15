//
//  PPSliderControl.h
//  PPHeadViewControll
//
//  Created by ppan on 15/10/15.
//  Copyright © 2015年 ppan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kViewTag 1000
@protocol PPSliderViewDelegate <NSObject>

- (void)didSelectdIndex:(NSInteger)index;

@end
@interface PPSliderControl : UIView

@property (nonatomic,assign) int numberPage;
@property (nonatomic,assign) int sliderIndex;
@property (nonatomic,strong) UIImageView *sliderImageView; /**<背景图 */

@property (nonatomic,assign,getter= touchIsEnd) BOOL touchIsEnd; /**<滑动结束时为YES 其他为NO*/

@property (nonatomic,strong) UIView *leftView,*rightView; /**<左边背景颜色和右边背景颜色 */

@property (nonatomic,assign) CGPoint begainPoint; /**<*初始位置*/

@property (nonatomic,assign,getter=bgIsSelected) BOOL bgIsSelected;

@property (nonatomic,unsafe_unretained)id <PPSliderViewDelegate> delegate;
/**
 *  初始化
 *
 *  @param frame   视图的坐标位置
 *  @param pageNum 滑块的级数
 *
 *  @return 滑块
 */
-(instancetype)initWithFrame:(CGRect)frame andPageNum:(int)pageNum;
                                                            
/**
 *  设置滑块位置
 *
 *  @param index    滑块移动到所在的位置
 *  @param animated 是否显示动画
 */
- (void)moveSliderToIndex:(int)index animated:(BOOL)animated;
/**
 *  设置滑块的位置背景颜色
 *
 *  @param images 图片数组
 */
- (void)setSliderImageviewWithImages:(NSArray *)images;
@end
