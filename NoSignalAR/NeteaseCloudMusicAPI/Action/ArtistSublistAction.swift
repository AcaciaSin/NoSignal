//
//  ArtistSublistAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import Foundation

public struct ArtistSublistResponse: NeteaseCloudMusicResponse {
    public struct Artist: Codable {
        public let albumSize: Int
        public let alias: [String]
        public let id: Int
        public let img1v1Url: String
        public let info: String
        public let mvSize: Int
        public let name: String
        public let picId: Int
        public let picUrl: String
        public let trans: String?
    }
    public let code: Int
    public let count: Int
    public let data: [Artist]
    public let hasMore: Bool
    public var message: String?
}

extension ArtistSublistResponse.Artist: Identifiable { }

public struct ArtistSublistAction: NeteaseCloudMusicAction {
    public struct ArtistSublistParameters: Encodable {
        public var limit: Int
        public var offset: Int
        public var total: Bool = true
    }
    public typealias Parameters = ArtistSublistParameters
    public typealias Response = ArtistSublistResponse

    public let uri: String = "/weapi/artist/sublist"
    public let parameters: Parameters
    public let responseType = Response.self
}
