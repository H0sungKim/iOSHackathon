//
//  CommonRepository.swift
//  Hackathon1229
//
//  Created by 김호성 on 2025.01.06.
//

import Foundation
import Moya
import CombineMoya
import Combine

class CommonRepository {
    static let shared = CommonRepository()
    
    private init() { }
    
    private let provider = MoyaProvider<CommonRestAPI>()
    
    func setGoal(goalRequest: GoalRequest) -> AnyPublisher<DefaultResponse<GoalResponse>, MoyaError> {
        return provider.requestPublisher(.setGoal(param: goalRequest))
            .map(DefaultResponse<GoalResponse>.self)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func setSubjectGoal(subjectGoalRequest: SubjectGoalRequest) -> AnyPublisher<DefaultResponse<SubjectGoalResponse>, MoyaError> {
        return provider.requestPublisher(.setSubjectGoal(param: subjectGoalRequest))
            .map(DefaultResponse<SubjectGoalResponse>.self)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getSubjects() -> AnyPublisher<DefaultResponse<SubjectsResponse>, MoyaError> {
        return provider.requestPublisher(.getSubjects)
            .map(DefaultResponse<SubjectsResponse>.self)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func stopTimer(subjectId: Int, param: TimerRequest) -> AnyPublisher<DefaultResponse<RemainResponse>, MoyaError> {
        return provider.requestPublisher(.stopTimer(subjectId: subjectId, param: param))
            .map(DefaultResponse<RemainResponse>.self)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func pauseTimer(subjectId: Int, param: TimerRequest) -> AnyPublisher<DefaultResponse<RemainResponse>, MoyaError> {
        return provider.requestPublisher(.pauseTimer(subjectId: subjectId, param: param))
            .map(DefaultResponse<RemainResponse>.self)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getTimer(subjectId: Int) -> AnyPublisher<DefaultResponse<TimerResponse>, MoyaError> {
        return provider.requestPublisher(.getTimer(subjectId: subjectId))
            .map(DefaultResponse<TimerResponse>.self)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    func deleteSubject(subjectId: Int) -> AnyPublisher<DefaultResponse<String>, MoyaError> {
        return provider.requestPublisher(.deleteSubject(subjectId: subjectId))
            .map(DefaultResponse<String>.self)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getStatistics(date: String) -> AnyPublisher<DefaultResponse<StatResponse>, MoyaError> {
        return provider.requestPublisher(.getStatistics(date: date))
            .map(DefaultResponse<StatResponse>.self)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getStatisticsSubject(date: String, keywordId: Int) -> AnyPublisher<DefaultResponse<StatResponse>, MoyaError> {
        return provider.requestPublisher(.getStatisticsSubject(date: date, keywordId: keywordId))
            .map(DefaultResponse<StatResponse>.self)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getRecommendedKeywords(userInput: String) -> AnyPublisher<DefaultResponse<[String]>, MoyaError> {
        return provider.requestPublisher(.getRecommendedKeywords(userInput: userInput))
            .map(DefaultResponse<[String]>.self)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func startTimer(subjectId: Int) -> AnyPublisher<DefaultResponse<String>, MoyaError> {
        return provider.requestPublisher(.startTimer(subjectId: subjectId))
            .map(DefaultResponse<String>.self)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getGoal() -> AnyPublisher<DefaultResponse<PresentResponse>, MoyaError> {
        return provider.requestPublisher(.getGoal)
            .map(DefaultResponse<PresentResponse>.self)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
