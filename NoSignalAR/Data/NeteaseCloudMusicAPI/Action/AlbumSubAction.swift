//
//  AlbumSubAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import Foundation

public struct AlbumSubResponse: NeteaseCloudMusicResponse {
    public var code: Int
    public var time: Int
    public var message: String?
}


public struct AlbumSubAction: NeteaseCloudMusicAction {
    public struct AlbumSubParameters: Encodable {
        var id: Int
    }
    public typealias Parameters = AlbumSubParameters
    public typealias Response = AlbumSubResponse
    
    public var uri: String { "/weapi/album/\(sub ? "sub" : "unsub")"}
    public let parameters: Parameters
    public let responseType = Response.self
    
    public let sub: Bool
}
