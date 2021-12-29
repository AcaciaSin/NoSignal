//
//  SubedPlaylistView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/24.
//

import SwiftUI
import NeumorphismSwiftUI

struct SubedPlaylistView: View {
    let playlist: [PlaylistResponse]
    @State private var playlistDetailId: Int = 0
    @State private var showPlaylistDetail: Bool = false
    @State private var showPlaylistManage: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: FetchedPlaylistDetailView(id: playlistDetailId),
                isActive: $showPlaylistDetail,
                label: {EmptyView()})
            HStack {
                Text("收藏的歌单")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("(\(Store.shared.appState.playlist.subedPlaylistIds.count))")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
//                Button(action: {
//                    showPlaylistManage.toggle()
//                }) {
//                    QinSFView(systemName: "lineweight", size:  .small)
//                        .sheet(isPresented: $showPlaylistManage) {
//                            PlaylistManageView(showSheet: $showPlaylistManage)
//                                .environment(\.managedObjectContext, DataManager.shared.context())//sheet 需要传入父环境
//                        }
//                }
//                .buttonStyle(NEUDefaultButtonStyle(shape: Circle()))
            }
            .padding(.horizontal)
            ScrollView(Axis.Set.horizontal, showsIndicators: true) {
                let rows: [GridItem] = [.init(.adaptive(minimum: 130))]
                LazyHGrid(rows: rows) /*@START_MENU_TOKEN@*/{
                    ForEach(playlist) { (item) in
                        Button(action: {
                            playlistDetailId = item.id
                            showPlaylistDetail.toggle()
                        }, label: {
                            CommonGridItemView(item )
                                .padding(.vertical)
                        })
                    }
                }/*@END_MENU_TOKEN@*/
            }
        }
    }
}
