//
//  SongLikeListAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation

public struct SongLikeListAction: NeteaseCloudMusicAction {
    public struct SongLikeListParameters: Encodable {
        public var uid: Int
    }
    public typealias Parameters = SongLikeListParameters
    public typealias Response = SongLikeListResponse

    public var uri: String { "/weapi/song/like/get" }
    public let parameters: Parameters
    public let responseType = Response.self
}

public struct SongLikeListResponse: NeteaseCloudMusicResponse {
    public var checkPoint: Int
    public var code: Int
    public var ids: [Int]
    public var message: String?
}
