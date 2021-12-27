//
//  CloudSongAddAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import Foundation

public struct CloudSongAddResponse: NeteaseCloudMusicResponse {
    public var code: Int
    public var message: String?
}


public struct CloudSongAddAction: NeteaseCloudMusicAction {
    public struct CloudSongAddParameters: Encodable {
        var songid: Int
    }
    public typealias Parameters = CloudSongAddParameters
    public typealias Response = CloudSongAddResponse
    public var host: String { cloudHost }
    public var uri: String { "/weapi/cloud/pub/v2"}
    public let parameters: Parameters
    public let responseType = Response.self
}
