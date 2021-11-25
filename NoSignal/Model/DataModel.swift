//
//  Data.swift
//  NoSignal
//
//  Created by student9 on 2021/11/24.
//

// use:
// https:\\itunes.apple.com\search?term=coldplay&entity=song

import Foundation

class DataModel {
    private var dataTask: URLSessionDataTask?
    
    func loadSongs(searchTerm: String, completion: @escaping(([Songs]) -> Void)) {
        dataTask?.cancel()
        guard let url = buildUrl(forTerm: searchTerm) else {
            completion([])
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion([])
                return
            }
            
            // todo: change to swiftyJSON
            if let songResponse = try? JSONDecoder().decode(SongResponse.self, from: data) {
                completion(songResponse.songs)
            }
            print(data)
        }
        dataTask?.resume()
    }
    
    private func buildUrl(forTerm searchTerm: String) -> URL? {
        guard !searchTerm.isEmpty else { return nil }
        
        let queryItems = [
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "entity", value: "song"),
        ]
        var components = URLComponents(string: "https://itunes.apple.com/search")
        components?.queryItems  = queryItems
        
        return components?.url
    }
}


struct SongResponse: Decodable {
    let songs: [Songs]
    
    enum CodingKeys: String, CodingKey {
        case songs = "results"
    }
}

struct Songs: Decodable {
    let id: Int
    let trackName: String
    let artistName: String
    let artworkUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName
        case artistName
        case artworkUrl = "artworkUrl100"
    }
}
