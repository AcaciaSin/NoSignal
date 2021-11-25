//
//  EmptyStateView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/25.
//

import SwiftUI

struct EmptyStateView: View {
  var body: some View {
    VStack {
      Spacer()
      Image(systemName: "music.note")
        .font(.system(size: 85))
        .padding(.bottom)
      Text("Start searching for music...")
        .font(.title)
      Spacer()
    }
    .padding()
    .foregroundColor(.accentColor)
  }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView()
    }
}
