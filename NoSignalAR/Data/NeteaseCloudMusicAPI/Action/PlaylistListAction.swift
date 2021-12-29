//
//  PlaylistListAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation

public struct PlaylistListAction: NeteaseCloudMusicAction {
    public struct PlaylistListParameters: Encodable {
        public enum Order: String, Codable {
            case hot, new
        }
        public var cat: String
        public var order: Order
        public var limit: Int
        public var offset: Int
        public var total: Bool
    }
    public typealias Parameters = PlaylistListParameters
    public typealias Response = PlaylistListResponse

    public var uri: String { "/weapi/playlist/list" }
    public let parameters: Parameters
    public let responseType = Response.self
}


public struct PlaylistListResponse: NeteaseCloudMusicResponse {
    public var cat: String
    public var code: Int
    public var more: Bool
    public var playlists: [PlaylistResponse]
    public var total: Int
    public var message: String?
}
