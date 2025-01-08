//
//  StatResponse.swift
//  Hackathon1229
//
//  Created by 김호성 on 2025.01.07.
//

import Foundation

struct StatResponse: Codable {
    let allKeywords: [String]
    let date: String
    let goalTime: Int?
    let totalStudyTime: Float?
    let hourlyStudyTimesByDate: [HourlyStudyTimesByDate]
    struct HourlyStudyTimesByDate: Codable {
        let hour: Int
        let studyTime: Int
    }
    let allDateInfoList: [AllDateInfoList]
    struct AllDateInfoList: Codable {
        let date: String
        let colorFlag: Int
    }
}
