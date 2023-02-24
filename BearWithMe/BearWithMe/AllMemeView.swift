//
//  AllMemeView.swift
//  BearWithMe
//
//  Created by Adem Tsranchaliev on 22.02.23.
//

import SwiftUI

struct AllMemeView: View {
    
    @EnvironmentObject var dataManager: DataManager
    
    @State var currentMemeIndex = 0
    
    @State var allMemes = [Meme]()
    @State var aligments = [TextAlignment.leading,TextAlignment.center,TextAlignment.trailing]
    @State var dislikeIcons = ["hand.thumbsdown","hand.thumbsdown.fill"]
    @State var likeIcons = ["hand.thumbsup","hand.thumbsup.fill"]
    
    @State private var bgColor = Color(.sRGB, red: 255, green: 255, blue: 255)
    @State var showEnd = false
    @State var likes = 0
    @State var dislikes = 0
    @State var filter = "random"
    
    @State var borders = [BorderedButtonStyle(),BorderlessButtonStyle()]
    
    @State var button1 = 0
    @State var button2 = 1
    @State var button3 = 1
    
    
    var body: some View {
        if dataManager.memes.count > 0
        {
            
            VStack(alignment: .center) {
                
                if !showEnd{
                    HStack (alignment: .center){
                        
                        if button1 == 0 {
                            Button("Случайни"){
                                filter = "random"
                                currentMemeIndex = 0
                                dataManager.getAllMemes(sort: filter)
                                
                                button1 = 0
                                button2 = 1
                                button3 = 1
                            }
                            .buttonStyle(.bordered)
                        } else {
                            Button("Случайни"){
                                filter = "random"
                                currentMemeIndex = 0
                                dataManager.getAllMemes(sort: filter)
                                
                                button1 = 0
                                button2 = 1
                                button3 = 1
                            }
                            .buttonStyle(.borderless)
                        }
                        
                        if button2 == 0 {
                            Spacer()
                            Button("Най-нови"){
                                filter = "newest"
                                currentMemeIndex = 0
                                dataManager.getAllMemes(sort: filter)
                                
                                button1 = 1
                                button2 = 0
                                button3 = 1
                            }
                            .buttonStyle(.bordered)
                        } else {
                            Spacer()
                            Button("Най-нови"){
                                filter = "newest"
                                currentMemeIndex = 0
                                dataManager.getAllMemes(sort: filter)
                                
                                button1 = 1
                                button2 = 0
                                button3 = 1
                            }
                            .buttonStyle(.borderless)
                        }
                        
                        if button3 == 0 {
                            Spacer()
                            Button("Най-популярни"){
                                filter = "mostpopular"
                                currentMemeIndex = 0
                                dataManager.getAllMemes(sort: filter)
                                
                                button1 = 1
                                button2 = 1
                                button3 = 0
                            }
                            .buttonStyle(.bordered)
                        } else {
                            Spacer()
                            Button("Най-популярни"){
                                filter = "mostpopular"
                                currentMemeIndex = 0
                                dataManager.getAllMemes(sort: filter)
                                
                                button1 = 1
                                button2 = 1
                                button3 = 0
                            }
                            .buttonStyle(.borderless)
                        }
                        
                        
                        
                    }
                    .padding()
                    VStack(alignment: .center) {
                        
                        Image(dataManager.memes[currentMemeIndex].image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 130)
                            .overlay(content: {
                                HStack(alignment: VerticalAlignment.bottom){
                                    
                                    TextEditor(text: .constant(dataManager.memes[currentMemeIndex].text))
                                        .foregroundColor(self.bgColor)
                                        .font(.custom("Georgia", fixedSize: CGFloat(dataManager.memes[currentMemeIndex].font)))
                                        .multilineTextAlignment(aligments[dataManager.memes[currentMemeIndex].alignIndex])
                                        .scrollContentBackground(.hidden)
                                        .padding(.top, 150)
                                }
                            })
                    }
                    .frame(
                        maxHeight: 560,
                        alignment: .center
                    )
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    HStack(alignment: .center){
                        
                        HStack(alignment: .center){
                            Image(systemName: dislikeIcons[dataManager.isMyDislike])
                                .font(Font.system(.largeTitle))
                                .onTapGesture {
                                    let deviceId = UIDevice.current.identifierForVendor!.uuidString
                                    var like = Like(deviceId: deviceId, memeId: dataManager.memes[currentMemeIndex].id,like: false)
                                    if self.dataManager.isMyDislike == 0  {
                                        dataManager.saveLike(model: like)
                                        dataManager.setLikesToMeme(model: dataManager.memes[currentMemeIndex], likes: dataManager.memes[currentMemeIndex].likes-1)
                                    }
                                }
                            Text(String(dataManager.dislikesCount))
                        }
                        HStack(alignment: .center){
                            Image(systemName: likeIcons[dataManager.isMyLike])
                                .onTapGesture {
                                    let deviceId = UIDevice.current.identifierForVendor!.uuidString
                                    var like = Like(deviceId: deviceId, memeId: dataManager.memes[currentMemeIndex].id,like: true)
                                    
                                    if self.dataManager.isMyLike == 0  {
                                        
                                        dataManager.saveLike(model: like)
                                        dataManager.setLikesToMeme(model: dataManager.memes[currentMemeIndex], likes: dataManager.memes[currentMemeIndex].likes+1)
                                    }
                                }
                                .font(Font.system(.largeTitle))
                            Text(String(dataManager.likesCount))
                                .font(.system(size: 20));
                            
                        }
                    }
                }
                else {
                    
                    Button("Започни отново"){
                        currentMemeIndex = 0
                        showEnd = false;
                        dataManager.memes = []
                        dataManager.getAllMemes( sort: filter)
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .multilineTextAlignment(.center)
                    
                    
                    Text("Няма повече мемета")
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                    
                }
            }
            
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onEnded({ value in
                    if value.translation.height < 0 {
                        
                        if dataManager.memes.count-1 > currentMemeIndex{
                            currentMemeIndex += 1;
                            dataManager.getLikes(searchMemeId: dataManager.memes[currentMemeIndex].id)
                        }
                        else{
                            showEnd = true
                        }
                    }
                    
                    if value.translation.height > 0 {
                        if currentMemeIndex > 0 {
                            showEnd = false
                            currentMemeIndex -= 1;
                            dataManager.getLikes(searchMemeId: dataManager.memes[currentMemeIndex].id)
                        }
                    }
                }))
            .padding(.bottom)
            
        }
        else {
            ProgressView()
        }
    }
}

struct AllMemeView_Previews: PreviewProvider {
    static var previews: some View {
        AllMemeView()
    }
}
