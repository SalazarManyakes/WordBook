//
//  WBFavoriteObject.swift
//  WordBook
//
//  Created by summer on 2019/7/9.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit
import RealmSwift

class WBFavoriteObject: Object {
    @objc dynamic var favName: String = ""
    @objc dynamic var favDetail: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var favImage = Data()
    
    override static func primaryKey() -> String {
        return "id"
    }
}
