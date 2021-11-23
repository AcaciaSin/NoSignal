//
//  ContentView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/18.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = Model.shared
    @Namespace var animation
    
    @State var selection = 0
    
    @GestureState var gestureState = CGSize.zero
    @State var gestureStore = CGSize.zero
    
    var body: some View {
        
        ZStack {
            
            InvisibleRefreshView()
                .environmentObject(model)
                .opacity(0.00001)
            
            TabView(selection: $selection) {
                ZStack {
                    PlaylistView()
                        .environmentObject(model)
                }
                .tabItem {
                    VStack {
                        Image(systemName: "music.note.list")
                        Text("Playlists")
                    }
                }
                .tag(0)
                
                ZStack {
                    LibraryView()
                        .environmentObject(model)
                }
                .tabItem {
                    VStack {
                        Image(systemName: "music.note")
                        Text("Library")
                    }
                }
                .tag(1)
                
                ZStack {
                    UserView()
                        .environmentObject(model)
                }
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("User")
                    }
                }
                .tag(2)
            }
            .zIndex(1.0)
            
            Group {
                if model.isPlayerViewPresented {
                    PlaybackFullscreenView(animation: animation)
                        .environmentObject(model)
                        .offset(CGSize(width: gestureState.width + gestureStore.width,
                                       height: gestureState.height + gestureStore.height))
//                        .edgesIgnoringSafeArea(.all)
                } else {
                    PlaybackbarView(animation: animation)
                        .environmentObject(model)
                        .onTapGesture {
                            gestureStore.height = 0
                            withAnimation(Animation.spring(response: 0.7, dampingFraction: 0.85)) {
                                Haptics.softRoll()
                                model.isPlayerViewPresented.toggle()
                            }
                        }
                        .padding(.bottom, 48)
                }
            }
            .zIndex(2.0)
            .simultaneousGesture(DragGesture().updating($gestureState, body: {value, state, transaction in
                if value.translation.height > 0 {
                    state.height = value.translation.height
                }
            })
            .onEnded({value in
                let translationonheight = max(value.translation.height,
                                              value.predictedEndTranslation.height * 0.2)
                
                if translationonheight > 0 {
                    gestureStore.height  = translationonheight
                    if translationonheight > 50 {
                        withAnimation(Animation.spring(response: 0.7, dampingFraction: 0.85)) {
                            model.isPlayerViewPresented = false
                        }
                    } else {
                        withAnimation(Animation.spring(response: 0.7, dampingFraction: 0.85)) {
                            gestureStore.height = 0
                        }
                    }
                }
            }))
//            .edgesIgnoringSafeArea(.all)
        }
        .accentColor(.pink)
//        .animation(.default, value: 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
