//
//  SubjectModel.swift
//  Hackathon1229
//
//  Created by 주민영 on 12/29/24.
//

import UIKit

struct SubjectModel {
    let title: String
    let time: String
}

extension SubjectModel {
    static func dummy() -> [SubjectModel] {
        return [
            SubjectModel(title: "국어", time: "1시간 20분"),
            SubjectModel(title: "수학", time: "1시간 20분"),
            SubjectModel(title: "영어", time: "1시간 20분"),
            SubjectModel(title: "탐구", time: "1시간 20분"),
        ]
    }
}
