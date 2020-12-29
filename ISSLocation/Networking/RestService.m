//
//  RestService.m
//  PCBlog
//
//  Created by Hoan Tran on 12/11/19.
//  Copyright © 2019 Hoan Tran. All rights reserved.
//

#import "RestService.h"

/*
 ..............................................................................................
 Barebone impletation without unit testing
 Most likely, a full app would download specialized date such as images or videos.
 In that case, this service would expand to include those specific functions

 Timing out a GET request would be very useful
 when Internet connection is not possible.
 A timeout signal would alert the user that something is wrong with connectivity, and
 not with the application itself.

 A "Cancel" request would also be useful when the controller issuing the original request
 no longer cares about the result. Perhaps, placing all these requests in a queue would be useful.

 This service is re-entrant. So multiple simultaneous requests are possible
 ..............................................................................................
 */

@implementation RestService

+ (id)shared {
    static RestService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)getURL:(NSString * _Nonnull)url success:(void (^)(NSData * _Nonnull))success failure:(void (^)(NSError * _Nullable))failure {
    NSURL *urlRequest = [[NSURL alloc] initWithString:url];
    
    if (urlRequest == NULL) {
        NSLog(@"ERR: Can not form URL request from [%@]", url);
        failure(nil);
        return;
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == NULL) {
           NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];

           if (HTTPStatusCode == 200) {
               success(data);
           } else {
               NSLog(@"HTTP status code = %ld", (long)HTTPStatusCode);
               failure(error);
           }
            
        } else {
            NSLog(@"ERR: Encountered errors when retrieving data from [%@]", url);
            failure(error);
        }
    }];
    
    [dataTask resume];
}
@end
