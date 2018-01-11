//
//  DefineSong.swift
//  SongsManager
//
//  Created by user on 14/11/2017.
//  Copyright © 2017 Ruxi. All rights reserved.
//

import Foundation
import UIKit

class Song: NSObject {
    
    var name: String
    var artist: String
    var album: String
    var duration: Int   // in seconds
    
    override init() {
        self.name = ""
        self.artist = ""
        self.album = ""
        self.duration = 0
    }
    
    init(name: String, artist: String, album: String, duration: Int) {
        self.name = name
        self.artist = artist
        self.album = album
        self.duration = duration
        
    }    
}

