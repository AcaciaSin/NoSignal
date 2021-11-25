//
//  SearchSongCardView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchSongCardView: View {
    
    @ObservedObject var song: SongViewModel
    @State var artwork: UIImage = UIImage(named: "music_background") ??  UIImage()
    @State var manager: ImageManager?
    @State var choosePlaylistOptionsPresented = false
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: song.artworkUrl))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(song.trackName)
                    .font(.headline)
                    .padding(.bottom, 2)
                Text(song.artistName)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.leading)
            
            Spacer()
        }
        .padding()
    }
}

//struct SearchSongCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchSongCardView()
//    }
//}
