//
//  ArtistHotSongsAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import Foundation

public struct ArtistHotSongsResponse: NeteaseCloudMusicResponse {
    public struct HotSong: Codable {
        public struct Quality: Codable {
            public var bitrate: Int
            public var dfsId: Int
            public var `extension`: String
            public var id: Int
            public var name: String?
            public var playTime: Int
            public var size: Int
            public var sr: Int
            public var volumeDelta: Double
        }
        public var album: AlbumResponse
        public var alias: [String]
        public var artists: [ArtistResponse]
//        public var audition: Any?
        public var bMusic: Quality?
        public var copyFrom: String
        public var copyrightId: Int
//        public var crbt: Any?
        public var dayPlays: Int
        public var disc: String
        public var duration: Int
        public var fee: Int
        public var ftype: Int
        public var hearTime: Int
        public var hMusic: Quality?
        public var id: Int
        public var lMusic: Quality?
        public var mark: Int
        public var mMusic: Quality?
        public var mp3Url: String
        public var mvid: Int
        public var name: String
        public var no: Int
//        public var noCopyrightRcmd: Any?
        public var originCoverType: Int
//        public var originSongSimpleData: Any?
        public var playedNum: Int
        public var popularity:Int
//        public var ringtone: Any?
//        public var rtUrl: Any?
//        public var rtUrls: Any?
        public var rtype:Int
//        public var rurl: Any?
        public var score: Int
        public var starred: Bool
        public var starredNum: Int
        public var status: Int
    }
    public var artist: ArtistResponse
    public var code: Int
    public var hotSongs: [HotSong]
    public var more: Bool
    public var message: String?
}


public struct ArtistHotSongsAction: NeteaseCloudMusicAction {
    public typealias Parameters = EmptyParameters
    public typealias Response = ArtistHotSongsResponse

    public let id: Int
    public var uri: String { "/weapi/artist/\(id)" }
    public let parameters = Parameters()
    public let responseType = Response.self
}
