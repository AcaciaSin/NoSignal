//
//  SongLikeAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation

public struct SongLikeResponse: NeteaseCloudMusicResponse {
    public var code: Int
    public var playlistId: Int
//    public var songs: [Any]
    public var message: String?
}

public struct SongLikeAction: NeteaseCloudMusicAction {
    public struct SongLikeParameters: Encodable {
        public var alg: String = "itembased"
        public var trackId: Int
        public var like: Bool
        public var time: Int = 3
    }
    public typealias Parameters = SongLikeParameters
    public typealias Response = SongLikeResponse

    public var uri: String { "/weapi/radio/like" }
    public let parameters: Parameters
    public let responseType = Response.self
}
