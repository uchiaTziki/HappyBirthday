//
//  UserDefaults.swift
//  HappyBirthday
//
//  Created by Sion Sasson on 11/02/2020.
//  Copyright © 2020 Sion Sasson. All rights reserved.
//

import UIKit

@propertyWrapper
struct HBUserDefault<T> {
    let key: String
    let defaultValue: T?

    init(_ key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T? {
        get { return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
}

class HBUserDefaults: NSObject {
    @HBUserDefault("happy_birthday_baby_name", defaultValue: nil)
    @objc static var babyName: String?
    
    @HBUserDefault("happy_birthday_baby_birthday", defaultValue: nil)
    @objc static var babyBirthdayDate: Date?
}
