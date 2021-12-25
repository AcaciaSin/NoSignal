//
//  CloudUploadCheckAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import Foundation

public struct CloudUploadCheckResponse: NeteaseCloudMusicResponse {
    public var code: Int
    public var needUpload: Bool
    public var songId: String
    public var message: String?
}


public struct CloudUploadCheckAction: NeteaseCloudMusicAction {
    public struct CloudUploadCheckParameters: Encodable {
        var bitrate: String = "999000"
        var ext: String = ""
        var length: Int
        var md5: String
        var songId: Int = 0
        var version: Int = 1
    }
    public typealias Parameters = CloudUploadCheckParameters
    public typealias Response = CloudUploadCheckResponse
    public var host: String { cloudHost }
    public var uri: String { "/weapi/cloud/upload/check"}
    public let parameters: Parameters
    public let responseType = Response.self
}
