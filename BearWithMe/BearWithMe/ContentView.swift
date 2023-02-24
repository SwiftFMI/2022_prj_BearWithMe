//
//  ContentView.swift
//  BearWithMe
//
//  Created by Adem Tsranchaliev on 21.02.23.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        
        TabView {
            AllMemeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Начало")
                }
            SelectBear()
                .padding()
                .tabItem {
                    Image(systemName: "plus.app")
                    Text("Създай")
                }
           // Text("Nearby Screen")
           //     .tabItem {
           //         Image(systemName: "heart")
           //         Text("Харесани")
           //     }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
