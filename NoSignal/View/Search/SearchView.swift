//
//  SearchView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/22.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var model: Model
    
    @State var searchText = ""
    @State var searchResult = [Song]()
    
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    TextField("Artists, Songs, Lyrics, and More", text: $searchText, onCommit: {
                        UIApplication.shared.resignFirstResponder()
                        if searchText.isEmpty {
                            searchResult = [Song]()
                        } else {
                            // API calling
                            searchResult = AppleMusicAPI.shared.search(query: searchText)
                        }
                    })
                    // todo: 取消当前播放的 View
//                        .onTapGesture {
//                        }
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
//                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding()
                
                VStack {
                    List {
                        ForEach(searchResult, id:\.self) { song in
                            RemoteSongCardView(song: song)
                                .environmentObject(model)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationBarTitle(Text("Search"), displayMode: .automatic)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
