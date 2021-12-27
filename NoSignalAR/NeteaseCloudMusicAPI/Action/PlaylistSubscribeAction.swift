//
//  PlaylistSubscribeAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation

public struct PlaylistSubscribeAction: NeteaseCloudMusicAction {
    public struct PlaylistSubscribeParameters: Encodable {
        public var id: Int
    }
    public typealias Parameters = PlaylistSubscribeParameters
    public typealias Response = PlaylistSubscribeResponse
    
    public let sub: Bool
    public var uri: String { "/weapi/playlist/\(sub ? "subscribe" : "unsubscribe")" }
    public let parameters: Parameters
    public let responseType = Response.self
}

public struct PlaylistSubscribeResponse: NeteaseCloudMusicResponse {
    public var code: Int
    public var message: String?
}
