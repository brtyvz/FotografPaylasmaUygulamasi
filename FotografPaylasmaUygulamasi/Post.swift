//
//  Post.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berat Yavuz on 30.03.2022.
//

import Foundation
class Post{
    
    var mail:String
    var yorum:String
    var gorselUrl:String


    init(mail:String,yorum:String,gorseUrl:String) {
        self.gorselUrl = gorseUrl
        self.mail = mail
        self.yorum = yorum
    }
}
