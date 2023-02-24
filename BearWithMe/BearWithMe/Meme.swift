//
//  Meme.swift
//  BearWithMe
//
//  Created by Adem Tsranchaliev on 23.02.23.
//

import Foundation

struct Meme {
    
    init(id: String,text: String,color: String,font: Int,image: String, alignIndex: Int, uploadedOn: Date, likes: Int) {
        self.id=id;
        self.text=text;
        self.color=color;
        self.font=font;
        self.image=image;
        self.alignIndex=alignIndex;
        self.uploadedOn=uploadedOn
        self.likes = likes
    }
    
    var id: String
    var text: String
    var color: String
    var font: Int
    var image: String
    var alignIndex: Int
    var uploadedOn: Date
    var likes: Int

}
