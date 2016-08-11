//
//  Person.swift
//  NamesToFaces
//
//  Created by My Nguyen on 8/9/16.
//  Copyright © 2016 My Nguyen. All rights reserved.
//

import UIKit

// NSCoding is similar to the Java Serializable and Parcelable interface
// NSCoding requires Person to be an NSObject
// NSCoding requires Person to implement a required initializer and encodeWithCoder() method
class Person: NSObject, NSCoding {
    var name: String
    var image: String

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }

    // this initializer is used when loading objects for this class
    required init(coder decoder: NSCoder) {
        name = decoder.decodeObjectForKey("name") as! String
        image = decoder.decodeObjectForKey("image") as! String
    }

    // this method is used when saving objects
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(name, forKey: "name")
        coder.encodeObject(image, forKey: "image")
    }
}
