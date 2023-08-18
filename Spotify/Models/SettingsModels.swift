//
//  SettingsModels.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 07/07/23.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
