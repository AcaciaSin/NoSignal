//
//  CloudUploadTokenAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import Foundation

public struct CloudUploadTokenResponse: NeteaseCloudMusicResponse {
    public struct Result: Codable {
        public var bucket: String
        public var docId: String
        public var objectKey: String
        public var resourceId: Int
        public var token: String
    }
    public var code: Int
    public var message: String?
    public var result: Result
}


public struct CloudUploadTokenAction: NeteaseCloudMusicAction {
    public struct CloudUploadTokenParameters: Encodable {
        var bucket: String = ""
        var ext: String =  "mp3"
        var filename: String
        var local: Bool = false
        var nos_product: Int = 3
        var type: String = "audio"
        var md5: String
    }
    public typealias Parameters = CloudUploadTokenParameters
    public typealias Response = CloudUploadTokenResponse
    public var uri: String { "/weapi/nos/token/alloc"}
    public let parameters: Parameters
    public let responseType = Response.self
}
