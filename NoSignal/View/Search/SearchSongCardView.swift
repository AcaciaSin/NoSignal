//
//  SearchSongCardView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/25.
//

import SwiftUI
import Kingfisher
import SDWebImageSwiftUI

struct SearchSongCardView: View {
    @ObservedObject var song: SongViewModel
    @State var artwork: UIImage = UIImage(named: "music_background") ??  UIImage()
    @State var manager: ImageManager?
    @State var choosePlaylistOptionsPresented = false
    
    var body: some View {
        HStack {
//            WebImage(url: URL(string: song.artworkUrl))
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 100, height: 100)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//
            KFImage(URL(string: song.artworkUrl))
                .placeholder({
                        Image("PlaceholderImage")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                    }
                )
                .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 100 * UIScreen.main.scale, height: 100 * UIScreen.main.scale)))
              .fade(duration: 0.25)
              .onProgress { receivedSize, totalSize in  }
              .onSuccess { result in  }
              .onFailure { error in }
              .resizable()
              .renderingMode(.original)
              .aspectRatio(contentMode: .fill)
              .clipShape(RoundedRectangle(cornerRadius: 10))
//              .modifier(NEUBorderModifier(shape: shape, borderWidth: style.borderWidth, style: style.type))
              .frame(width: 100, height: 100)
            
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
