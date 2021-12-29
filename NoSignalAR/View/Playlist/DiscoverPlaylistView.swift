//
//  DiscoverPlaylistView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/24.
//

import SwiftUI

struct DiscoverPlaylistView: View {
    @EnvironmentObject private var store: Store
    @ObservedObject var viewModel: DiscoverPlaylistViewModel

    @State private var selection: Int = 0
    @State private var subSelection: String?
    @State private var showCategories: Bool = true
    
    @State private var playlistDetailId: Int = 0
    @State private var showPlaylistDetail: Bool = false
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination: FetchedPlaylistDetailView(id: playlistDetailId),
                isActive: $showPlaylistDetail,
                label: { EmptyView() })
            VStack {
                HStack {
                    BackWardButton()
                    Spacer()
                    MyNavigationBarTitleView("发现歌单")
                    Spacer()
                    PlayingNowButtonView()
                }
                .padding(.horizontal)
                .onAppear {
                    selection = viewModel.catalogue.count - 1
                    //                    Store.shared.dispatch(.playlist(category: viewModel.subcategory))
                }
                Picker(selection: $selection, label: Text("")) /*@START_MENU_TOKEN@*/{
                    ForEach(viewModel.catalogue, id: \.id) { item in
                        Text("\(item.name)").tag(item.id)
                    }
                }/*@END_MENU_TOKEN@*/
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .onChange(of: selection, perform: { value in
                    if value == viewModel.catalogue.last?.id {
                        viewModel.playlistRequest(cat: viewModel.catalogue.last!.name)
                    }
                    subSelection = nil
                })
                
                if selection != viewModel.catalogue.last?.id && viewModel.catalogue.count > 0 {
                    MultilineHStack(viewModel.catalogue[selection].subs) { item in
                        Button(action: {
                            subSelection = item
                            viewModel.playlistRequest(cat: item)
                        }, label: {
                            Text(item)
                                .foregroundColor(item == subSelection ? Color.white : Color.black)
                                .padding(.horizontal)
                                .background(Color.orange)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        })
                    }
                    .padding(.horizontal)
                }
                
                if viewModel.requesting {
                    Text("Loading")
                    Spacer()
                } else {
                    VGridView(viewModel.playlists, gridColumns: 3) { item in
                        Button(action: {
                            playlistDetailId = item.id
                            showPlaylistDetail = true
                        }, label: {
                            CommonGridItemView(item)
                        })
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

