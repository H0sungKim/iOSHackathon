//
//  PresentResponse.swift
//  Hackathon1229
//
//  Created by 김호성 on 2025.01.13.
//

import Foundation

struct PresentResponse: Codable {
    let date: String
    let isPresent: Bool
    let goalTime: Int
}
