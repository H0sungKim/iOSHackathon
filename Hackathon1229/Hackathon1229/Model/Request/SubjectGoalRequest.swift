//
//  SubjectGoalRequest.swift
//  Hackathon1229
//
//  Created by 김호성 on 2025.01.06.
//

import Foundation

struct SubjectGoalRequest: Codable {
    let subject_name: String
    let subject_goal_hour: Int
    let subject_goal_minute: Int
}
