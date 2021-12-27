//
//  SongOrderUpdateAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation
//歌单歌曲顺序
public struct SongOrderUpdateAction: NeteaseCloudMusicAction {
    public struct SongOrderUpdateParameters: Encodable {
        public var pid: Int
        public var trackIds: [Int]
        public var op: String = "update"
    }
    public typealias Parameters = SongOrderUpdateParameters
    public typealias Response = SongOrderUpdateResponse

    public var uri: String { "/weapi/playlist/manipulate/tracks" }
    public let parameters: Parameters
    public let responseType = Response.self
}

public struct SongOrderUpdateResponse: NeteaseCloudMusicResponse {
    public var code: Int
    public var message: String?
}
