//
//  SharedPreferencesManager.swift
//  Emoji Mokoko
//
//  Created by Macbook Pro on 21/11/2023.
//

import Foundation

class SharedPreferencesManager {
    static let shared = SharedPreferencesManager()
    
    private init() {
        
    }
    
    // MARK: - Store Value
    func setValue(value: Bool, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    // MARK: - Retrieve Value
    func getValue(forKey key: String) -> Bool {
        return UserDefaults.standard.value(forKey: key) as? Bool ?? false
    }
    
}
