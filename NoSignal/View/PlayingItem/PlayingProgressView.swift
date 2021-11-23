//
//  ProgressView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/20.
//

import SwiftUI
import CoreMedia

struct PlayingProgressView: View {
    
    @EnvironmentObject var model: Model
    
    @State private var downloadAmount = 0.0
    
    // todo:
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    // formatter 显示歌曲时间
    let formatter: DateComponentsFormatter = {
        let dateComponentsFormatter = DateComponentsFormatter()
        // check the order of the units it does matter when allowing only 1 unit to be displayed
        dateComponentsFormatter.allowedUnits = [.minute, .second]
        dateComponentsFormatter.unitsStyle = .positional
        dateComponentsFormatter.zeroFormattingBehavior = .pad
        return dateComponentsFormatter
    }()
    
    var body: some View {
        if let currentSong = model.musicPlayer.nowPlayingItem {
            VStack {
                ProgressView("",
                             value: downloadAmount,
                             total: currentSong.playbackDuration)
                    .onReceive(timer, perform: {_ in
                        downloadAmount = model.musicPlayer.currentPlaybackTime
                    })
                HStack {
                    let duration = formatter.string(from: model.musicPlayer.nowPlayingItem?.playbackDuration ?? 0)
                    let current = formatter.string(from: downloadAmount )
                    Text(current ?? "")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(duration ?? "")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
 
        }
        
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingProgressView()
    }
}
