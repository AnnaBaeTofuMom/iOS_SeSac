//
//  storage.swift
//  Memo Project
//
//  Created by 경원이 on 2021/11/12.
//

import Foundation

public class Storage {
    static func isFirstTime() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstTime") == nil {
            defaults.set("No", forKey:"isFirstTime")
            return true
        } else {
            return false
        }
    }
}
