//
//  Location.swift
//  ISSLocation
//
//  Created by Hoan Tran on 12/30/20.
//

import Foundation

struct Location: Codable {
    let unixTimeStamp: UInt
    let latitude: Double
    let longitude: Double
}

//extension Location {
//    init(issLocation: ISSLocation) {
//        unixTimeStamp = issLocation.unixTimeStamp
//        latitude = issLocation.latitude
//        longitude = issLocation.longitude
//    }
//}




