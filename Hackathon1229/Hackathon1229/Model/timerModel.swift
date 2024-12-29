//
//  File.swift
//  Hackathon1229
//
//  Created by KoNangYeon on 12/29/24.
//

import Foundation

struct timerModel {
    var text1 : String?
    var text2 : String?
}

extension timerModel {
    static func dummy() -> [ timerModel] {
        return [
            timerModel(text1: "오늘 목표 시간", text2: "05 : 30 : 22"),
            timerModel(text1: "총 공부 시간", text2: "00 : 26 : 12"),
            timerModel(text1: "국어 목표 시간", text2: "01 : 20 : 00"),
        ]
    }
}
