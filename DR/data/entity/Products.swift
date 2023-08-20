//
//  BooksData.swift
//  DR
//
//  Created by IŞIL VARDARLI on 12.08.2023.
//

import Foundation
class Products{
    init(sectionType: String, productImage: [String], productName: [String], productDetail: [String]) {
        self.sectionType = sectionType
        self.productImage = productImage
        self.productName = productName
        self.productDetail = productDetail
    }
    
    let sectionType:String
    let productImage:[String]
    let productName:[String]
    let productDetail:[String]
    
    }
