//
//  RHPickerView.m
//  YHPickerView
//
//  Created by ruaho on 2019/5/7.
//  Copyright © 2019 ruaho. All rights reserved.
//

#import "RHPickerView.h"

@interface RHPickerView ()

@property (nonatomic, strong) UIView *dataPickerView;

@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *hintTitleLablel;

@property (nonatomic, strong) UIDatePicker *dataPicker;

@property (nonatomic, copy) NSString *typeTitle;


@end

@implementation RHPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpDatePicker:frame];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                    typeTitle:(NSString *)typeTitle {
    _typeTitle = typeTitle;
    return [self initWithFrame:frame];
}

- (void)setUpDatePicker:(CGRect)frame {
    
    self.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];;
    
    CGFloat leftRightMargin = 30;
    CGFloat width = frame.size.width - 2 *leftRightMargin;
    CGFloat height = 200;
    CGFloat buttonViewHeigh = 50;
    CGFloat bigHeight = height + buttonViewHeigh;

    CGFloat y = (frame.size.height - bigHeight) / 4.0;

    
    _dataPickerView = [[UIView alloc]initWithFrame:CGRectMake(leftRightMargin, y, width, bigHeight)];
    _dataPickerView.backgroundColor = [UIColor whiteColor];
    
    _dataPicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, width,height)];
    _dataPicker.datePickerMode = UIDatePickerModeDate;
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    _dataPicker.locale = locale;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//设置输出的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    CGFloat buttonWidth = 100;
    CGFloat buttonHeight = 50;
    CGFloat buttonY = CGRectGetMaxY(_dataPicker.frame);
    
    if (self.typeTitle && self.typeTitle.length > 0) {
        CGFloat titleW = 100;
        CGFloat titleH = 20;
        CGFloat titleX = (width - titleW) / 2.0;
        self.hintTitleLablel.frame = CGRectMake(titleX, buttonY, titleW, titleH);
        [_dataPickerView addSubview:self.hintTitleLablel];
    }
    
    
    CGFloat leftButtonMargin = 15;
    self.cancelButton.frame = CGRectMake(leftButtonMargin,buttonY , buttonWidth, buttonHeight);
    self.doneButton.frame = CGRectMake(width -leftButtonMargin - buttonWidth ,buttonY , buttonWidth, buttonHeight);
    
    [_dataPickerView addSubview:_dataPicker];
    [_dataPickerView addSubview:self.cancelButton];
    [_dataPickerView addSubview:self.doneButton];

    [self addSubview:_dataPickerView];
}

- (void)animationbegin:(UIView *)view {
    /* 放大缩小 */
    
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 动画选项设定
    animation.duration = 0.1; // 动画持续时间
    animation.repeatCount = -1; // 重复次数
    animation.autoreverses = YES; // 动画结束时执行逆动画
    
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:0.9]; // 结束时的倍率
    
    // 添加动画
    [view.layer addAnimation:animation forKey:@"scale-layer"];
    
}

- (void)removeDatePickerView {
    // 开始动画
    [self animationbegin:self.dataPickerView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (UIButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [[UIButton alloc]init];
        [_doneButton setTitle:@"确定" forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
        [_doneButton setTitleColor:[UIColor colorWithRed:230.0/255 green:66.0/255 blue:64.0/255 alpha:1] forState:UIControlStateNormal];
    }
    return _doneButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]init];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UILabel *)hintTitleLablel {
    if (!_hintTitleLablel) {
        _hintTitleLablel = [[UILabel alloc]init];
        _hintTitleLablel.textColor = [UIColor grayColor];
        _hintTitleLablel.font = [UIFont systemFontOfSize:13];
        _hintTitleLablel.text = self.typeTitle;
        _hintTitleLablel.textAlignment = NSTextAlignmentCenter;
    }
    return _hintTitleLablel;
}

- (void)done:(UIButton *)sender {
    [self removeDatePickerView];
    if ([self.delegate respondsToSelector:@selector(didSelectRowDateString:datePicker:)]) {
        [self.delegate didSelectRowDateString:[self timeFormat] datePicker:self.dataPicker];
    }
}

- (void)cancel:(UIButton *)sender {
    [self removeDatePickerView];
    if ([self.delegate respondsToSelector:@selector(cancelDatePicker:)]) {
        [self.delegate cancelDatePicker:self.dataPicker];
    }
}

- (NSString *)timeFormat {
    NSDate *selected = [self.dataPicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    NSString *currentOlderOneDateStr = [dateFormatter stringFromDate:selected];
    return currentOlderOneDateStr;
}

- (void)setDoneButtonColor:(UIColor *)doneButtonColor {
    _doneButtonColor = doneButtonColor;
    [self.doneButton setTitleColor:doneButtonColor forState:UIControlStateNormal];
}

-(void)setCancelButtonColor:(UIColor *)cancelButtonColor {
    _cancelButtonColor = cancelButtonColor;
    [self.cancelButton setTitleColor:cancelButtonColor forState:UIControlStateNormal];
}


- (void)setHintTitleColor:(UIColor *)hintTitleColor {
    _hintTitleColor = hintTitleColor;
    self.hintTitleLablel.textColor = hintTitleColor;
}

- (void)setViewBackGroundColor:(UIColor *)viewBackGroundColor {
    _viewBackGroundColor = viewBackGroundColor;
    self.dataPickerView.backgroundColor = viewBackGroundColor;
}

- (UIDatePicker *)getDatePicker {
    return _dataPicker;
}

@end
