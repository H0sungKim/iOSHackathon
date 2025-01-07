//
//  TimerResponse.swift
//  Hackathon1229
//
//  Created by 김호성 on 2025.01.06.
//

import Foundation

struct TimerResponse: Codable {
    let remainTime: Float?
    let goalTime: Int?
    let totalStudyTime: Int?
    let subjectGoalTime: Int?
}
