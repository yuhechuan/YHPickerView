//
//  ViewController.m
//  YHPickerView
//
//  Created by ruaho on 2019/5/7.
//  Copyright © 2019 ruaho. All rights reserved.
//

#define ScreenRect [UIScreen mainScreen].applicationFrame
#define ScreenRectHeight [UIScreen mainScreen].applicationFrame.size.height
#define ScreenRectWidth [UIScreen mainScreen].applicationFrame.size.width

#import "ViewController.h"
#import "RHPickerView.h"
#import "YHButton.h"

@interface ViewController ()<RHPickerViewDelegate>

@property (nonatomic, strong) YHButton *display;
@property (nonatomic, strong) YHButton *displayPresent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUp];
}


- (void)setUp {
    self.title = @"项目演示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = 200;
    CGFloat height = 50;
    CGFloat x = (self.view.bounds.size.width - width) / 2.0;
    CGFloat y1 = 200;
    _display = [[YHButton alloc]initWithFrame:CGRectMake(x, y1, width, height)];
    _display.title = @"无提示";
    _display.buttonColor = [UIColor colorWithRed:70 / 225.0 green:187 / 255.0 blue:38 / 255.0 alpha:1];
    typeof(self) __weak weakSelf = self;
    _display.operation = ^{
        [weakSelf displayAnimation];
    };
    [self.view addSubview:_display];
    
    _displayPresent = [[YHButton alloc]initWithFrame:CGRectMake(x, y1+ height *2, width, height)];
    _displayPresent.title = @"带提示";
    _displayPresent.buttonColor = [UIColor colorWithRed:230 / 225.0 green:103 / 255.0 blue:103 / 255.0 alpha:1];
    _displayPresent.operation = ^{
        [weakSelf displayAnimationTitle];
    };
    [self.view addSubview:_displayPresent];
}

- (void)displayAnimation {
    RHPickerView *p = [[RHPickerView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height)];
    p.delegate = self;
    [self.view addSubview:p];
}

- (void)displayAnimationTitle {
    RHPickerView *p = [[RHPickerView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height) typeTitle:@"演示时间"];
    p.delegate = self;
    [self.view addSubview:p];
}

- (void)didSelectRowDateString:(NSString *)dateString datePicker:(UIDatePicker *)datePicker {
    NSLog(@"选择时间为:%@",dateString);
}

@end
