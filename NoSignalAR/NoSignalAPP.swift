//
//  NoSignalAPP.swift
//  NoSignalAR
//
//  Created by student9 on 2021/12/26.
//
import SwiftUI
import StoreKit
import MediaPlayer

@main
struct NoSignalApp: App {
    // SwiftUI 生命周期
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate: AppDelegate
    @StateObject var store = Store.shared
    @StateObject var player = Player.shared
    
    let context = DataManager.shared.context()
    
    init() {
        updateSongs()
    }
    
    var body: some Scene {
        WindowGroup {
            // APP 启动时拉取曲库、注册 AR 组件、数据库、全局状态变量
            ContentView()
                .onChange(of: scenePhase, perform: { value in
                    if value == .active {
                        updateSongs()
                        InstrumentComponent.registerComponent()
                    }
                })
                .onAppear {
                    store.dispatch(.loginRefreshRequest)
                }
                .environmentObject(store)
                .environmentObject(player)
                .environment(\.managedObjectContext, context)
        }
    }
    
    func updateSongs() {
        SKCloudServiceController.requestAuthorization { status in
            if status == .authorized {
                let songsQuery = MPMediaQuery.songs()
                if let songs = songsQuery.items {
                    // TODO: 后续添加排序功能
                    let desc = NSSortDescriptor(key: MPMediaItemPropertyLastPlayedDate, ascending: false)
                    // 按照上次播放的顺序排序
                    let sortedSongs = NSArray(array: songs).sortedArray(using: [desc])

                    Model.shared.librarySons = sortedSongs as! [MPMediaItem]
                }

                let playlistQuery = MPMediaQuery.playlists()
                if let playlists = playlistQuery.collections {
                    Model.shared.playlists = playlists
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        AudioSessionManager.shared.configuration()
        return true
    }
}
