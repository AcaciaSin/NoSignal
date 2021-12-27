//
//  RecommendPlaylistAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation
//推荐歌单( 需要登录 )
public struct RecommendPlaylistAction: NeteaseCloudMusicAction {
    public typealias Parameters = EmptyParameters
    public typealias Response = RecommendPlaylistResponse

    public var uri: String { "/weapi/v1/discovery/recommend/resource" }
    public let parameters = Parameters()
    public let responseType = Response.self
}

public struct RecommendPlaylistResponse: NeteaseCloudMusicResponse {
    public struct RecommendPlaylist: Codable {
        public var alg, copywriter: String
        public var createTime: Int
        public var creator: CrteatorResponse?
        public var id: Int
        public var name: String
        public var picUrl: String
        public var playcount, trackCount, type, userId: Int
    }
    public var code: Int
    public var featureFirst: Bool
    public var haveRcmdSongs: Bool
    public var recommend: [RecommendPlaylist]
    public var message: String?
}
