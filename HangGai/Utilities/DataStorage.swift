//
//  DataStorage.swift
//  HangGai
//
//  Created by roife on 5/28/21.
//

import Foundation

struct DataStorage {
    static let key = "UserData"
    static let standard = UserDefaults.standard
    
    static func saveUserData(data: UserDataModel) {
        standard.set(data, forKey: self.key)
        standard.synchronize()
    }
    
    static func loadUserData() -> UserDataModel {
        guard let data = standard.object(forKey: self.key) else {
            print("Cannot read user data")
            return UserDataModel()
        }

        guard let userData = data as? UserDataModel else {
            print("Cannot convert data to UserDataModel")
            return UserDataModel()
        }

        return userData
    }
}
