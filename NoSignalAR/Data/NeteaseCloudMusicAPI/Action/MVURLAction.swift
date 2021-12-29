//
//  MVURLAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation


public struct MVURLAction: NeteaseCloudMusicAction {
    public struct MVURLParameters: Encodable {
        public var id: Int
        public var r: Int = 1080
    }
    public typealias Parameters = MVURLParameters
    public typealias Response = MVURLResponse

    public var uri: String { "/weapi/song/enhance/play/mv/url" }
    public let parameters: Parameters
    public let responseType = Response.self
}


public struct MVURLResponse: NeteaseCloudMusicResponse {
    public struct MVURLData: Codable {
        public var code: Int
        public var expi: Int
        public var fee: Int
        public var id: Int
        public var md5: String
        public var msg: String
        public var mvFee: Int
//        public var promotionVo: Any?
        public var r: Int
        public var size: Int
        public var st: Int
        public var url: String
    }
    public var code: Int
    public var data: MVURLData
    public var message: String?
}
