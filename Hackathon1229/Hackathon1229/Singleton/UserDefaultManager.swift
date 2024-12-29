//
//  UserDefaultManager.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import Foundation




// ex) key : "12월 25일 수요일"
// CalendarManager 사용해서 key값 만들기~
class UserDefaultManager {
    
    public static let shared = UserDefaultManager()
    
    private init() {
        
    }
    
    func getGoal(date: String) -> String? {
        return UserDefaults.standard.value(forKey: date) as? String
    }
    
    func setGoal(goal: String, date: String) {
        UserDefaults.standard.setValue(goal, forKey: date)
    }
}
