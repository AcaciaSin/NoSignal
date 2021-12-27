//
//  PlayingNowView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/24.
//

import SwiftUI
import NeumorphismSwiftUI
import RealityKit

enum PlayingNowBottomType {
    case createdPlaylist
    case playinglist
    case playingStatus
}

struct PlayingNowView: View {
    @EnvironmentObject var store: Store
 
    private var playing: AppState.Playing { store.appState.playing }
    private var playlist: AppState.Playlist { store.appState.playlist }

    @State private var showMore: Bool = false
    @State private var bottomType: PlayingNowBottomType = .playingStatus
    @State private var showComment: Bool = false
    @State private var showArtist: Bool = false
    @State private var artistId: Int = 0
    
    @State private var shwoARMusic: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        ZStack {
            VStack {
                NavigationLink(destination: FetchedArtistDetailView(id: artistId), isActive: $showArtist) {
                    EmptyView()
                }
                if !showMore {
                    HStack {
                        BackWardButton()
                            .matchedGeometryEffect(id: 0, in: namespace)
                        Spacer()
                        QinNavigationBarTitleView("")
                            .transition(.move(edge: .top))
                        Spacer()
                        
                        // AR
                        NavigationLink(destination: ARMusicView(), isActive: $shwoARMusic, label: {EmptyView()})
                        Button(action: {
                            if self.shwoARMusic == false {
                                self.shwoARMusic = true
                            }
                        }){
                            Image(systemName: "eyeglasses")
                                .font(.title)
                        }
                        
                        Button(action: {
                            withAnimation(.default) {
                                showMore = true
                                bottomType = .createdPlaylist
                            }
                        }) {
                            Image(systemName: "plus")
                                .font(.title)
                        }
                        .matchedGeometryEffect(id: 1, in: namespace)
                    }
                    .padding(.horizontal)
                } else {
                    QinNavigationBarTitleView(playing.song?.name ?? "")
                }
                
                ZStack {
                    if showMore {
                        HStack {
                            Button {
                                let id = Int(playing.song?.id ?? 0)
                                let like = !playlist.songlikedIds.contains(id)
                                Store.shared.dispatch(.songLikeRequest(id: id, like: like))
                            } label: {
                                let imageName = playlist.songlikedIds.contains(Int(playing.song?.id ?? 0)) ? "heart.fill" : "heart"
                                QinSFView(systemName: imageName, size: .medium)
                            }
//                            .buttonStyle(NEUDefaultButtonStyle(shape: Circle()))
                            .matchedGeometryEffect(id: 0, in: namespace)
                            Spacer()
                            Button(action: {}) {
                                QinSFView(systemName: "ellipsis")
                            }
                            .matchedGeometryEffect(id: 1, in: namespace)
                        }
                        .padding(.horizontal)
                    }
                    PlayingNowCoverView(showMore: $showMore, bottomType: $bottomType)
                }
                ZStack {
                    let screen = UIScreen.main.bounds
                    if bottomType == .playingStatus {
                        PlayingNowStatusView(showMore: $showMore, showArtist: $showArtist, artistId: $artistId)
//                            .offset(y: bottomType == .playingStatus ? 0 : screen.height)
                            .transition(.move(edge: .bottom))
                    }


                    PlayingNowListView()
                        .offset(y: bottomType == .playinglist ? 0 : screen.height)
                        .transition(.move(edge: .bottom))
                    if bottomType == .createdPlaylist {
                        PlaylistTracksView(playlist: store.appState.playlist.createdPlaylist, showList: $showMore, bottomType: $bottomType)
                        .offset(y: bottomType == .createdPlaylist ? 0 : screen.height)
                        .transition(.move(edge: .bottom))
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .alert(item: $store.appState.error) { error in
            Alert(title: Text(error.localizedDescription))
        }
    }
}


struct PlayinglistView: View {
    let songsId: [Int]
    
    @State private var show: Bool = false
    
    var body: some View {
        FetchedResultsView(entity: Song.entity(), predicate: NSPredicate(format: "%K IN %@", "id", songsId)) { (results: FetchedResults<Song>) in
            ScrollView {
                if let songs = results {
                    LazyVStack {
                        ForEach(songs.sorted(by: { (left, right) -> Bool in
                            let lIndex = songsId.firstIndex(of: Int(left.id))!
                            let rIndex = songsId.firstIndex(of: Int(right.id))!
                            return lIndex > rIndex ? false : true
                        })) { item in
                            QinSongRowView(searchViewModel: .init(item))
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
    }
}

struct PlayingNowStatusView: View {
    @EnvironmentObject private var store: Store
    @EnvironmentObject private var player: Player
    
    private var playing: AppState.Playing { store.appState.playing }

    @State private var showLyric: Bool = true

    
    @Binding var showMore: Bool
    @Binding var showArtist: Bool
    @Binding var artistId: Int
    
    var body: some View {
        VStack {
            VStack {
                Text(playing.song?.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .padding(.bottom, 2)
                HStack {
                    ForEach(playing.song?.artists ?? []) { item in
                        Button(action: {
                            if item.id != 0 {
                                artistId = Int(item.id)
                                showArtist.toggle()
                            }
                        }, label: {
                            Text(item.name ?? "")
                        })
                    }
                }
            }
            .padding()
            ZStack {
                // 歌词
                if showLyric {
                    if let lyric = store.appState.lyric.lyric {
                        LyricView(lyric)
                            .onTapGesture {
                                withAnimation(.default) {
                                    showMore.toggle()
                                }
                            }
                    } else {
                        Text("No lyrics...")
                    }
                }
            }
            
            // 进度条
            HStack {
                Button(action: {
                    Store.shared.dispatch(.playerPlayMode)
                }) {
                    // 选择播放模式：单曲循环、列表循环
                    Image(systemName: store.appState.settings.playMode.systemName)
                        .padding(.leading)
                }
                Text(String(format: "%02d:%02d", Int(player.loadTime/60),Int(player.loadTime)%60))

                Slider(value: $player.loadTime, in: 0...(player.totalTime > 0 ? player.totalTime : 1.0), onEditingChanged: { (isEdit) in
                    Store.shared.dispatch(.playerSeek(isSeeking: isEdit, time: player.loadTime))
                })
                
                Text(String(format: "%02d:%02d", Int(player.totalTime/60),Int(player.totalTime)%60))
                
                Button(action: {
                    Store.shared.dispatch(.songLyricRequest(id: playing.song!.id))
                    showLyric.toggle()
                    withAnimation(.default) {
                        showMore = false
                    }
                }) {
                    Image(systemName: "text.justify")
                        .padding(.trailing)
                }

            }
            .font(.system(size: 13))
            
            HStack(spacing: 40) {
                Button(action: {
                    Store.shared.dispatch(.playerPlayBackward)
                    Store.shared.dispatch(.songLyricRequest(id: playing.song!.id))
                }) {
                    Image(systemName: "backward.fill")
                        .font(.largeTitle)
                        .font(.system(size: 40))
                }
                
                Button(action: {
                    if let song = store.appState.playing.song {
                        Store.shared.dispatch(.playerTogglePlay(song: song))
                        Store.shared.dispatch(.songLyricRequest(id: song.id))
                    }
                }) {
                    Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 50))
                        .padding()
                        .padding(.horizontal)
                }

                
                Button(action: {
                    Store.shared.dispatch(.playerPlayForward)
                    Store.shared.dispatch(.songLyricRequest(id: playing.song!.id))
                }) {
                    Image(systemName: "forward.fill")
                        .font(.largeTitle)
                        .font(.system(size: 40))
                }
                

            }
            .padding(.vertical)
            .edgesIgnoringSafeArea(.all)
        }

    }
}

struct PlaylistTracksView: View {
    let playlist: [PlaylistResponse]
    @Binding var showList: Bool
    @Binding  var bottomType: PlayingNowBottomType
    
    @State private var showCreate: Bool = false

    
    var body: some View {
        VStack {
            HStack {
                Text("收藏到歌单")
                    .font(.title2)
                Spacer()

                // 新建歌单
                Button(action: {
                    self.showCreate.toggle()
                }) {
                    Image(systemName: "rectangle.stack.badge.plus")
                        .font(.title2)
                }

                .sheet(isPresented: $showCreate) {
                    PlaylistCreateView(showSheet: $showCreate)
                }
            }
            .padding(.horizontal)
            
            ScrollView {
                LazyVStack{
                    ForEach(playlist){ item in
                        if Store.shared.appState.playlist.createdPlaylistIds.contains(item.id) && item.id != Store.shared.appState.playlist.likedPlaylistId {
                            Button(action: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    if let songId = Store.shared.appState.playing.song?.id {
                                        Store.shared.dispatch(.playlistTracksRequest(pid: item.id, ids: [Int(songId)], op: true))
                                    }
                                }
                                withAnimation(.default){
                                    showList = false
                                    bottomType = .playingStatus
                                }
                            }) {
                                UserPlaylistRowView(playlist: item)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
        }
    }
}


struct PlayingNowCoverView: View {
    @EnvironmentObject var store: Store
    private var playing: AppState.Playing { store.appState.playing }
    private var settings: AppState.Settings { store.appState.settings }
    
    @Binding var showMore: Bool
    @Binding var bottomType: PlayingNowBottomType

    var type: NEUBorderStyle {
        switch settings.coverShape {
        case .circle:       return .convexFlat
        case .rectangle:    return .unevenness
        }
    }
    
    var body: some View {
        let url = playing.song?.album?.coverURLString
        QinCoverView(url, style: QinCoverStyle(size: showMore ? .medium : .large, shape: settings.coverShape, type: type))
            .contentShape(Circle())
            .onTapGesture(perform: tapAction)
    }
    
    func tapAction() {
        self.hideKeyboard()
        withAnimation(.default) {
            showMore.toggle()
            if showMore {
                bottomType = .playinglist
            } else {
                bottomType = .playingStatus
            }
        }
    }
}

struct PlayingNowListView: View {
    @EnvironmentObject private var store: Store
    @State private var listType: Int = 0
    
    var body: some View {
        VStack {
            Picker(selection: $listType, label: Text("Picker")) {
                Text("播放列表").tag(0)
                Text("歌曲评论").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .fixedSize()
            
            ZStack {
                let offset = UIScreen.main.bounds.height
                PlayinglistView(songsId: store.appState.playing.playinglist.map(\.id))
                    .offset(y: listType == 0 ? 0 : offset)
                if listType == 1 {
                    CommentListView(id: Int(store.appState.playing.song?.id  ?? 0))
                }
            }
        }
    }
}

#if DEBUG
struct PlayingView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingNowView()
            .preferredColorScheme(.light)
            .environmentObject(Store.shared)
            .environmentObject(Player.shared)
            .environment(\.managedObjectContext, DataManager.shared.context())
        PlayingNowView()
            .preferredColorScheme(.dark)
            .environmentObject(Store.shared)
            .environmentObject(Player.shared)
            .environment(\.managedObjectContext, DataManager.shared.context())

    }
}
#endif
