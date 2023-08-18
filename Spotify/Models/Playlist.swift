//
//  Playlist.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 30/07/23.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
