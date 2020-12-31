//
//  ISSLocation.h
//  ISSLocation
//
//  Created by Hoan Tran on 12/29/20.
//

#import "BaseObject.h"
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ISSLocation : BaseObject
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) double timestamp;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) NSString *coordinateString;
@property (nonatomic, readonly) NSDate *date;
@property (nonatomic, readonly) NSString *dateString;

/*
{
    "message": "success",
    "timestamp": UNIX_TIME_STAMP,
    "iss_position": {
        "latitude": CURRENT_LATITUDE,
        "longitude": CURRENT_LONGITUDE
    }
}
 */

@end

NS_ASSUME_NONNULL_END
