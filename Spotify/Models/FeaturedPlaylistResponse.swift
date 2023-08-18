//
//  FeaturedPlaylistResponse.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 29/07/23.
//

import Foundation

struct FeaturedPlaylistResponse : Codable{
    let playlists: PlaylistResponse
}

struct CategoriesPlaylistsResponse : Codable{
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
