//
//  SearchReasult.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 06/08/23.
//

import Foundation

enum SearchReasult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
