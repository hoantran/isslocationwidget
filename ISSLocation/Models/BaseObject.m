//
//  BaseObject.m
//  ISSLocation
//
//  Created by Hoan Tran on 12/29/20.
//

#import "BaseObject.h"

@implementation BaseObject

- (void)setValue:(id)value forKey:(NSString *)key {
    @try {
        if ([value isEqual:[NSNull null]]) {
            [super setValue:nil forKey:key];
        } else {
            [super setValue:value forKey:key];
        }
    } @catch (NSException *exception) {
        if (exception) {
            NSLog(@"setValue:ForKey exception [%@] - [%@]", [exception name], [exception reason]);
        } else {
            NSLog(@"ISSLocation: Exception caught");
        }
    }
}

- (void)updateValues:(NSDictionary *)dictionary {
    for (NSString *key in dictionary) {
        [self setValue:[dictionary objectForKey:key] forKey:key];
    }
}

@end
