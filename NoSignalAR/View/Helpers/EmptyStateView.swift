//
//  EmptyStateView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/25.
//

import SwiftUI

struct EmptyStateView: View {
 @Binding var theme: Color
    
  var body: some View {
    VStack {
      Spacer()
      Image(systemName: "music.note")
        .font(.system(size: 85))
        .padding(.bottom)
        .rotationEffect(.degrees(20))
      Text("No Signal!")
        .font(.title)
        .foregroundColor(.primary)
//        .rotationEffect(.degrees(30))
      Spacer()
    }
    .padding()
    .foregroundColor(theme)
  }
}

//struct EmptyStateView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmptyStateView()
//    }
//}
