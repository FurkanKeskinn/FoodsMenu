//
//  Foods.swift
//  FoodsMenu
//
//  Created by Furkan on 4.07.2023.
//

import Foundation

struct Food: Decodable {
    let id: String?
    let img: String?
    let name: String?
    let dsc: String?
    let price: Double?
    let rate: Int?
    let country: String?
}

typealias Foods = [Food]
