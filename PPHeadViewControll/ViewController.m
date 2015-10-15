//
//  ViewController.m
//  PPHeadViewControll
//
//  Created by ppan on 15/10/15.
//  Copyright © 2015年 ppan. All rights reserved.
//

#import "ViewController.h"
#import "PPSliderControl.h"
@interface ViewController ()<PPSliderViewDelegate>
{

    PPSliderControl *sliderControl;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self creatUI];
}

- (void)creatUI {
    CGRect rect  = CGRectMake(0, 200, self.view.frame.size.width, 50);
    
    sliderControl = [[PPSliderControl  alloc] initWithFrame:rect andPageNum:5];
    sliderControl.delegate = self;
    sliderControl.leftView.backgroundColor = [UIColor whiteColor];
    sliderControl.rightView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sliderControl];
    
    NSArray *sliderLabels = @[[UIColor grayColor],[UIColor blueColor],[UIColor redColor],[UIColor yellowColor],[UIColor greenColor]];
    [sliderControl setSliderImageviewWithImages:sliderLabels];
    
}
- (void)didSelectdIndex:(NSInteger)index {

    NSLog(@"%ld",(long)index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
