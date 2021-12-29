//
//  AlbumSublistAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import Foundation

public struct AlbumSublistResponse: NeteaseCloudMusicResponse {
    public struct Album: Codable {
        public var alias: [String]
        public var artists: [ArtistResponse]
        public var id: Int
        public var msg: [String]
        public var name: String
        public var picId: Int
        public var picUrl: String
        public var size: Int
        public var subTime: Int
        public var transNames: [String]
    }
    public var code: Int
    public var count: Int
    public var data: [Album]
    public var hasMore: Bool
    public var paidCount: Int
    public var message: String?
}

extension AlbumSublistResponse.Album: Identifiable {
    
}

public struct AlbumSublistAction: NeteaseCloudMusicAction {
    public struct AlbumSublistParameters: Encodable {
        public var limit: Int
        public var offset: Int
        public var total: Bool = true
    }
    public typealias Parameters = AlbumSublistParameters
    public typealias Response = AlbumSublistResponse

    public let uri: String = "/weapi/album/sublist"
    public let parameters: Parameters
    public let responseType = Response.self
}
