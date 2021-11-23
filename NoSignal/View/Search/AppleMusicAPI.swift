//
//  AppleMusicAPI.swift
//  NoSignal
//
//  Created by student9 on 2021/11/23.
//

import StoreKit
import Foundation
import SwiftyJSON

class AppleMusicAPI {
    static let shared = AppleMusicAPI()
    static let developerToken = "Your Developer token for Music Access"
    
    var storeFrontId: String {
        var storeFrontID: String?
        let musicURL = URL(string: "https://api.music.apple.com/v1/me/storefront")!
        var musicRequest = URLRequest(url: musicURL)
        
        musicRequest.httpMethod = "GET"
        musicRequest.addValue("Bearer \(AppleMusicAPI.developerToken)", forHTTPHeaderField: "Autherization")
        musicRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")
        let group = DispatchGroup()
        
        group.enter()
        URLSession.shared.dataTask(with: musicRequest) { data, response, error in
            guard error == nil else {
                print("\(String(describing: error))")
                group.leave()
                return
            }
            
            if let json = try? JSON(data: data!) {
                if let result = (json["data"]).array {
                    if let id = (result[0].dictionaryValue)["id"] {
                        storeFrontID = id.stringValue
                    }
                }
            }
            group.leave()
        }.resume()
        group.wait()
        
        // if get method fails
        return storeFrontID!
    }
    
    var userToken: String = {
        var userToken: String?
        
        let group = DispatchGroup()
        
        group.enter()
        SKCloudServiceController().requestUserToken(forDeveloperToken: AppleMusicAPI.developerToken) {
            token, error in
            guard error == nil else {
                print("\(String(describing: error))")
                group.leave()
                return
            }
            userToken = token
            group.leave()
        }
        group.wait()
    
        // if get method fails
        return userToken!
    }()
    
    func search(query: String) -> [Song] {
        var songs = [Song]()
        let musicURL = URL(string: "https://api.music.apple.com/v1/catalog\(storeFrontId)/search?term= \(query.replacingOccurrences(of: " ", with: "+").replacingOccurrences(of: "\'", with: "" ).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&types=songs&limit=25")!
        var musicRequest = URLRequest(url: musicURL)
        musicRequest.httpMethod = "GET"
        musicRequest.addValue("Bearer \(AppleMusicAPI.developerToken)", forHTTPHeaderField: "Authorization")
        
        let group = DispatchGroup()
        group.enter()
        URLSession.shared.dataTask(with: musicRequest) { data, response, error in
            guard error == nil else {
                print("\(String(describing: error))")
                group.leave()
                return
            }
            
            if let json = try? JSON(data: data!) {
                if let result = (json["results"]["songs"]["data"]).array {
                    for song in result {
                        let attributes = song["attributes"]
                        let song = Song(id: attributes["playParams"]["id"].string ?? "",
                                        name: attributes["name"].string ?? "",
                                        artist: attributes["artistName"].string ?? "",
                                        artworkUrl: attributes["artwork"]["url"].string ?? "")
                        songs.append(song)
                    }
                }
            }
            group.leave()
        }.resume()
        group.wait()
        return songs
    }
}

