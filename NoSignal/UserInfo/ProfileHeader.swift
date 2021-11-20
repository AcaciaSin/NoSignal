//
//  ProfileHeader.swift
//  NoSignal
//
//  Created by student9 on 2021/11/20.
//

import SwiftUI

struct ProfileHeader: View {
    @State private var functionOn = false
    @State private var functionOn1 = false
    @State private var functionOn2 = false
    @State private var functionOn3 = false
    @State private var functionOn4 = false
    @State private var functionOn5 = false
    
    let gradient = Gradient(colors: [.blue, .purple])
    
    var body: some View {
        // vertical 垂直布局
        VStack {
            // horizontal 水平布局
            HStack {
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .clipped()
                    .padding(.top, 120)
                
                
                VStack(alignment: .leading) {
                    Text("Adbean")
                        .font(.system(size: 32)).bold()
//                            .foregroundColor(.white)
                    Text("Be happy, dont worry.")
                        .font(.caption)
//                            .foregroundColor(.white)
//
                }
                .padding(.top, 120)
                .padding(.horizontal)
                
                }
            
            Spacer(minLength: 32)
            List {
                HStack {
                    Image(systemName: "command")
                    Text("功能模块")
                }
                HStack {
                    Image(systemName: "music.note")
                    Toggle("歌词", isOn: $functionOn)
                }
                HStack {
                    Image(systemName: "music.note")
                    Toggle("歌词", isOn: $functionOn1)
                }
                HStack {
                    Image(systemName: "music.note")
                    Toggle("歌词", isOn: $functionOn2)
                }
                HStack {
                    Image(systemName: "music.note")
                    Toggle("歌词", isOn: $functionOn2)
                }
                HStack {
                    Image(systemName: "music.note")
                    Toggle("歌词", isOn: $functionOn3)
                }
                HStack {
                    Image(systemName: "music.note")
                    Toggle("歌词", isOn: $functionOn4)
                }
                HStack {
                    Image(systemName: "music.note")
                    Toggle("歌词", isOn: $functionOn5)
                }
                HStack {
                    Image(systemName: "music.quarternote.3")
                    Text("声音、提醒与通知")
                }
            }
        }
//        .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeader()
    }
}
