//
//  WBWordObject.swift
//  WordBook
//
//  Created by summer on 2019/7/9.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit
import RealmSwift

class WBWordObject: Object {
    @objc dynamic var wordName: String = ""
    @objc dynamic var wordDetail: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var imageData = Data()
    
    override static func primaryKey() -> String {
        return "id"
    }
    
}
