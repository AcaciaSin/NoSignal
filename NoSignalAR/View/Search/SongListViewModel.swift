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
    // 自动监视 KVO
    @Published var searchTerm: String = ""
    @Published public private(set) var songs: [SongViewModel] = []
    
    private let dataModel: DataModel = DataModel()
    private var disposables = Set<AnyCancellable>()
    
    init() {
        // Combine 响应式框架，用来处理随时间变化的事件
        $searchTerm
            .sink(receiveValue: loadSongs(searchTerm:)) // sink 接收值, receiveValue 收到值后执行闭包
            .store(in: &disposables)                    // 异步的订阅需要保存
    }
    
    private func loadSongs(searchTerm: String) {
        songs.removeAll()
        // Itunes API search
        dataModel.loadSongs(searchTerm: searchTerm) { songs in
            songs.forEach { self.appendSong($0) }
        }
    }
    

    private func appendSong(_ song: Songs) {
        let songViewModel = SongViewModel(song: song)
        // 主线程更新 UI
        DispatchQueue.main.async {
            self.songs.append(songViewModel)
        }
    }
}


// Identifiable 唯一标识
// ObservableObject 观测对象
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
