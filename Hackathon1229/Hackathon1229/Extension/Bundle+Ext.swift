//
//  Bundle+Ext.swift
//  Search
//
//  Created by 김호성 on 2024.11.14.
//

import Foundation

extension Bundle {
    
    var baseUrl: String? {
        guard let file = self.path(forResource: "Secret", ofType: "plist") else { return nil }
        guard let resource = NSDictionary(contentsOfFile: file) else { return nil }
        
        guard let key = resource["baseUrl"] as? String else { return nil }
        return key
    }
}
