//
//  ISSPosition.swift
//  ISSLocation
//
//  Created by Hoan Tran on 12/30/20.
//

import Foundation

@objcMembers final class ISSPosition: NSObject, Codable {
    var timestamp: Double
    var latitude: Double
    var longitude: Double
}

extension ISSPosition {
//    convenience init(timestamp: Double, latitude: Double, longitude: Double) {
//        self.init(timestamp: timestamp, latitude: latitude, longitude: longitude)
//    }
    
    func jsonEncode() -> Data? {
        guard let encodedData = try? JSONEncoder().encode(self) else {
            return nil;
        }
        return encodedData
    }

}
