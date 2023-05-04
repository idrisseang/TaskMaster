//
//  ContentView.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 08/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    @State private var iconSize = 0.8
    @State private var iconOpacity = 0.5
    @State private var isShowingHour: Bool = false

    var body: some View {
        if isActive {
            HomeView()
        } else {
            VStack {
                VStack {
                    Image("target")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text("TaskMaster")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color("AccentBlue"))
                        .padding(.top, 4)
                }
                .scaleEffect(iconSize)
                .opacity(iconOpacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.6)) {
                        self.iconSize = 0.9
                        self.iconOpacity = 1
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("lightBlue"))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    withAnimation {
                        self.isActive = true
                    }
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
