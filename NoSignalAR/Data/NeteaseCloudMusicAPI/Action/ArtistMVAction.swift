//
//  ArtistMVAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import Foundation

public struct ArtistMVResponse: NeteaseCloudMusicResponse {
    public struct MV: Codable {
        public struct Artist: Codable {
            public var albumSize: Int
            public var alias: [String]
            public var briefDesc: String
            public var id: Int
            public var img1v1Id: Int
            public var img1v1Id_str: String?
            public var img1v1Url: String
            public var musicSize: Int
            public var name: String
            public var picId: Int
            public var picUrl: String
            public var topicPerson: Int
            public var trans: String
        }
        
        public var artist: Artist
        public var artistName: String
        public var duration: Int
        public var id: Int
        public var imgurl: String
        public var imgurl16v9: String
        public var name: String
        public var playCount: Int
        public var publishTime: String
        public var status: Int
        public var subed: Bool
    }
    public var code: Int
    public var hasMore: Bool
    public var mvs: [MV]
    public var time: Int
    public var message: String?
}


public struct ArtistMVAction: NeteaseCloudMusicAction {
    public struct ArtistMVParameters: Encodable {
        public var artistId: Int
        public var limit: Int
        public var offset: Int
        public var total: Bool
    }
    public typealias Parameters = ArtistMVParameters
    public typealias Response = ArtistMVResponse

    public var uri: String { "/weapi/artist/mvs" }
    public let parameters: Parameters
    public let responseType = Response.self
}
