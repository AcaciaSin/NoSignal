//
//  CreatedPlaylistView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/24.
//

import SwiftUI
import NeumorphismSwiftUI

struct CreatedPlaylistView: View {
    let playlist: [PlaylistResponse]
    @State private var playlistDetailId: Int = 0
    @State private var showPlaylistDetail: Bool = false
    @State private var showPlaylistCreate: Bool = false
    @State private var showPlaylistManage: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: FetchedPlaylistDetailView(id: playlistDetailId),
                isActive: $showPlaylistDetail,
                label: {EmptyView()})
            HStack {
                Text("创建的歌单")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("(\(playlist.count))")
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
//                Button(action: {
//                    showPlaylistCreate.toggle()
//                }) {
//                    QinSFView(systemName: "folder.badge.plus", size:  .small)
//                        .sheet(isPresented: $showPlaylistCreate) {
//                            PlaylistCreateView(showSheet: $showPlaylistCreate)
//                        }
//                }
//                .buttonStyle(NEUDefaultButtonStyle(shape: Circle()))
            }
            .padding(.horizontal)
            ScrollView(Axis.Set.horizontal, showsIndicators: true) {
                let rows: [GridItem] = [.init(.adaptive(minimum: 130))]
                LazyHGrid(rows: rows) {
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

struct PlaylistCreateView: View {
    @EnvironmentObject private var store: Store
    @Binding var showSheet: Bool
    @State private var name: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showSheet.toggle()
                    }, label: {
                        Text("取消")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    })
                }
                .padding()
                .overlay(
                    Text("创建歌单")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top, 2)
                )
                TextField("歌单名", text: $name)
                    .textFieldStyle(NEUDefaultTextFieldStyle(label: Image(systemName: "folder.badge.plus")))
                    .padding(.leading)
                Button(action: {
                    showSheet.toggle()
                    Store.shared.dispatch(.playlistCreateRequest(name: name))
                }){
                    HStack(spacing: 0.0) {
                        Image(systemName: "folder.badge.plus")
                        Text("创建")
                            .font(.title3)
                            .padding(.horizontal)
                    }
                }
                Spacer()
            }
        }
    }
}
