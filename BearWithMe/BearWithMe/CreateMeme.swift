//
//  CreateMeme.swift
//  BearWithMe
//
//  Created by Adem Tsranchaliev on 22.02.23.
//

import SwiftUI

struct CreateMeme: View {
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var image = ""
    
    @State var aligmentIcons = ["align.horizontal.left","align.horizontal.center","align.horizontal.right"]
    @State var currentIconIndex = 0
    @State var aligments = [TextAlignment.leading,TextAlignment.center,TextAlignment.trailing];
    @State private var showingAlert = false
    
    @State var textAlign = CGFloat(10)
    @State var upperText = "TEXT HERE"
    @State private var bgColor = Color(.sRGB, red: 255, green: 255, blue: 255)
    @State var fontSize = CGFloat(24)
    
    var body: some View {
        VStack(alignment: .center) {
            
            
            HStack{
                Image(systemName: "text.line.first.and.arrowtriangle.forward")
                    .font(Font.system(.largeTitle))
                    .onTapGesture {
                        if textAlign == CGFloat(300) {
                            textAlign = CGFloat(20)
                        }
                        else{
                            textAlign = CGFloat(300)
                        }
                    }
                Spacer()
                
                Image(systemName: aligmentIcons[currentIconIndex])
                    .onTapGesture {
                        currentIconIndex += 1;
                        
                        if currentIconIndex >= 3{
                            currentIconIndex = 0
                        }
                    }
                    .font(Font.system(.largeTitle))
                Spacer()
                
                Image(systemName: "textformat")
                    .font(Font.system(.largeTitle))
                    .onTapGesture {
                        fontSize+=20;
                        
                        if fontSize > 80{
                            fontSize = CGFloat(20)
                        }
                    }
                Spacer()
                
                ColorPicker("",selection: $bgColor)
                    .frame(width: 40, height: 40, alignment: .center)
                
            }
            .padding()
            
            VStack{
                Image(self.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(content: {
                        HStack(alignment: VerticalAlignment.bottom){
                            
                            TextEditor(text: $upperText)
                                .foregroundColor(self.bgColor)
                                .font(.custom("Georgia", fixedSize: fontSize))
                                .multilineTextAlignment(aligments[self.currentIconIndex])
                                .scrollContentBackground(.hidden)
                                .padding(.top, textAlign)
                        }
                    })
                
            }
            .frame(
                maxHeight: 560,
                alignment: .center
            )
            
            Button("Качи"){
                print("Hash color")
                let model: Meme = Meme(id: "",text:upperText,color:bgColor.cgColor?.components?.description ?? "[]",font:Int(fontSize),image:image,alignIndex: currentIconIndex, uploadedOn: Date.now, likes: 0)
                dataManager.createMeme(model: model)
                showingAlert = true
                
            }
            .alert("Успешно публикувахте мемето", isPresented: $showingAlert) {
                Button("Добре", role: .cancel) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .font(.largeTitle)
            .frame(width: 200, height: 46, alignment: .center)
            .buttonStyle(.bordered)
            .tint(.blue)
            
        }
    }
}

struct CreateMeme_Previews: PreviewProvider {
    static var previews: some View {
        CreateMeme(image: "")
    }
}
