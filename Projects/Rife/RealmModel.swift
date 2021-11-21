//
//  RealmModel.swift
//  Rife - Simple Run Life
//
//  Created by 경원이 on 2021/11/21.
//
import RealmSwift
import Darwin
import Foundation

class RecordObject: Object {
    @Persisted var date: Date
    @Persisted var distance: String = ""
    @Persisted var time = ""
    @Persisted var image: Data
    convenience init(image: Data) {
        self.init()
        self.date = Date()
        self.image = image
    }
}
