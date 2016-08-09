//
//  Person.swift
//  NamesToFaces
//
//  Created by My Nguyen on 8/9/16.
//  Copyright © 2016 My Nguyen. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
