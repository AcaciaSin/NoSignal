//
//  NowPlayingView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/23.
//

import SwiftUI

struct NowPlayingView: View {
    
    @Namespace var animation
    @EnvironmentObject var model: Model
    @State var gestureStore = CGSize.zero
    @GestureState var gestureState = CGSize.zero
    
    var body: some View {
        Group {
            if model.isPlayerViewPresented {
                if model.isARShowing {
                    ARMusicView()
                } else {
                    PlaybackFullscreenView(animation: animation)
                        .environmentObject(model)
                        .offset(CGSize(width: gestureState.width + gestureStore.width,
                                       height: gestureState.height + gestureStore.height))
                }

            } else {
                PlaybackbarView(animation: animation)
                    .environmentObject(model)
                    .onTapGesture {
                        gestureStore.height = 0
                        withAnimation(.spring(response: 0.7, dampingFraction: 0.85)) {
                            Haptics.softRoll()
                            model.isPlayerViewPresented.toggle()
                        }
                    }
                    .padding(.bottom, 48)
            }
        }
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
    }
}

