//
//  Product.swift
//  15_04_24_WebservicesNestedAPIArrayOfImages
//
//  Created by Vishal Jagtap on 24/05/24.
//

import Foundation
struct Product{
    var id : Int
    var title : String
    var price : Int
    var description : String
    var images : [String]
//    var creationAt : String
//    var updatedAt : String
//    var category : Category
}

struct Category{
    var id : Int
    var name : String
    var image : String
    var creationAt : String
    var updatedAt : String
}
