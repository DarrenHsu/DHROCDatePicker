//
//  NSDate+ROCPicker.m
//  DHROCDatePicker
//
//  Created by Dareen Hsu on 9/30/15.
//  Copyright © 2015 D.H. All rights reserved.
//

#import "NSDate+ROCPicker.h"

@implementation NSDate (ROCPicker)

+ (NSDate *) getDateWithString:(NSString *)dstr format:(NSString *)format {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:dstr];
}

- (NSInteger) ROCYearValue {
    NSDateComponents *birthdayComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    NSInteger year = [birthdayComponents year];
    return year - 1911;
}

- (NSInteger) yearValue {
    NSDateComponents *birthdayComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    NSInteger year = [birthdayComponents year];
    return year;
}

- (NSInteger) monthValue {
    NSDateComponents *birthdayComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    NSInteger month = [birthdayComponents month];
    return month;
}

- (NSInteger) dayValue {
    NSDateComponents *birthdayComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    NSInteger day = [birthdayComponents day];
    return day;
}

- (NSDate *) increaseYear:(NSInteger) year {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:year];
    return [gregorian dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *) increaseMonth:(NSInteger) month {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:month];
    return [gregorian dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *) increaseDay:(NSInteger) day {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:day];
    return [gregorian dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *) increaseHour:(NSInteger) hour {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setHour:hour];
    return [gregorian dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *) increaseMinit:(NSInteger) minute {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMinute:minute];
    return [gregorian dateByAddingComponents:dateComponents toDate:self options:0];
}


- (NSDate *) getGMTDate {
    NSTimeInterval timeZoneOffset = [[NSTimeZone defaultTimeZone] secondsFromGMT]; // You could also use the systemTimeZone method
    NSTimeInterval gmtTimeInterval = [self timeIntervalSinceReferenceDate] + timeZoneOffset;
    NSDate *gmtDate = [NSDate dateWithTimeIntervalSinceReferenceDate:gmtTimeInterval];
    return gmtDate;
}

@end