//
//  LoginRefreshAction.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import Foundation

public struct LoginRefreshAction: NeteaseCloudMusicAction {
    public typealias Parameters = EmptyParameters
    public typealias Response = LoginRefreshResponse

    public var uri: String { "/weapi/login/token/refresh" }
    public let parameters = Parameters()
    public let responseType = Response.self
}

public struct LoginRefreshResponse: NeteaseCloudMusicResponse {
    public var code: Int
    public var message: String?
}
