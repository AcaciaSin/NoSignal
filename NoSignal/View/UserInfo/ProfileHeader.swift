//
//  ProfileHeader.swift
//  NoSignal
//
//  Created by student9 on 2021/11/20.
//

import SwiftUI

struct ProfileHeader: View {
    @EnvironmentObject private var store: Store
    @EnvironmentObject private var player: Player
    private var album: AppState.Album { store.appState.album }
    private var artist: AppState.Artist { store.appState.artist }
    private var playlist: AppState.Playlist { store.appState.playlist }
    private var user: User? { store.appState.settings.loginUser }
    
    @Binding var aboutUs: Bool
    @EnvironmentObject var model: Model
    
    let gradient = Gradient(colors: [.blue, .purple])
    let themes = [Color.pink, Color.indigo, Color.blue, Color.orange]
    
    var body: some View {
        // vertical 垂直布局
        VStack {
            // horizontal 水平布局
            if user == nil {
                Spacer()
                LoginView()
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 200)
                    .padding(.top, 30)
            } else {
                VStack(spacing: 20.0) {
                    Spacer()
                    HStack {
                        QinCoverView(user?.profile.avatarUrl, style: QinCoverStyle(size: .medium, shape: .rectangle))
                        VStack {
                            if let nickname = user?.profile.nickname {
                                Text(nickname)
                                    .font(.title2).bold()
                                    .padding(.leading, 10)
                            }
                            if let signature = user?.profile.signature {
                                Text(signature)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .padding(.leading, 4)
                            }
                            Button(action: {
                                Store.shared.dispatch(.logoutRequest)
                            }) {
                                Text("退出登录")
                                    .padding()
                            }
                        }

                    }
                    .padding(.vertical)
                    .padding(.top, 80)
                }
                .padding()
                .padding(.horizontal)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
                .onTapGesture {
                    self.hideKeyboard()
                }
            }


            
            Spacer(minLength: 20)
            List {
                HStack {
                    Image(systemName: "paintpalette")
                        .foregroundColor(model.themeColor)
                    Text("切换主题").padding(.trailing)
                    Spacer()
                    Picker("Select theme color", selection: $model.themeColor) {
                        ForEach(themes, id:\.self) {color in
                            switch color {
                            case Color.indigo: Text("靛蓝")
                            case Color.pink: Text("粉红")
                            case Color.blue: Text("浅蓝")
                            case Color.orange: Text("橘黄")
                            default:Text("")
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                }
                HStack {
                    Image(systemName: "magnifyingglass.circle")
                        .foregroundColor(model.themeColor)
                    Toggle("搜索功能", isOn: $model.SearchToggle)
                }
                HStack {
                    Image(systemName: "music.note.list")
                        .foregroundColor(model.themeColor)
                    Toggle("歌单功能", isOn: $model.PlaylistToggle)
                }
                HStack {
                    Image(systemName: "music.quarternote.3")
                        .foregroundColor(model.themeColor)
                    Toggle("曲库功能", isOn: $model.LibraryToggle)
                }
                HStack {
                    Image(systemName: "camera.fill")
                        .foregroundColor(model.themeColor)
                    Toggle("AR 功能", isOn: $model.ARToggle)
                }
                
                HStack {
                    Image(systemName: "face.smiling")
                        .foregroundColor(model.themeColor)
                    Text("Nosignal")
                    
                    Button("") {
                        self.aboutUs.toggle()
                    }
                }
                HStack {
                    Image(systemName: "command")
                        .foregroundColor(model.themeColor)
                    Text("Pure & Modularity & AR")
                    
                    Button("") {
                        self.aboutUs.toggle()
                    }
                }
                HStack {
                    Image(systemName: "heart.text.square")
                        .foregroundColor(model.themeColor)
                    Text("版权声明")
                    
                    Button("") {
                        self.aboutUs.toggle()
                    }
                }
                HStack {
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(model.themeColor)
                    Text("关于我们")

                    Button("") {
                        self.aboutUs.toggle()
                    }
                }
                
            }
        }

//        .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeader(aboutUs: .constant(true))
            .environmentObject(Store.shared)
            .environmentObject(Player.shared)
            .environmentObject(Model.shared)
    }
}

