//
//  ISSLocation.m
//  ISSLocation
//
//  Created by Hoan Tran on 12/29/20.
//

#import "ISSLocation.h"

static NSDateFormatter *DATE_FORMATTER;

@implementation ISSLocation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.message = @"";
        self.timestamp = 0;
        self.longitude = 0;
        self.latitude = 0;
        
        if (!DATE_FORMATTER) {
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"MMM d, h:mm:ss a";
            DATE_FORMATTER = dateFormatter;
        }
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"iss_position"]) {
        [self updateValues:(NSDictionary *)value];
    } else {
        [super setValue:value forKey:key];
    }
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

- (NSString *)coordinateString {
    NSNumber *latitude = [NSNumber numberWithDouble:self.latitude];
    NSNumber *longitude = [NSNumber numberWithDouble:self.longitude];
    return [NSString stringWithFormat:@"[%@, %@]", [latitude stringValue], [longitude stringValue]];
}

- (NSDate *)date {
    return [NSDate dateWithTimeIntervalSince1970:self.timestamp];
}

- (NSString *)dateString {
    return [DATE_FORMATTER stringFromDate:self.date];
}

@end
