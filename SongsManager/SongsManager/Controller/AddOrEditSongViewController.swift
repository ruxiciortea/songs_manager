//
//  AddSongViewController.swift
//  SongsManager
//
//  Created by user on 22/11/2017.
//  Copyright © 2017 Ruxi. All rights reserved.
//

import UIKit

protocol AddSongViewControllerDelegate: class {
    func didAddSong(_ newSong: Song)
    func didEditSong(_ editedSong: Song)
}

class AddOrEditSongViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    var delegate: AddSongViewControllerDelegate?
    var song: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let song = song else {
            return
        }
        
        nameTextField.text = song.name
        artistTextField.text = song.artist
        albumTextField.text = song.album
        durationTextField.text = "\(song.duration)"
        
        saveButton.isEnabled = true
        saveButton.setTitle("Edit", for: .normal)
    }
    
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        
        if nameTextField.text?.isEmpty == false &&
        artistTextField.text?.isEmpty == false &&
        albumTextField.text?.isEmpty == false &&
        durationTextField.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let name: String = self.nameTextField.text!
        let artist: String = self.artistTextField.text!
        let album: String = self.albumTextField.text!
        let duration = Int(self.durationTextField.text!)!
        
        let newSong = Song(name: name, artist: artist, album: album, duration: duration)
        
        if self.song == nil {
            self.delegate?.didAddSong(newSong)
        } else {
            self.delegate?.didEditSong(newSong)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
