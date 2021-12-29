//
//  LoginView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import SwiftUI
import NeumorphismSwiftUI

struct LoginView: View {
    @EnvironmentObject var store: Store
    private var settings: AppState.Settings { store.appState.settings }

    @State private var email: String = ""
    @State private var password: String = ""
    
    @EnvironmentObject var model: Model
    var body: some View {
        ZStack {
            VStack(spacing: 20.0) {
                Spacer()
                Text("")
                    .font(.title2)
                    .foregroundColor(.secondary)
                HStack {
                    Image(systemName: "envelope.fill")
                        .font(.title3)
                        .padding(.trailing, 2)
                        .foregroundColor(model.themeColor)
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }
                
                HStack {
                    Image(systemName: "key.fill")
                        .font(.title2)
                        .padding(.leading, 5)
                        .padding(.trailing, 5)
                        .foregroundColor(model.themeColor)
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .keyboardType(.asciiCapable)
                }
                .padding(.bottom)

                Button(action: {
                    self.store.dispatch(.loginRequest(email: self.email, password: self.password))
                }) {

                    if store.appState.settings.loginRequesting {
                        Text("正在登录...").padding()
                    } else {
                        Text("登录网易云账号").padding()
                    }
                }
                .buttonStyle(GrowingButton())


            }
            .padding(.horizontal)
        }
//        .navigationBarHidden(true)
    }
}

struct GrowingButton: ButtonStyle {
    @EnvironmentObject var model: Model
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
//            .padding()
            .background(model.themeColor)
            .foregroundColor(.primary)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

public struct BackWardButton: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    public var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .font(.title)
        }
//        .buttonStyle(NEUDefaultButtonStyle(shape: Circle()))
    }
}

struct MyNavigationBarTitleView: View {
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    var body: some View {
        Text(title)
            .fontWeight(.bold)
//            .foregroundColor(.mainText)
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//            .environmentObject(Store.shared)
//            .environmentObject(Model.shared)
//    }
//}
