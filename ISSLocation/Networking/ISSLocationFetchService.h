//
//  ISSLocationFetchService.h
//  ISSLocation
//
//  Created by Hoan Tran on 12/29/20.
//

#import <Foundation/Foundation.h>
#import "ISSLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface ISSLocationFetchService : NSObject

- (void)fetchISSLocation:(void (^)(ISSLocation * _Nonnull location))success failure:(void (^)(NSString *))failure;

@end

NS_ASSUME_NONNULL_END
