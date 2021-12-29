//
//  RecommendSongAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation
//推荐歌曲( 需要登录 )
public struct RecommendSongAction: NeteaseCloudMusicAction {
    public typealias Parameters = EmptyParameters
    public typealias Response = RecommendSongsResponse

    public var uri: String { "/weapi/v3/discovery/recommend/songs" }
    public let parameters = Parameters()
    public let responseType = Response.self
}


public struct RecommendSongsResponse: NeteaseCloudMusicResponse {
    public struct RecommendReason: Codable {
        public var reason: String
        public var songId: Int
    }
    public struct DataResponse: Codable {
        public var dailySongs: [SongResponse]
//        public var orderSongs: [Any]
        public var recommendReasons: [RecommendReason]
    }
    public var code: Int
    public var data: DataResponse
    public var message: String?
}
