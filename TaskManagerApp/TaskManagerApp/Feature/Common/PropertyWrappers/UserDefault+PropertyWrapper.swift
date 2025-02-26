//
//  UserDefault+PropertyWrapper.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

extension UserDefaults {
    @UserDefault(key: "show_home", defaultValue: false)
    static var showHome: Bool

    @UserDefault(key: "app_theme", defaultValue: ThemeName.main.rawValue)
    static var appTheme: String
}
