//
//  CommonRestAPI.swift
//  Hackathon1229
//
//  Created by 김호성 on 2025.01.06.
//

import Foundation
import Moya

enum CommonRestAPI {
    case setGoal(param: GoalRequest)
    case setSubjectGoal(param: SubjectGoalRequest)
    case stopTimer(subjectId: Int, param: TimerRequest)
    case pauseTimer(subjectId: Int, param: TimerRequest)
    case getSubjects
}

extension CommonRestAPI: TargetType {
    var baseURL: URL {
        return URL(string: Bundle.main.baseUrl!)!
    }
    
    var path: String {
        switch self {
        case .setGoal:
            return "/home/set"
        case .setSubjectGoal:
            return "/home/lists/add"
        case .stopTimer(let subjectId, let param):
            return "/timer/\(subjectId)/stop"
        case .pauseTimer(let subjectId, let param):
            return "/timer/\(subjectId)/pause"
        case .getSubjects:
            return "/home/lists"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .setGoal, .setSubjectGoal, .stopTimer, .pauseTimer:
            return .post
        case .getSubjects:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .setGoal(let param):
            return .requestJSONEncodable(param)
        case .setSubjectGoal(let param):
            return .requestJSONEncodable(param)
        case .pauseTimer(let subjectId, let param):
            return .requestJSONEncodable(param)
        case .stopTimer(let subjectId, let param):
            return .requestJSONEncodable(param)
        case .getSubjects:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .setGoal, .setSubjectGoal, .pauseTimer, .stopTimer, .getSubjects:
            return ["Content-Type": "application/json"]
        }
    }
}
