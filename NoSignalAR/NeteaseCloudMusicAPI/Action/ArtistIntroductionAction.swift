//
//  ArtistIntroductionAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import Foundation

public struct ArtistIntroductionResponse: NeteaseCloudMusicResponse {
    public struct Introduction: Codable {
        public var ti: String
        public var txt: String
    }
    public struct TopicData: Codable {
        
    }
    public var briefDesc: String
    public var code: Int
    public var count: Int
    public var introduction: [Introduction]
    public var topicData: [TopicData]?
    public var message: String?
}

extension ArtistIntroductionResponse {
    var desc: String {
        let introduction = introduction.map { item in
            "\(item.ti)\n\(item.txt)"
        }.joined(separator: "\n")
        return "\(briefDesc)\n\(introduction)"
    }
}

public struct ArtistIntroductionAction: NeteaseCloudMusicAction {
    public struct ArtisIntroductionParameters: Encodable {
        public var id: Int
    }
    public typealias Parameters = ArtisIntroductionParameters
    public typealias Response = ArtistIntroductionResponse

    public var uri: String { "/weapi/artist/introduction" }
    public let parameters: Parameters
    public let responseType = Response.self
}
