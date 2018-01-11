//
//  ViewController.swift
//  SongsManager
//
//  Created by user on 14/11/2017.
//  Copyright © 2017 Ruxi. All rights reserved.
//

import UIKit

class ViewSongsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddSongViewControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var songsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var songsTableViewLabel: UILabel! 
    
    var selectedIndexPath: IndexPath?
    var songs: [Song] = SongsController.sharedInstance.getAllSongs() {
        didSet {
            songsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.songsTableView.dataSource = self
        self.songsTableView.delegate = self
        
        searchBar.delegate = self
            
        songsTableViewLabel.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        songs = SongsController.sharedInstance.getAllSongs()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuse")
        let song = songs[indexPath.row]
        
        cell.textLabel?.text = "\(song.artist) - \(song.name)"
        cell.detailTextLabel?.text = self.formatedSongDuration(duration: song.duration)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.performSegue(withIdentifier: "EditSongSegue", sender: nil)
    }
    
    func didAddSong(_ newSong: Song) {
        SongsController.sharedInstance.addSong(song: newSong)
    }
    
    func didEditSong(_ editedSong: Song) {
        guard let row = selectedIndexPath?.row else {
            return
        }
        SongsController.sharedInstance.editSongAtIndex(row, withSongInfo: editedSong)
//        SongsController.sharedInstance.editSongAtIndex(songsTableView.indexPathForSelectedRow!.row, withSongInfo: song)
        //TODO: See if indexPathForSelectedRow is a better solution
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        SongsController.sharedInstance.removeSong(index: indexPath.row)
        songs = SongsController.sharedInstance.getAllSongs()
        
        //TODO: to be looked into
//        tableView.beginUpdates()
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//        tableView.endUpdates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueDestinaion = (segue.destination as? AddOrEditSongViewController)
        
        guard segueDestinaion != nil else {
            return
        }
        segueDestinaion?.delegate = self
        
        if segue.identifier == "EditSongSegue" {
            segueDestinaion?.song = SongsController.sharedInstance.getAllSongs()[selectedIndexPath!.row]
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            songs = SongsController.sharedInstance.getAllSongs()
            songsTableViewLabel.text = ""
            
            return
        }
        
        var filteredSongs: [Song] = []
        
        for song: Song in SongsController.sharedInstance.getAllSongs() {
            if song.name == searchBar.text {
                filteredSongs.append(song)
            }
        }
        
        if filteredSongs.count == 0 {
            songsTableViewLabel.text = "No matching songs"
        } else {
            songsTableViewLabel.text = "\(filteredSongs.count) matching songs"
        }
        
        songs = filteredSongs
    }
    
    private func formatedSongDuration(duration: Int) -> String {
        var hours = 0
        var minutes = 0
        var seconds = 0
        
        minutes = duration / 60
        seconds = duration % 60
        
        if minutes >= 60 {
            hours = minutes / 60
            minutes = minutes % 60
        }
        var result = "\(minutes):\(seconds)"
        
        if hours > 0 {
            result = "\(hours):\(result)"
        }
        return result
    }
}
