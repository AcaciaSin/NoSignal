//
//  ArtistSublistView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/23.
//

import SwiftUI

struct ArtistSublistView: View {
    let artists: [ArtistSublistResponse.Artist]
    @State private var artistId: Int = 0
    @State private var showArtistDetail: Bool = false
    private let rows: [GridItem] = [.init(.adaptive(minimum: 130))]
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: FetchedArtistDetailView(id: artistId),
                isActive: $showArtistDetail,
                label: {EmptyView()})
            HStack {
                Text("收藏的歌手")
                    .font(.largeTitle)
                    .fontWeight(.bold)
//                    .foregroundColor(Color.mainText)
                Spacer()
                Text("\(artists.count)收藏的歌手")
//                    .foregroundColor(Color.secondTextColor)
            }
            .padding(.horizontal)
            ScrollView(Axis.Set.horizontal) {
                let rows: [GridItem] = [.init(.adaptive(minimum: 130))]
                LazyHGrid(rows: rows) {
                    ForEach(artists) { item in
                        Button(action: {
                            artistId = Int(item.id)
                            showArtistDetail.toggle()
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
