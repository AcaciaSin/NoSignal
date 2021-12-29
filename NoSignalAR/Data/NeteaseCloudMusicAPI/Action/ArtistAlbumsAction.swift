//
//  ArtistAlbumsAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import Foundation

public struct ArtistAlbumsResponse: NeteaseCloudMusicResponse {
    public struct ArtistAlbum: Codable {
        public var alias: [String]
        public var artist: ArtistResponse
        public var artists: [ArtistResponse]
        public var blurPicUrl: String?
        public var briefDesc: String?
        public var commentThreadId: String
        public var company: String?
        public var companyId: Int
        public var description: String?
        public var id: Int
        public var isSub: Bool
        public var mark: Int
        public var name: String
        public var onSale: Bool
        public var paid: Bool
        public var pic: Int
        public var picId: Int
        public var picId_str: String?
        public var picUrl: String
        public var publishTime: Int
        public var size: Int
//        public var songs: [Any]
        public var status: Int
        public var subType: String
        public var tags: String
        public var type: String
    }
    public var artist: ArtistResponse
    public var code: Int
    public var hotAlbums: [ArtistAlbum]
    public var more: Bool
    public var message: String?
}


public struct ArtistAlbumsAction: NeteaseCloudMusicAction {
    public struct ArtistAlbumsParameters: Encodable {
        public var limit: Int
        public var offset: Int
        public var total: Bool = true
    }
    public typealias Parameters = ArtistAlbumsParameters
    public typealias Response = ArtistAlbumsResponse

    public let id: Int
    public var uri: String { "/weapi/artist/albums/\(id)" }
    public let parameters: Parameters
    public let responseType = Response.self
}
