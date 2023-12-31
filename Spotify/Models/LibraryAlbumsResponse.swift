//
//  LibraryAlbumsResponse.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 19/08/23.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
