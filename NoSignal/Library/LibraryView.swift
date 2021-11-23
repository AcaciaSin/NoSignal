//
//  LibraryView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/19.
//

import SwiftUI
import MediaPlayer

struct LibraryView: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        NavigationView {
            List {
                ForEach(model.librarySons, id: \.self) { song in
                    SongCardView(song: song)
                        .environmentObject(model)
//                        .onTapGesture {
//                            let desc =
//                            MPMusicPlayerMediaItemQueueDescriptor(itemCollection: MPMediaItemCollection(items: [song]))
//                            model.musicPlayer.setQueue(with: desc)
//                            model.musicPlayer.play()
//                        }
                }
            }
            .navigationBarTitle(Text("Library"), displayMode: .automatic)
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
