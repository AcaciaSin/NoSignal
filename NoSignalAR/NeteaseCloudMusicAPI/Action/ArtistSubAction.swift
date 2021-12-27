//
//  ArtistSubAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import Foundation

public struct ArtistSubResponse: NeteaseCloudMusicResponse {
    public var code: Int
//    public var data: Any?
    public var message: String?
}


public struct ArtistSubAction: NeteaseCloudMusicAction {
    public struct ArtistSubParameters: Encodable {
        public var artistId: Int
        public var artistIds: [Int]
    }
    public typealias Parameters = ArtistSubParameters
    public typealias Response = ArtistSubResponse

    public var sub: Bool
    public var uri: String { "/weapi/artist/\(sub ? "sub" : "unsub")" }
    public let parameters: Parameters
    public let responseType = Response.self
}
