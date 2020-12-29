//
//  ISSLocationFetchService.m
//  ISSLocation
//
//  Created by Hoan Tran on 12/29/20.
//

#import "ISSLocationFetchService.h"
#import "RestService.h"

static NSString * const ISS_LOCATION_URL = @"http://api.open-notify.org/iss-now.json";

@implementation ISSLocationFetchService

- (void)fetchISSLocation:(void (^)(ISSLocation * _Nonnull location))success failure:(void (^)(NSString *))failure {
    [self fetchISSLocationFromURL:ISS_LOCATION_URL success:success failure:failure];
}

- (void)fetchISSLocationFromURL:(NSString * _Nonnull)url success:(void (^)(ISSLocation * _Nonnull location))success failure:(void (^)(NSString *))failure {
    
    [RestService.shared getURL:url success:^(NSData * _Nonnull data) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (json) {
            ISSLocation *location = [[ISSLocation alloc]init];
            [location updateValues:json];
            success(location);
        } else {
            NSLog(@"Can't parse JSON - [%@]", error.description);
            failure(error.description);
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"Can't download URL [%@] - [%@]", url, error.description);
        failure(error.description);
    }];
}


@end
