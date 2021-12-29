//
//  PlaylistTracksAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation

public struct PlaylistTracksAction: NeteaseCloudMusicAction {
    public struct PlaylistTracksParameters: Encodable {
        public enum Option: String, Codable {
            case add
            case del
        }
        public var op: Option
        public var pid: Int
        public var trackIds: String
        
        init(pid: Int, ids: [Int], op: Option) {
            self.op = op
            self.pid = pid
            self.trackIds = "[" + ids.map(String.init).joined(separator: ",") + "]"
        }
    }
    public typealias Parameters = PlaylistTracksParameters
    public typealias Response = PlaylistTracksResponse
    
    public var uri: String { "/weapi/playlist/manipulate/tracks" }
    public let parameters: Parameters
    public let responseType = Response.self
}

public struct PlaylistTracksResponse: NeteaseCloudMusicResponse {
    public var cloudCount: Int?
    public var code: Int
    public var count: Int?
    public var trackIds: String?
    public var message: String?
}
