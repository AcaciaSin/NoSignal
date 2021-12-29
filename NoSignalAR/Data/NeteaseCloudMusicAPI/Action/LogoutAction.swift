//
//  LogoutAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import Foundation

public struct LogoutAction: NeteaseCloudMusicAction {
    public typealias Parameters = EmptyParameters
    public typealias Response = LogoutResponse

    public var uri: String { "/weapi/logout" }
    public let parameters = Parameters()
    public let responseType = Response.self
}

public struct LogoutResponse: NeteaseCloudMusicResponse {
    public var code: Int
    public var message: String?
}
