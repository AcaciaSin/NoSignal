//
//  SongDetailAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation

public struct SongDetailAction: NeteaseCloudMusicAction {
    public struct SongDetailParameters: Encodable {
        public var c: String
        public var ids: String
        init(ids: [Int]) {
            let kv: String = ids.map{"{" + "id:" + String($0) + "}"}.joined(separator: ",")
            self.c = "[" + kv + "]"
            self.ids = "[" + ids.map(String.init).joined(separator: ",") + "]"
        }
    }
    public typealias Parameters = SongDetailParameters
    public typealias Response = SongDetailResponse

    public var uri: String { "/weapi/v3/song/detail" }
    public let parameters: Parameters
    public let responseType = Response.self
}

public struct SongDetailResponse: NeteaseCloudMusicResponse {
    public var code: Int
    public var privileges: [PrivilegeResponse]
    public var songs: [SongResponse]
    public var message: String?
}
