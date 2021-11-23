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
        TextField("Search Songs:", text: $searchText, onCommit: {
            UIApplication.shared.resignFirstResponder()
        })
        
        List {
            ForEach(searchResult, id:\.self) { song in
                RemoteSongCardView(song: song)
                    .environmentObject(model)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
