//
//  SongLyricAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation

public struct SongLyricAction: NeteaseCloudMusicAction {
    public struct SongLyricParameters: Encodable {
        public var id: Int
        public var lv: Int = -1
        public var kv: Int = -1
        public var tv: Int = -1
    }
    public typealias Parameters = SongLyricParameters
    public typealias Response = SongLyricResponse

    public var uri: String { "/weapi/song/lyric" }
    public let parameters: Parameters
    public let responseType = Response.self
}

public struct SongLyricResponse: NeteaseCloudMusicResponse {
    public struct Lyric: Codable {
        public var lyric: String
        public var version: Int
    }
    public var code: Int
    public var klyric: Lyric
    public var lrc: Lyric
    public var qfy: Bool
    public var sfy: Bool
    public var sgc: Bool
    public var tlyric: Lyric
    public var message: String?
}
