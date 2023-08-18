//
//  PlaylistDetailsResponse.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 03/08/23.
//

import Foundation

struct PlaylistDetailsResponse : Codable {
    let description : String
    let external_urls : [String:String]
    let id: String
    let images: [APIImage]
    let name: String
    let tracks: PlavlistTracksResponse
}

struct PlavlistTracksResponse: Codable
{
    let items : [PlaylistItem]
}

struct PlaylistItem : Codable{
    let track : AudioTrack
}
