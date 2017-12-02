//
//  ViewController.swift
//  unsplat
//
//  Created by nguyenos on 11/30/17.
//  Copyright © 2017 nguyenos. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON
class ViewController: UIViewController {

    
    @IBOutlet weak var profileImageTableView: UITableView!
   // @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    fileprivate var loadMore = false
    fileprivate let baseURL = "https://api.unsplash.com/"
    fileprivate let listPhotoPath = "photos"
    fileprivate let clientId = "b483531ec32d1e22c3b351ad78d7316981b0c1d4ef8881519e45e696cf4c2593"
    //"100c73b532492d40b76bf6a5a3abd0ada2c4de00f2251b79e8043ae1d5938104"
//    fileprivate let clientId = "3c02fb914e645b48daa04d4e1aeab3ba04f523ffc211081c841be755e4e8024a"
    fileprivate var page = 1
    fileprivate var photos = [Photo]()
    fileprivate var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        requestListPhoto()
        configTableView()
        print(page)
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        profileImageTableView.refreshControl = refreshControl
    }
    @objc func pullToRefresh() {
        page = 1
        requestListPhoto()
        refreshControl.endRefreshing()
    }
    func configTableView() {
        profileImageTableView.dataSource = self
        profileImageTableView.delegate = self
        profileImageTableView.register(UINib.init(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
    }

    func requestListPhoto() {
        let params: [String: Any] = ["client_id": clientId, "page": page]
        Alamofire.request(baseURL + listPhotoPath, method: HTTPMethod.get, parameters: params, encoding: URLEncoding.queryString).responseJSON { (response) in
            if let error = response.error {
                print(error.localizedDescription)
            } else if let data = response.data {
                guard let jsonArray = JSON.init(data: data).array else { return }
//                self.photos = jsonArray.map{ Photo.init( $0 )}
                if self.page == 1 {
                    self.photos = jsonArray.map{ Photo.init( $0 )}
                    self.profileImageTableView.reloadData()
                } else {
                    for json in jsonArray {
                        let photo = Photo.init(json)
                        self.photos.append(photo)
                    }
                    self.profileImageTableView.reloadData()
                    //self.loadMore = false
                    print(self.photos)
                }
            }
        }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
        let photo = photos[indexPath.row]
        cell.configCell(photo: photo)
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        scrollViewDidEndScrollingAnimation(profileImageTableView)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailPhotoVC = storyboard?.instantiateViewController(withIdentifier: "DetailPhotoViewController") as? DetailPhotoViewController else { return }
        detailPhotoVC.photo = photos[indexPath.row]
        let pho = photos[indexPath.row]
        print(pho.totalLikes)
        navigationController?.pushViewController(detailPhotoVC, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 236.0
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset

        if deltaOffset <= 0 {
            page = page + 1
            requestListPhoto()
        }
    }
}
