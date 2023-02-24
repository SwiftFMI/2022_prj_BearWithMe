//
//  SelectBear.swift
//  BearWithMe
//
//  Created by Adem Tsranchaliev on 22.02.23.
//

import SwiftUI

struct SelectBear: View {
    var body: some View {
        NavigationView(){
            VStack{
                Text("Изберете картинка")
                    .padding()
                    .font(.largeTitle)
                HStack{
                    NavigationLink(destination: CreateMeme(image:"Bears")) {
                        Image("Bears")
                    }
                    NavigationLink(destination: CreateMeme(image:"happy")) {
                        Image("happy")
                    }
                    
                }
                HStack{
                    NavigationLink(destination: CreateMeme(image:"doge")) {
                        Image("doge")
                    }
                    NavigationLink(destination: CreateMeme(image:"sad")) {
                        Image("sad")
                    }
                }
            }
        }
    }
}

struct SelectBear_Previews: PreviewProvider {
    static var previews: some View {
        SelectBear()
    }
}
