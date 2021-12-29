//
//  SubedAlbumsView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/24.
//

import SwiftUI

struct SubedAlbumsView: View {
    let albums: [AlbumSublistResponse.Album]
    @State private var albumDetailId: Int = 0
    @State private var showAlbumDetail: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: FetchedAlbumDetailView(id: albumDetailId),
                isActive: $showAlbumDetail,
                label: {EmptyView()})
            HStack {
                Text("收藏的专辑")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("(\(albums.count))")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            ScrollView(Axis.Set.horizontal) {
                let rows: [GridItem] = [.init(.adaptive(minimum: 130))]
                LazyHGrid(rows: rows) {
                    ForEach(albums) { item in
                        Button(action: {
                            albumDetailId = Int(item.id)
                            showAlbumDetail.toggle()
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

#if DEBUG
struct AlbumSublistView_Previews: PreviewProvider {
    static var previews: some View {
        SubedAlbumsView(albums: [AlbumSublistResponse.Album]())
    }
}
#endif
