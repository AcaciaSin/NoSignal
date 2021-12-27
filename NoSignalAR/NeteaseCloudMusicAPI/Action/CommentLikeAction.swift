//
//  CommentLikeAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import Foundation

public struct CommentLikeResponse: NeteaseCloudMusicResponse {
    public var code: Int
    public var message: String?
}

public struct CommentLikeAction: NeteaseCloudMusicAction {
    public struct CommentLikeParameters: Encodable {
        public var threadId: String
        public var commentId: Int
        
        init(threadId: Int, commentId: Int, commentType: CommentType) {
            self.threadId = commentType.rawValue + String(commentId)
            self.commentId = commentId
        }
    }
    public typealias Parameters = CommentLikeParameters
    public typealias Response = CommentLikeResponse

    public var like: Bool
    public var uri: String { "/weapi/v1/comment/\(like ? "like" : "unlike")" }
    public let parameters: Parameters
    public let responseType = Response.self
}
