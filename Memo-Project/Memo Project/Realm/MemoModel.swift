//
//  MemoModel.swift
//  Memo Project
//
//  Created by 배경원 on 2021/11/10.
//

import UIKit
import RealmSwift


class MemoList: Object {
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var writeDate: Date
    @Persisted var pinned: Bool
    
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(title: String, content: String, writeDate: Date, pinned: Bool) {
        
        self.init()
        
        self.title = title
        self.content = content
        self.writeDate = Date()
        self.pinned = false
    }
    

}
