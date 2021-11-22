//
//  RealmModel.swift
//  Rife - Simple Run Life
//
//  Created by 경원이 on 2021/11/21.
//
import RealmSwift
import Darwin
import Foundation
import CoreLocation

class RecordObject: Object {
    @Persisted var date: Date
    @Persisted var distance: CLLocationDistance
    @Persisted var time = ""
    @Persisted var image: Data
    @Persisted var memo: String
    
    convenience init(image: Data, distance: CLLocationDistance, time: String) {
        self.init()
        self.date = Date()
        self.image = image
        self.distance = distance
        self.time = time
        self.memo = ""
    }
}

