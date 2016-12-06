//
//  CommonVar.swift
//  bahisadam
//
//  Created by GreenRose926 on 11/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import Foundation

final class Shared {
    
    static let shared = Shared() //lazy init, and it only runs once
    
    var strMatchDetailUrl : String!
    var boolValue   : Bool!
    var matchDetail : Dictionary<String, AnyObject> = [:]
    var standingInfo : Dictionary<String, AnyObject> = [:]
    var goalAverageInfo : Dictionary<String, AnyObject> = [:]
}
