//
//  PlaylistCreateAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation

public struct PlaylistCreateAction: NeteaseCloudMusicAction {
    public enum Privacy: Int, Codable {
        case common = 0
        case privacy = 10
    }
    public struct PlaylistCreateParameters: Encodable {
        public var name: String
        public var privacy: Privacy
    }
    public typealias Parameters = PlaylistCreateParameters
    public typealias Response = PlaylistCreateResponse

    public var uri: String { "/weapi/playlist/create" }
    public let parameters: Parameters
    public let responseType = Response.self
}


public struct PlaylistCreateResponse: NeteaseCloudMusicResponse {
    public var code: Int
    public var id: Int
    public var playlist: PlaylistResponse
    public var message: String?
}
