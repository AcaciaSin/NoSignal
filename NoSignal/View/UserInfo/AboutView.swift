//
//  AboutView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/18.
//

import SwiftUI

struct AboutView: View {
    @Binding var aboutUs: Bool
    @EnvironmentObject var model: Model
    
    let person = [
        Person(name: "廖雨轩", stuID: "StudentID: 18322043", emailAddress: "adbeanx@oultook.com", profilePicture: "nosignal"),
        Person(name: "胡文浩", stuID: "StudentID: 18346019", emailAddress: "adbeanx@oultook.com", profilePicture: "nosignal"),
        Person(name: "冼子婷", stuID: "StudentID: 18338072", emailAddress: "adbeanx@oultook.com", profilePicture: "nosignal"),
    ]
    
    var body: some View {
        VStack {
            Text("Nosignal")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(model.themeColor)
            Text("A Pure Music Application with AR")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 20)
            ForEach(person) { ppl in
                HStack {
                    ProfilePicture(imageName: ppl.profilePicture)
                    PersonDetail(person: ppl)
                }
            }
            .padding(.bottom, 40)
            Button(action: {
                self.aboutUs.toggle()
            }) {
                HStack {
                    Text("Return")
                        .fontWeight(.semibold)
                        .font(.title3)
                }
                .font(.title3)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(model.themeColor)
                .cornerRadius(20)
                .padding(.horizontal, 40)
                .foregroundColor(.white)
            }
        }
    }
}

struct Person: Identifiable {
    var id = UUID()
    var name: String
    var stuID: String
    var emailAddress: String
    var profilePicture: String
}


struct ProfilePicture: View {
    var imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 80, height: 80)
            .clipShape(Circle())
    }
}

struct EmailAddress: View {
    var address: String

    var body: some View {
        HStack {
            Image(systemName: "envelope")
            Text(address)
        }
    }
}

struct PersonDetail: View {
    var person: Person

    var body: some View {
        VStack(alignment: .leading) {
            Text(person.name)
                .font(.title)
                .foregroundColor(.primary)
            Text(person.stuID)
                .foregroundColor(.secondary)
            EmailAddress(address: person.emailAddress)
        }
    }
}
