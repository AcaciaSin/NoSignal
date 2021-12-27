//
//  NeteaseSong.swift
//  NoSignal
//
//  Created by student9 on 2021/12/22.
//

import Foundation

protocol NeteaseAlbumable {
    func asNeteaseAlbum() -> NeteaseAlbum
}

protocol NeteaseArtistable {
    func asNeteaseArtist() -> NeteaseArtist
}

protocol NeteaseSongable {
    func asNeteaseSong() -> NeteaseSong
}

struct NeteaseAlbum: Codable, Identifiable, Equatable {
    var coverURLString: String?
    var id: Int
    var name: String?
}

extension NeteaseAlbum {
    init<Album>(_ album: Album) where Album: NeteaseAlbumable {
        self = album.asNeteaseAlbum()
    }
}

struct NeteaseArtist: Codable, Identifiable, Equatable {
    var id: Int
    var name: String?
}

extension NeteaseArtist {
    init<Artist>(_ artist: Artist) where Artist: NeteaseArtistable {
        self = artist.asNeteaseArtist()
    }
}

struct NeteaseSong: Codable, Identifiable, Equatable {
    var album: NeteaseAlbum?
    var artists: [NeteaseArtist]
    var id: Int
    var name: String?
}

extension NeteaseSong {
    init<Song>(_ song: Song) where Song: NeteaseSongable {
        self = song.asNeteaseSong()
    }
}

extension NeteaseSong: NeteaseSongable {
    func asNeteaseSong() -> NeteaseSong {
        self
    }
}

extension Album: NeteaseAlbumable {
    func asNeteaseAlbum() -> NeteaseAlbum {
        .init(coverURLString: picUrl, id: Int(id), name: name)
    }
}

extension Artist: NeteaseArtistable {
    func asNeteaseArtist() -> NeteaseArtist {
        .init(id: Int(id), name: name)
    }
}

extension Song: NeteaseSongable {
    func asNeteaseSong() -> NeteaseSong {
        .init(album: album?.asNeteaseAlbum(), artists: (artists?.allObjects as? [Artist])?.map(NeteaseArtist.init) ?? [], id: Int(id), name: name)
    }
}

extension NCMSearchSongResponse.Result.Song.Album: NeteaseAlbumable {
    func asNeteaseAlbum() -> NeteaseAlbum {
        .init(coverURLString: nil, id: id, name: name)
    }
}

extension NCMSearchSongResponse.Result.Song.Artist: NeteaseArtistable {
    func asNeteaseArtist() -> NeteaseArtist {
        .init(id: id, name: name)
    }
}

extension NCMSearchSongResponse.Result.Song: NeteaseSongable {
    func asNeteaseSong() -> NeteaseSong {
        .init(album: album.asNeteaseAlbum(), artists: self.artists.map({ $0.asNeteaseArtist() }), id: id, name: name)
    }
}

