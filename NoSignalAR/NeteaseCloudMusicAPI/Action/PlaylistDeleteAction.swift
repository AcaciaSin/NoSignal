//
//  PlaylistDeleteAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation

public struct PlaylistDeleteAction: NeteaseCloudMusicAction {
    public struct PlaylistDeleteParameters: Encodable {
        public var pid: Int
    }
    public typealias Parameters = PlaylistDeleteParameters
    public typealias Response = PlaylistDeleteResponse

    public var uri: String { "/weapi/playlist/delete" }
    public let parameters: Parameters
    public let responseType = Response.self
}

public struct PlaylistDeleteResponse: NeteaseCloudMusicResponse {
    public var code: Int
    public var id: Int
    public var message: String?
}
