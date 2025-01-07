//
//  SubjectsResponse.swift
//  Hackathon1229
//
//  Created by 김호성 on 2025.01.08.
//

import Foundation

struct SubjectsResponse: Codable {
    let totalRemainTime: Float
    let subjectPreviewDTOList: [SubjectGoalResponse]
}
