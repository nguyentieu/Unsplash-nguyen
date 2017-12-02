//
//  Photos.swift
//  unsplat
//
//  Created by nguyenos on 11/30/17.
//  Copyright © 2017 nguyenos. All rights reserved.
//

import Foundation
import Alamofire
import Kingfisher
import SwiftyJSON

class Photo {
    var imageThumbURL: String?
    var imageRegualerURL: String?
    var userName: String?
    var userProfileImage: String?
    var imageDescription: String?
    var totalPhotos: Int?
    var totalLikes: Int?
    var likesOfPhoto: Int?
    init(_ json: JSON) {
        self.imageThumbURL = json["urls"]["thumb"].string
        self.imageRegualerURL = json["urls"]["regular"].string
        self.userName = json["user"]["username"].string
        self.userProfileImage = json["user"]["profile_image"]["medium"].string
        self.imageDescription = json["description"].string
        self.totalLikes = json["user"]["total_likes"].int
        self.totalPhotos = json["user"]["total_photos"].int
        self.likesOfPhoto = json["likes"].int
    }
}
