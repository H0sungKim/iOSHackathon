//
//  DefaultResponse.swift
//  Hackathon1229
//
//  Created by 김호성 on 2025.01.06.
//

import Foundation

struct DefaultResponse<T: Codable>: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: T
}

struct DefaultMultiResponse<T: Codable>: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [T]
}
