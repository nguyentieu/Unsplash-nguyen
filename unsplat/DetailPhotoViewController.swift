
//
//  DetailPhotoViewController.swift
//  unsplat
//
//  Created by nguyenos on 12/2/17.
//  Copyright © 2017 nguyenos. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class DetailPhotoViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var likeOfPhoto: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var totalLikeLabel: UILabel!
    
    @IBOutlet weak var totalPhotoLabel: UILabel!
    var photo: Photo!
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.kf.setImage(with: URL.init(string: photo.imageRegualerURL!))
        profileImageView.kf.setImage(with: URL.init(string: photo.userProfileImage!))
        usernameLabel.text = photo.userName
        totalLikeLabel.text =  "Total Likes: \(photo.totalLikes!)"
        totalPhotoLabel.text = "Total Photos: \(photo.totalPhotos!)"
        likeOfPhoto.text = "Like: \(photo.likesOfPhoto!)"
    }

}
