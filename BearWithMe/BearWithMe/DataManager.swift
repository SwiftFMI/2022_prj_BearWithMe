//
//  DataManager.swift
//  BearWithMe
//
//  Created by Adem Tsranchaliev on 23.02.23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import Combine

class DataManager: ObservableObject {
    @Published var memes: [Meme] = []
    @Published var likes: [Like] = []
    @Published var likesCount: Int = 0
    @Published var dislikesCount: Int = 0
    @Published var isMyLike: Int = 0
    @Published var isMyDislike: Int = 0
    
    private let db = Firestore.firestore()
    
    init(){
        getAllMemes(sort: "random")
    }
    
    func createMeme(model: Meme){
        
        let uuid = UUID().uuidString
        
        
        var write = db.collection("Memes").document(uuid)
        write.setData([
            "id": uuid,
            "color":model.color,
            "font":model.font,
            "image":model.image,
            "text":model.text,
            "uploadedOn": Date.now,
            "alignIndex": model.alignIndex,
            "likes": 0
        ]){ error in
            
            if let error = error{
                print(error)
            }
        }
    }
    
    func saveLike(model: Like){
        
        let uuid = UUID().uuidString
        
        var write = db.collection("Likes").document(model.deviceId+"-"+model.memeId)
        write.setData([
            "deviceId":model.deviceId,
            "memeId":model.memeId,
            "like": model.like
            
        ]){ error in
            
            if let error = error{
                print(error)
            }
            
        }
        
        self.getLikes(searchMemeId: model.memeId)
    }
    
    func setLikesToMeme(model: Meme, likes: Int){
                
        var write = db.collection("Memes").document(model.id)
        write.setData([
            "id": model.id,
            "color":model.color,
            "font":model.font,
            "image":model.image,
            "text":model.text,
            "uploadedOn": Date.now,
            "alignIndex": model.alignIndex,
            "likes":likes

        ]){ error in
            
            if let error = error{
                print(error)
            }
        }
    }
    
    func getLikes(searchMemeId: String){
        let db = Firestore.firestore()
        let ref = db.collection("Likes")
        self.likes = []
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let deviceId=data["deviceId"] as? String ?? "";
                    let memeId=data["memeId"] as? String ?? "";
                    let like=data["like"] as? Bool ?? true;
                    
                    if memeId == searchMemeId{
                        self.likes.append(Like(deviceId: deviceId, memeId: memeId, like: like))
                    }
                }
                
                self.likesCount = self.getLikes()
                self.dislikesCount = self.getDislikes()
                self.isMyLike = self.isMyLike(likeValue: true)
                self.isMyDislike = self.isMyLike(likeValue: false)
            }
        }
    }
    
    
    func getAllMemes(sort: String){
        let db = Firestore.firestore()
        let ref = db.collection("Memes")
        self.memes = []
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id=data["id"] as? String ?? "";
                    let text=data["text"] as? String ?? "";
                    let color=data["color"] as? String ?? "";
                    let font=data["font"] as? Int ?? 40;
                    let image=data["image"] as? String ?? "";
                    let alignIndex=data["alignIndex"] as? Int ?? 0;
                    let uploadedOn=data["uploadedOn"] as? Date ?? Date.now;
                    let likes=data["likes"] as? Int ?? 0;

                    self.memes.append(Meme(id:id,text: text,color: color,font: font,image: image,alignIndex: alignIndex,uploadedOn: uploadedOn, likes: likes))
                }
            }
            if sort == "random" {
                self.memes.shuffle()
            }
            else if sort == "newest" {
                self.memes = self.memes.sorted { Meme1, Meme2 in
                    Meme1.uploadedOn > Meme2.uploadedOn
                }
            }
            else if sort == "mostpopular" {
                self.memes = self.memes.sorted { Meme1, Meme2 in
                    Meme1.likes > Meme2.likes
                }
            }
            
            if self.memes.count > 0 {
                self.getLikes(searchMemeId: self.memes[0].id)
            }
        }
        
    }
    
    func isMyLike(likeValue: Bool) -> Int {
        
        var isLike = 0
        let deviceId = UIDevice.current.identifierForVendor!.uuidString
        
        for like in self.likes {
            
            if like.like == likeValue && like.deviceId == deviceId {
                isLike = 1
                break
            }
        }
        
        return isLike;
    }
    
    func getLikes() -> Int {
        
        var counter = 0
        
        for like in self.likes {
            if like.like {
                counter += 1
            }
        }
        
        return counter;
    }
    
    func getDislikes() -> Int {
        
        var counter = 0
        
        for like in self.likes {
            if !like.like {
                counter += 1
            }
        }
        
        return counter;
    }
}   
