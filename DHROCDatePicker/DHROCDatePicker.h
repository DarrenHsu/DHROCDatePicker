//
//  DHROCDatePicker.h
//  DHROCDatePicker
//
//  Created by Dareen Hsu on 9/30/15.
//  Copyright © 2015 D.H. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DHROCDatePickerDelegate;

@interface DHROCDatePicker : UIPickerView

@property (nonatomic, weak) id<DHROCDatePickerDelegate> selectDelegate;
@property (nonatomic, strong) NSDate *createDate;

+ (instancetype) getPicker;
+ (NSString *) getDefaultFormatString;

- (void) selectDate:(NSDate *) date;

@end

@protocol DHROCDatePickerDelegate <NSObject>
@optional
- (void) picker:(DHROCDatePicker *) picker selectDate:(NSDate *) date;
@end