//
//  WidgetKitHelper.swift
//  ISSLocation
//
//  Created by Hoan Tran on 12/30/20.
//

import WidgetKit

@available(iOS 14.0, *)
@objcMembers final class WidgetKitHelper: NSObject {
    
    class func reloadAllWidgets() {
        
        #if arch(arm64) || arch(i386) || arch(x86_64)
        WidgetCenter.shared.reloadAllTimelines()
        #endif
        
    }
    
    class func reloadLocationWidget() {
        #if arch(arm64) || arch(i386) || arch(x86_64)
        WidgetCenter.shared.reloadTimelines(ofKind: "com.bluepego.ISSLocation.ISSLocationWidget")
        #endif
        
    }
    
}

