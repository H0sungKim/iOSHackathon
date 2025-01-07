//
//  SubjectModel.swift
//  Hackathon1229
//
//  Created by 주민영 on 12/29/24.
//

import UIKit

struct SubjectModel {
    let id: Int
    let title: String
    let time: String
    
    init(id: Int, title: String, time: String) {
        self.id = id
        self.title = title
        self.time = time
    }
}
