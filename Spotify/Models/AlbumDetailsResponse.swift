//
//  AlbumDetailsResponse.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 03/08/23.
//

import Foundation

struct AlbumDetailsResponse : Codable{
    let album_type : String
    let artists : [Artist]
    let available_markets : [String]
    let external_urls : [String : String]
    let id : String
    let images : [APIImage]
    let label: String
    let name: String
    let tracks: TrackResponse
    
}

struct TrackResponse : Codable{
    let items : [AudioTrack]
}
