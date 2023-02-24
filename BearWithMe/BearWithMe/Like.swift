//
//  Like.swift
//  BearWithMe
//
//  Created by Adem Tsranchaliev on 24.02.23.
//

import Foundation

struct Like {
    
    init(deviceId: String,memeId: String, like: Bool) {
        self.deviceId=deviceId;
        self.memeId=memeId;
        self.like = like
    }
    
    var deviceId: String
    var memeId: String
    var like: Bool

}
