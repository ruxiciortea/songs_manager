//
//  SongsController.swift
//  SongsManager
//
//  Created by user on 10/12/2017.
//  Copyright © 2017 Ruxi. All rights reserved.
//

import UIKit

class SongsController: NSObject {

    static let sharedInstance: SongsController = SongsController()
    
    private var songsArray:[Song] = []
    
    private override init() {
        super.init()
    }
    
    func addSong(song: Song) {
        songsArray.append(song)
    }
    
    func removeSong(index: Int) {
        
        if index >= songsArray.count {
            return
        }        
        songsArray.remove(at: index)
    }
    
    func editSongAtIndex(_ index: Int, withSongInfo editedSong: Song) {
        
        if index >= songsArray.count {
            return
        }
        
        let song = songsArray[index]
        
        song.name = editedSong.name
        song.artist = editedSong.artist
        song.album = editedSong.album
        song.duration = editedSong.duration
    }
    
    func getAllSongs() -> [Song] {
        return songsArray
    }
}
