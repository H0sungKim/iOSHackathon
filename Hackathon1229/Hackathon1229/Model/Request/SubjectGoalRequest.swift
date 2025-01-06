//
//  SubjectGoalRequest.swift
//  Hackathon1229
//
//  Created by 김호성 on 2025.01.06.
//

import Foundation

struct SubjectGoalRequest: Codable {
    let subjectName: String
    let goalHour: Int
    let goalMinute: Int
}
