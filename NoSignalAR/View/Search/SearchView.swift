//
//  SearchView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/22.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    @EnvironmentObject var model: Model
    // 观测对象，如果搜索有结果自动更新其值
    @ObservedObject var viewModel: SongListViewModel
    
    var body: some View {
        NavigationView {
                VStack {
                    SearchBar(searchTerm: $viewModel.searchTerm)
                    Text("\(viewModel.songs.count)")
                    if viewModel.songs.isEmpty {
//                        Text("\(viewModel.songs.count)")
                        Spacer()
                        EmptyStateView(theme: $model.themeColor)
                        Spacer()
                    } else {
//                        Text("\(viewModel.songs.count)")
                        List(viewModel.songs) { song in
                            SongView(song: song)
                        }
                        .listStyle(PlainListStyle())
                    }

                }
                .navigationBarTitle("Search", displayMode: .automatic)
            }

    }
}

struct ArtworkView: View {
    let image: Image?
    
    var body: some View {
        ZStack {
            if image != nil {
                image
            } else {
                Color(.green)
                Image(systemName: "music.note")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 50, height: 50)
        .shadow(radius: 5)
        .padding(.trailing, 5)
    }
}

struct SearchBar : UIViewRepresentable {
    typealias UIViewType = UISearchBar
    @Binding var searchTerm: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Type a song, artist, or album name..."
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        
    }
    
    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator(searchTerm: $searchTerm)
    }
    
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
        @Binding var searchTerm: String
        init(searchTerm: Binding<String>) {
            self._searchTerm = searchTerm
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchTerm = searchBar.text ?? ""
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct SongView: View {
  @ObservedObject var song: SongViewModel
  
  var body: some View {
    HStack {
      ArtworkView(image: song.artwork)
        .padding(.trailing)
      VStack(alignment: .leading) {
        Text(song.trackName)
        Text(song.artistName)
          .font(.footnote)
          .foregroundColor(.gray)
      }
    }
    .padding()
  }
}

// apple music 写法
//@State var searchText = ""
//@State var searchResult = [Song]()
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.secondary)
//                    TextField("Artists, Songs, Lyrics, and More", text: $searchText, onCommit: {
//                        UIApplication.shared.resignFirstResponder()
//                        if searchText.isEmpty {
//                            searchResult = [Song]()
//                        } else {
//                            // API calling
//                            searchResult = AppleMusicAPI.shared.search(query: searchText)
//                        }
//                    })
                    // todo: 取消当前播放的 View
//                        .onTapGesture {
//                        }
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
