//
//  RealmModel.swift
//  SeSAC_WEEK6
//
//  Created by 경원이 on 2021/11/02.
//

import Foundation
import RealmSwift

//USerDiary가 테이블 이름, 각각의 Persisted가 컬럼의 이름
class UserDiary: Object {
    
    @Persisted var diaryTitle: String
    @Persisted var writeDate = Date()
    @Persisted var content: String?
    @Persisted var regDate = Date()
    @Persisted var favorite: Bool
    
    //PK(필수): Int, String, UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(diaryTitle: String, writeDate: Date, content: String, regDate: Date) {
        self.init()
        
        self.diaryTitle = diaryTitle
        self.content = content
        self.writeDate = writeDate
        self.regDate = regDate
        self.favorite = false
    }
    
}

