//
//  RealmModel.swift
//  ShoppingList
//
//  Created by 배경원 on 2021/11/03.
//


import UIKit
import RealmSwift

class shoppingListObject: Object {
    @Persisted var checked: Bool
    @Persisted var name: String = ""
    @Persisted var hearted: Bool
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(name: String) {
            self.init()
        
            self.name = name
            self.checked = false
            self.hearted = false
        }
}
