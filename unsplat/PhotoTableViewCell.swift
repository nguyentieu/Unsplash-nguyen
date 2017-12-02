//
//  PhotoTableViewCell.swift
//  unsplat
//
//  Created by nguyenos on 11/30/17.
//  Copyright © 2017 nguyenos. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImageView.layer.cornerRadius = self.userImageView.bounds.height / 2
        userImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleToFill
    }

    func configCell(photo: Photo) {
        self.photoImageView.kf.setImage(with: URL.init(string: photo.imageThumbURL!))
        self.userImageView.kf.setImage(with: URL.init(string: photo.userProfileImage!))
        self.usernameLabel.text = photo.userName
        self.descriptionLabel.text = photo.imageDescription
    }
    
}
