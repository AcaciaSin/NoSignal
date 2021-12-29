//
//  MVDetasilAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation

public struct MVDetailAction: NeteaseCloudMusicAction {
    public struct MVDetailParameters: Encodable {
        public var id: Int
    }
    public typealias Parameters = MVDetailParameters
    public typealias Response = MVDetailResponse

    public var uri: String { "/weapi/v1/mv/detail" }
    public let parameters: Parameters
    public let responseType = Response.self
}

public struct MVDetailResponse: NeteaseCloudMusicResponse {
    public struct MVData: Codable {
        public struct Br: Codable {
            public var br, point, size: Int
        }
        public var artistId: Int
        public var artistName: String
//        public var artists: [Artist]
        public var briefDesc: String
        public var brs: [Br]
        public var commentCount: Int
        public var commentThreadId: String
        public var cover: String
        public var coverId: Double
        public var coverId_str: String
        public var desc: String
        public var duration, id: Int
        public var name: String
        public var nType, playCount: Int
//        public var price: Any?
        public var publishTime: String
        public var shareCount, subCount: Int
//        public var videoGroup: [Any]
    }
    public struct MP: Codable {
        var cp, dl, fee, id: Int
//        var msg: Any?
        var mvFee: Int
        var normal: Bool
        var payed, pl, sid, st: Int
        var unauthorized: Bool
    }
    public var bufferPic: String
    public var bufferPicFS: String
    public var code: Int
    public var data: MVData
    public var loadingPic: String
    public var loadingPicFS: String
    public var mp: MP
    public var subed: Bool
    public var message: String?
}
