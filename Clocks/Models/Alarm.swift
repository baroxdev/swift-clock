//
//  Alarm.swift
//  Clocks
//
//  Created by admin on 24/9/26.
//

import Foundation


struct Alarm: Identifiable {
    let id = UUID()
    var name: String
    var isEnabled: Bool
    var time: Date = Date.now
    var snoozed: Bool = false
    var repeatDays: Set<Weekday> = []
}

struct AlarmCategory: Identifiable {
    let id = UUID()
    let title: String
    var alarms: [Alarm]
}
