//
//  AllCategoriesResponse.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 06/08/23.
//

import Foundation

struct AllCategoriesResponse : Codable {
    let categories : Categories
}

struct Categories : Codable {
    let items : [Category]

}

struct Category : Codable {
    let id : String
    let name : String
    let icons : [APIImage]
    
}
