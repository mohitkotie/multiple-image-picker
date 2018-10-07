//
//  ViewController.swift
//  multiple_image_selector
//
//  Created by mohit kotie on 07/10/18.
//  Copyright © 2018 mohit kotie. All rights reserved.
//

import UIKit
import Photos
import BSImagePicker

class ViewController: UIViewController {
     
     @IBOutlet weak var collectionView: UICollectionView!
     var SelectedAssets = [PHAsset]()
     var PhotoArray = [UIImage]()


     override func viewDidLoad() {
          super.viewDidLoad()
          // Do any additional setup after loading the view, typically from a nib.

        collectionView.delegate = self
        collectionView.dataSource = self
             }
    
     
     

     @IBAction func image_picker(_ sender: Any) {
          SelectedAssets.removeAll()
          PhotoArray.removeAll()
          collectionView.reloadData()
          let vc = BSImagePickerViewController()
          
          //display picture gallery
          self.bs_presentImagePickerController(vc, animated: true,
                                               select: { (asset: PHAsset) -> Void in
                                                  
          }, deselect: { (asset: PHAsset) -> Void in
               // User deselected an assets.
               
          }, cancel: { (assets: [PHAsset]) -> Void in
               // User cancelled. And this where the assets currently selected.
          }, finish: { (assets: [PHAsset]) -> Void in
               // User finished with these assets
               for i in 0..<assets.count
               {
                    self.SelectedAssets.append(assets[i])
                    
               }
               
               self.convertAssetToImages()
//               OperationQueue.main.addOperation({
//                    self.collectionView.reloadData()
//               })
               DispatchQueue.main.async {
                    self.collectionView.reloadData()
               }

               
          }, completion: nil)
          
          
          
          
          
     }
     
     
     func convertAssetToImages() -> Void {
          
//          if SelectedAssets.count != 0{
          
               
               for i in 0..<SelectedAssets.count{
                    
                    let manager = PHImageManager.default()
                    let option = PHImageRequestOptions()
                    var thumbnail = UIImage()
                    option.isSynchronous = true
                    
                    
                    manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width:400 , height:650), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                         thumbnail = result!
                         
                    })
                    self.PhotoArray.append(thumbnail as UIImage)
                    
               }
          
//          }
          }

     
}

extension ViewController : UICollectionViewDataSource , UICollectionViewDelegate{
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return PhotoArray.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DataCollectionViewCell
          cell.ImageViewCell.image = PhotoArray[indexPath.row]
          return cell
     }
     
     
}

extension ViewController : UICollectionViewDelegateFlowLayout{
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               let size = UIScreen.main.bounds
               return CGSize(width: size.width, height: size.height)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 0
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 0;
     }
}
