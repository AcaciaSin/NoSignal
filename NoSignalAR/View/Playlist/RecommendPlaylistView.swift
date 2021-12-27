//
//  RecommendPlaylistView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/24.
//

import SwiftUI

extension RecommendPlaylistResponse.RecommendPlaylist: Identifiable {
    
}

struct RecommendPlaylistView: View {
    let playlist: [RecommendPlaylistResponse.RecommendPlaylist]
    @State private var playlistDetailId: Int = 0
    @State private var showPlaylistDetail: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            NavigationLink (
                destination: FetchedPlaylistDetailView(id: Int(playlistDetailId)),
                isActive: $showPlaylistDetail,
                label: {EmptyView()})
            HStack {
                Text("推荐歌单")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("(\(playlist.count))")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(Axis.Set.horizontal, showsIndicators: true) {
                let rows: [GridItem] = [.init(.adaptive(minimum: 130))]
                LazyHGrid(rows: rows) {
                    Button(action: {
                        playlistDetailId = 0
                        showPlaylistDetail.toggle()
                    }, label: {
                        CommonGridItemView(CommonGridItemConfiguration(id: 0, name: "每日推荐", picUrl: nil, subscribed: false))
                            .padding(.vertical)
                    })
                    ForEach(playlist) { (item) in
                        Button(action: {
                            playlistDetailId = item.id
                            showPlaylistDetail.toggle()
                        }, label: {
                            CommonGridItemView(item)
                                .padding(.vertical)
                        })
                    }
                }
            }
        }
    }
}


