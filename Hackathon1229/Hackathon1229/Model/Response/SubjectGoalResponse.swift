//
//  SubjectGoalResponse.swift
//  Hackathon1229
//
//  Created by 김호성 on 2025.01.06.
//

import Foundation

struct SubjectGoalResponse: Codable {
    let id: Int
    let subjectName: String
    let goalTime: Int
    let remainTime: Float?
    let breakTime: Int
}
