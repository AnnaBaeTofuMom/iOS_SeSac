//
//  String+Extension.swift
//  SeSAC_WEEK6
//
//  Created by 경원이 on 2021/11/02.
//

import Foundation

extension String {
    var localized: String {
            return NSLocalizedString(self, comment: "")
    }
    
    func localized(tableName: String = "Localizable") -> String {
        return NSLocalizedString(self,tableName: tableName, bundle: .main, value: "", comment: "")
    }
}
