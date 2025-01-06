//
//  CommonRestAPI.swift
//  Hackathon1229
//
//  Created by 김호성 on 2025.01.06.
//

import Foundation
import Moya

enum CommonRestAPI {
    case getGoal()
}

extension CommonRestAPI: TargetType {
    var baseURL: URL {
        return URL(string: Bundle.main.baseUrl!)!
    }
    
    var path: String {
        <#code#>
    }
    
    var method: Moya.Method {
        <#code#>
    }
    
    var task: Moya.Task {
        <#code#>
    }
    
    var headers: [String : String]? {
        <#code#>
    }
}
