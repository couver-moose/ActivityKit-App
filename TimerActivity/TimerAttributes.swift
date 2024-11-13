//
//  TimerAttributes.swift
//  TimerActivity
//
//  Created by Dario Daßler on 30.10.24.
//

import Foundation
import ActivityKit
import SwiftUI

struct TimerAttributes: ActivityAttributes{
    public typealias TimerStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var endTime: Date
    }
    
    var startTime: Date
    var timerName: String
}
