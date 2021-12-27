//
//  PlaylistViewModel.swift
//  NoSignal
//
//  Created by student9 on 2021/12/22.
//

import Foundation

struct PlaylistViewModel: Identifiable {
    var count: Int = 0
    var coverImgUrl: String? = nil
    var creator: String = ""
    var creatorId: Int = 0
    var description: String = ""
    var id: Int64 = 0
    var name: String = ""
    var playCount: Int = 0
    var subscribed: Bool = false
    var songs = [SongViewModel]()
    var songsId = [Int64]()
    var userId: Int64 = 0
    
    init() {
        
    }
}
