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
    
    func getSubjects() -> AnyPublisher<DefaultMultiResponse<SubjectGoalResponse>, MoyaError> {
        return provider.requestPublisher(.getSubjects)
            .map(DefaultMultiResponse<SubjectGoalResponse>.self)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func stopTimer(subjectId: Int, param: TimerRequest) -> AnyPublisher<NilResponse, MoyaError> {
        return provider.requestPublisher(.stopTimer(subjectId: subjectId, param: param))
            .map(NilResponse.self)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func pauseTimer(subjectId: Int, param: TimerRequest) -> AnyPublisher<NilResponse, MoyaError> {
        return provider.requestPublisher(.pauseTimer(subjectId: subjectId, param: param))
            .map(NilResponse.self)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
