//
//  QinBackgroundView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/22.
//

import SwiftUI
import NeumorphismSwiftUI

typealias QinBackgroundView = NEUBackgroundView

#if DEBUG
fileprivate struct QinBackgroundViewDEBUGView: View {
    var body: some View {
        ZStack {
            QinBackgroundView()
        }
    }
}
struct QinBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        QinBackgroundViewDEBUGView()
            .preferredColorScheme(.light)
        QinBackgroundViewDEBUGView()
            .preferredColorScheme(.dark)
    }
}
#endif
