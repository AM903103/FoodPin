//
//  File.swift
//  Foodpin
//
//  Created by Apple on 2018/3/26.
//  Copyright © 2018年 Gamma. All rights reserved.
//

import Foundation

class Restaurant {
    var name = ""
    var type = ""
    var location = ""
    var image = ""
    var isVisited = false
    var phone = ""

    init(name: String, type: String, location: String, phone: String, image: String, isVisited: Bool){
        self.name = name
        self.type = type
        self.location = location
        self.phone = phone
        self.image = image
        self.isVisited = isVisited
    }
}
