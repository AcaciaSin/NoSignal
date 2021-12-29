//
//  CommonGridItemView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/24.
//

import SwiftUI
import Combine

struct CommonGridItemView: View {
    @ObservedObject var configuration: CommonGridItemConfiguration
    
    init(_ configuration: CommonGridItemConfiguration) {
        self.configuration = configuration
    }
    init(_ item: Album) {
        self.configuration = CommonGridItemConfiguration(item)
    }
    init(_ model: AlbumSublistResponse.Album) {
        self.configuration = CommonGridItemConfiguration(model)
    }
    init(_ item: ArtistSublistResponse.Artist) {
        self.configuration = CommonGridItemConfiguration(item)
    }
    init(_ item: PlaylistResponse) {
        self.configuration = CommonGridItemConfiguration(item)
    }
    init(_ item: MV) {
        self.configuration = CommonGridItemConfiguration(item)
    }
    init(_ item: Playlist) {
        self.configuration = CommonGridItemConfiguration(item)
    }
    init(_ item: PlaylistViewModel) {
        self.configuration = CommonGridItemConfiguration(item)
    }
    init(_ item: RecommendPlaylistResponse.RecommendPlaylist) {
        self.configuration = CommonGridItemConfiguration(item)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            RectangleCoverView(configuration.picUrl, style: CoverStyle(size: .medium, shape: .rectangle))
                .padding()
            Group {
                Text(configuration.name ?? "Playlist Unknown")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .padding(.leading)
                    .lineLimit(1)
                    .frame(width: 150, alignment: .topLeading)
//                    .foregroundColor(.accentColor)
            }
//            .padding(.leading)
//            .padding(.top, 2)
        }
    }
}


class CommonGridItemConfiguration: ObservableObject {
    var id: Int
    var name: String?
    var picUrl: String?
    var subscribed: Bool?
    init(id: Int, name: String, picUrl: String?, subscribed: Bool) {
        self.id = id
        self.name = name
        self.picUrl = picUrl
        self.subscribed = subscribed
    }
    init(_ item: Album) {
        self.id = Int(item.id)
        self.name = item.name
        self.picUrl = item.picUrl
        self.subscribed = nil
    }
    init(_ model: AlbumSublistResponse.Album) {
        self.id = model.id
        self.name = model.name
        self.picUrl = model.picUrl
        self.subscribed = true
    }
    init(_ model: ArtistSublistResponse.Artist) {
        self.id = model.id
        self.name = model.name
        self.picUrl = model.img1v1Url
        self.subscribed = nil
    }
    init(_ item: PlaylistResponse) {
        self.id = item.id
        self.name = item.name
        self.picUrl = item.coverImgUrl
        self.subscribed = item.subscribed
    }
    init(_ item: MV) {
        self.id = Int(item.id)
        self.name = item.name
        self.picUrl = item.imgurl
        self.subscribed = item.subed
    }
    init(_ item: Playlist) {
        self.id = Int(item.id)
        self.name = item.name
        self.picUrl = item.coverImgUrl
        self.subscribed = item.subscribed
    }
    init(_ item: PlaylistViewModel) {
        self.id = Int(item.id)
        self.name = item.name
        self.picUrl = item.coverImgUrl
        self.subscribed = item.subscribed
    }
    init(_ item: RecommendPlaylistResponse.RecommendPlaylist) {
        self.id = item.id
        self.name = item.name
        self.picUrl = item.picUrl
        self.subscribed = nil
    }
}

