//
//  ViewController.swift
//  GifsLoader
//
//  Created by Rajat on 20/11/19.
//  Copyright © 2019 Rajat. All rights reserved.
//

import UIKit
import SDWebImage
import GiphyCoreSDK
class ViewController: UIViewController {
    @IBOutlet weak var gridView: UICollectionView!
    
    var gifArray = [String]()
    func callThirdParties() {
        self.gifArray.removeAll()
        GiphyCore.shared.trending() { (response, error) in
            for gif in (response?.data)! {
                let gifUrl = "http://media2.giphy.com/media/" + gif.id + "/giphy.gif"
                self.gifArray.append(gifUrl)
            }
            DispatchQueue.main.async {
                        self.gridView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GiphyCore.configure(apiKey: "G875ogRR7vhixUFFL24kVuKrz2UHoB69")
        callThirdParties()
    }
}
extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gifArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let gifCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCollectionViewcell", for: indexPath) as? GifCollectionViewcell else {
            return UICollectionViewCell()
        }
        let url = URL(string: self.gifArray[indexPath.row])
        gifCell.imageGif.sd_setImage(with: url, placeholderImage:  UIImage(named: "bluePlaceHolder"), options: .continueInBackground, completed: nil)
        return gifCell
    }
}
extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2.0 - 20
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
