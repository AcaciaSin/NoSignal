//
//  Model.swift
//  NoSignal
//
//  Created by student9 on 2021/11/19.
//

import Foundation
import MediaPlayer

class Model: ObservableObject {
    
    static let shared = Model()
    
    var musicPlayer = MPMusicPlayerController.applicationQueuePlayer
    
    @Published var isPlaying = false
//    @Published var isShowing = false
    @Published var isPlayerViewPresented = false
    @Published var currentSong : MPMediaItem?
    
    @Published var playlists = [MPMediaItemCollection]()
    @Published var librarySons = [MPMediaItem]()
    
    
}
