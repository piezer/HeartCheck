//
//  global.swift
//  SpeedySloth
//
//  Created by Zachery Ferreira on 1/21/17.
//  Copyright © 2017 Apple, Inc. All rights reserved.
//

import Foundation
class Main {
    var name: String
    var heartRate: Int
    init(name: String, heartRate: Int){
        self.name = name
        self.heartRate = heartRate
    }
    func modifyHeartRate(heartRate: Int){
        self.heartRate = heartRate
    }
}
var mainInstance = Main(name:"Data", heartRate: 0)
