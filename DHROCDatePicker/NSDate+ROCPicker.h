//
//  NSDate+ROCPicker.h
//  DHROCDatePicker
//
//  Created by Dareen Hsu on 9/30/15.
//  Copyright © 2015 D.H. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ROCPicker)

+ (NSDate *) getDateWithString:(NSString *) dstr format:(NSString *) format;

- (NSInteger) ROCYearValue;

- (NSInteger) yearValue;
- (NSInteger) monthValue;
- (NSInteger) dayValue;

- (NSDate *) increaseYear:(NSInteger) year;
- (NSDate *) increaseMonth:(NSInteger) month;
- (NSDate *) increaseDay:(NSInteger) day;
- (NSDate *) increaseHour:(NSInteger) hour;
- (NSDate *) increaseMinit:(NSInteger) minute;

- (NSDate *) getGMTDate;

@end