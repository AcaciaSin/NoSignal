//
//  CloudUploadInfoAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import Foundation

public struct CloudUploadInfoResponse: NeteaseCloudMusicResponse {
    public var code: Int
    public var songId: String
    public var message: String?
}


public struct CloudUploadInfoAction: NeteaseCloudMusicAction {
    public struct CloudUploadInfoParameters: Encodable {
        var album: String = "Unknown"
        var artist: String = "Unknown"
        var bitrate: String = "999000"
        var filename: String
        var md5: String
        var resourceId: Int
        var song: String
        var songid: String
    }
    public typealias Parameters = CloudUploadInfoParameters
    public typealias Response = CloudUploadInfoResponse
    
    public var uri: String { "/weapi/upload/cloud/info/v2"}
    public let parameters: Parameters
    public let responseType = Response.self
}
