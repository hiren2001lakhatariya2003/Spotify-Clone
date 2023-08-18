//
//  UserProfile.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 07/07/23.
//

import Foundation

struct UserProfile : Codable{
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let id: String
    let product: String
    let images: [APIImage]
}

struct UserImage : Codable{
    let url : String
}
