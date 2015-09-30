//
//  DHROCDatePicker.m
//  DHROCDatePicker
//
//  Created by Dareen Hsu on 9/30/15.
//  Copyright © 2015 D.H. All rights reserved.
//

#import "DHROCDatePicker.h"
#import "NSDate+ROCPicker.h"

@interface DHROCDatePicker () <UIPickerViewDataSource, UIPickerViewDelegate> {
    NSInteger _reloadYear;
    NSInteger _reloadMonth;
    NSInteger _reloadDay;

    NSInteger _nowYear;

    NSInteger _yearRange;
}

@end

@implementation DHROCDatePicker

+ (instancetype) getPicker {
    return [[DHROCDatePicker alloc] initWithFrame:CGRectMake(0, 0, 280, 100)];
}

+ (NSString *) getDefaultFormatString {
    return @"yyyy-MM-dd'T'HH:mm:ssZ";
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDefaultValue];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultValue];
    }
    return self;
}

- (void) setDefaultValue {
    self.dataSource = self;
    self.delegate = self;

    NSDate *today = [NSDate date];
    today = [today increaseYear:-1];
    _nowYear = [today ROCYearValue];
    _reloadYear = -1;
    _reloadMonth = -1;
    _reloadDay = -1;
    _yearRange = [today ROCYearValue] * 2 + 20;

    [self selectDate:[NSDate date]];
}

- (void) selectDate:(NSDate *) date {
    _reloadYear = [date ROCYearValue];
    _reloadMonth = [date monthValue];
    _reloadDay = [date dayValue];

    [self selectRow:_reloadYear - _nowYear + _yearRange / 2 inComponent:0 animated:NO];
    [self selectRow:_reloadMonth - 1 inComponent:1 animated:NO];
    [self reloadComponent:2];
    [self selectRow:_reloadDay - 1 inComponent:2 animated:NO];
}

#pragma mark - UIPickerViewDataSource Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return  _yearRange;
    } else if (component == 1) {
        return 12;
    } else {
        NSInteger year = [pickerView selectedRowInComponent:0] + _nowYear + 1911;
        NSInteger month = [pickerView selectedRowInComponent:1] + 1;

        NSDate *selectDay = [NSDate getDateWithString:[NSString stringWithFormat:@"%04zd-%02zd-%02zdT00:00:00Z",year,month,1] format:[DHROCDatePicker getDefaultFormatString]];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

        NSRange dayRange = [gregorian rangeOfUnit:NSCalendarUnitDay
                                           inUnit:NSCalendarUnitMonth
                                          forDate:selectDay];

        NSInteger days = dayRange.length;
        return days;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        if (row + _nowYear - _yearRange / 2 < 0)
            return [NSString stringWithFormat:@"民國前 %zd年", abs(row + _nowYear - _yearRange / 2)];
        else if (row + _nowYear - _yearRange / 2 == 0)
            return [NSString stringWithFormat:@"民國元年"];
        else
            return [NSString stringWithFormat:@"民國 %zd年",row + _nowYear - _yearRange / 2];
    } else if (component == 1) {
        return [NSString stringWithFormat:@"%zd月",row + 1];
    } else {
        return [NSString stringWithFormat:@"%zd日",row + 1];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 130.;
    } else {
        return 65.;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30.f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0 || component == 1) {
        [pickerView reloadComponent:2];
    }

    NSInteger year = [pickerView selectedRowInComponent:0] +_nowYear;
    NSInteger month = [pickerView selectedRowInComponent:1] + 1;
    NSInteger day = [pickerView selectedRowInComponent:2] + 1;
    NSString *cday = [NSString stringWithFormat:@"%04zd-%02zd-%02zdT00:00:00Z",year + 1911,month,day];
    _createDate = [NSDate getDateWithString:cday format:[DHROCDatePicker getDefaultFormatString]];

    if (_selectDelegate && [_selectDelegate respondsToSelector:@selector(picker:selectDate:)])
        [_selectDelegate picker:self selectDate:_createDate];
}

@end