//
//  SearchResultsResponse.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 06/08/23.
//

import Foundation

struct SearchResultsResponse : Codable{
    let albums: SearchAlbumResponse
    let artists : SearchArtistResponse
    let playlists : SearchPlaylistResponse
    let tracks : SearchTrackResponse
}

struct SearchAlbumResponse : Codable{
    let items: [Album]
}
struct SearchArtistResponse: Codable {
    let items: [Artist]
}
struct SearchPlaylistResponse: Codable{
    let items: [Playlist]
}
struct SearchTrackResponse: Codable{
    let items: [AudioTrack]
}

