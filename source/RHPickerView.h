//
//  RHPickerView.h
//  YHPickerView
//
//  Created by ruaho on 2019/5/7.
//  Copyright © 2019 ruaho. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RHPickerViewDelegate <NSObject>

- (void)didSelectRowDateString:(NSString *)dateString datePicker:(UIDatePicker *)datePicker;

@optional
- (void)cancelDatePicker:(UIDatePicker *)datePicker;

@end

NS_ASSUME_NONNULL_BEGIN

@interface RHPickerView : UIView
/*
 * done text color defalut is 230,66,64,1
 */
@property (nonatomic, strong) UIColor *doneButtonColor;
/*
 * cancel text color defalut is 51,51,51,1
 */
@property (nonatomic, strong) UIColor *cancelButtonColor;
/*
 * middle text color defalut is [UIColor grayColor]
 */
@property (nonatomic, strong) UIColor *hintTitleColor;
/*
 * middle text color defalut is white
 */
@property (nonatomic, strong) UIColor *viewBackGroundColor;


@property (nonatomic, weak) id <RHPickerViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame
                    typeTitle:(NSString *)typeTitle;

- (UIDatePicker *)getDatePicker;

@end

NS_ASSUME_NONNULL_END
