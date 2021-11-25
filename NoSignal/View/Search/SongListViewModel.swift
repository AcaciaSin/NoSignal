//
//  SongListViewModel.swift
//  NoSignal
//
//  Created by student9 on 2021/11/25.
//
import Combine
import SwiftUI
import Foundation

class SongListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published public private(set) var songs: [SongViewModel] = []
    
    private let dataModel: DataModel = DataModel()
    private var disposables = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .sink(receiveValue: loadSongs(searchTerm:))
            .store(in: &disposables)
    }
    
    private func loadSongs(searchTerm: String) {
        songs.removeAll()
        dataModel.loadSongs(searchTerm: searchTerm) { songs in
            songs.forEach { self.appendSong(song: $0) }
        }
    }
    

    private func appendSong(song: Songs) {
        let songViewModel = SongViewModel(song: song)
        DispatchQueue.main.async {
            self.songs.append(songViewModel)
        }
        
    }
}


class SongViewModel: Identifiable, ObservableObject {
    let id: Int
    let trackName: String
    let artistName: String
    let artworkUrl: String
    @Published var artwork: Image?
    
    init(song: Songs) {
        self.id = song.id
        self.trackName = song.trackName
        self.artistName = song.artistName
        self.artworkUrl = song.artworkUrl
    }
}
