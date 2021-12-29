//
//  SongURLAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/19.
//

import Foundation

public struct SongURLAction: NeteaseCloudMusicAction {
    public struct SongURLParameters: Encodable {
        public var ids: String
        public var br: Int
        init(ids: [Int], br: Int = 999000) {
            self.ids = "[" + ids.map(String.init).joined(separator: ",") + "]"
            self.br = br
        }
    }
    public typealias Parameters = SongURLParameters
    public typealias Response = SongURLResponse

    public var uri: String { "/weapi/song/enhance/player/url" }
    public let parameters: Parameters
    public let responseType = Response.self
}

public struct SongURLResponse: NeteaseCloudMusicResponse {
    public struct SongData: Codable {
        public var br: Int
        public var canExtend: Bool
        public var code: Int
//        public var encodeType: Any?
        public var expi, fee, flag: Int
//        public var freeTimeTrialPrivilege: FreeTimeTrialPrivilege
//        public var freeTrialInfo: FreeTrialInfo
//        public var freeTrialPrivilege: FreeTrialPrivilege
        public var gain, id: Int
//        public var level: Any?
        public var md5: String?
        public var payed, size: Int
        public var type: String?
//        public var uf: Any?
        public var url: String?
        public var urlSource: Int
    }
    public var code: Int
    public var data: [SongData]
    public var message: String?
}
