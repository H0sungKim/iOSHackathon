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
    case getTimer(subjectId: Int)
    case deleteSubject(subjectId: Int)
    case getStatistics(date: String)
    case getStatisticsSubject(date: String, keywordId: Int)
    case getRecommendedKeywords(userInput: String)
    case startTimer(subjectId: Int)
    case getGoal
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
        case .getTimer(let subjectId):
            return "/timer/\(subjectId)"
        case .deleteSubject(let subjectId):
            return "/home/lists/\(subjectId)"
        case .getStatistics(let date):
            return "/stat/\(date)"
        case .getStatisticsSubject(let date, let keywordId):
            return "/stat/\(date)/\(keywordId)"
        case .getRecommendedKeywords:
            return "/home/lists/add"
        case .startTimer(let subjectId):
            return "/timer/\(subjectId)/start"
        case .getGoal:
            return "/home"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .setGoal, .setSubjectGoal, .getTimer, .startTimer:
            return .post
        case .getSubjects, .getStatistics, .getStatisticsSubject, .getRecommendedKeywords, .getGoal:
            return .get
        case .deleteSubject, .stopTimer, .pauseTimer:
            return .patch
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
        case .getRecommendedKeywords(let userInput):
            return .requestParameters(parameters: ["userInput": userInput], encoding: URLEncoding.default)
        case .getSubjects, .getTimer, .deleteSubject, .getStatistics, .getStatisticsSubject, .startTimer, .getGoal:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .setGoal, .setSubjectGoal, .pauseTimer, .stopTimer, .getSubjects, .getTimer, .deleteSubject, .getStatisticsSubject, .getStatistics, .getRecommendedKeywords, .startTimer, .getGoal:
            return ["Content-Type": "application/json"]
        }
    }
}
