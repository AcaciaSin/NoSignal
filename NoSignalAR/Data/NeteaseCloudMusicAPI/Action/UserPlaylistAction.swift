//
//  UserPlaylistAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation
//用户歌单
public struct UserPlaylistAction: NeteaseCloudMusicAction {
    public struct UserPlaylistParameters: Encodable {
        public var uid: Int
        public var limit: Int
        public var offset: Int
    }
    public typealias Parameters = UserPlaylistParameters
    public typealias Response = UserPlaylistResponse

    public var uri: String { "/weapi/user/playlist" }
    public let parameters: Parameters
    public let responseType = Response.self
}

public struct UserPlaylistResponse: NeteaseCloudMusicResponse {
    public var code: Int
    public var more: Bool
    public var playlist: [PlaylistResponse]
    public var version: String
    public var message: String?
}
