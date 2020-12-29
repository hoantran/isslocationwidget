//
//  RestService.h
//  PCBlog
//
//  Created by Hoan Tran on 12/11/19.
//  Copyright © 2019 Hoan Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestService : NSObject
+ (id)shared;
- (void)getURL:(NSString * _Nonnull)url success:(void (^)(NSData * _Nonnull))success failure:(void (^)(NSError * _Nullable))failure;
@end

NS_ASSUME_NONNULL_END
