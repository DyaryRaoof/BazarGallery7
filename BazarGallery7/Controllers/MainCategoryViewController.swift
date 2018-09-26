//
//  MainCategoryViewController.swift
//  BazarGallery7
//
//  Created by Dyary Raoof Bayz on 9/24/18.
//  Copyright © 2018 Dyary Raoof Bayz. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class MainCategoryViewController: SlideMenuController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var hambergurNumber = 0
    
    
    
    @IBAction func menuBarButtonPressed(_ sender: UIBarButtonItem) {
        
        if hambergurNumber % 2 == 0 {
            self.slideMenuController()?.openRight()
        }else{
            self.slideMenuController()?.closeRight()
        }
        
        hambergurNumber += 1
    }
    
    
    var imageRatio : CGFloat = 0
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let array : [String] = ["1", "2", "3", "4", "5", "6","1", "2", "3", "4", "5", "6"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCollectionViewCell
        
        cell.image.image = UIImage(named: array[indexPath.row] + ".jpeg")
        
        cell.label.text = array[indexPath.row]
        
        
        
        return cell
    }
    
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeImageRatio()
        
        let rightSlideMenuController = self.storyboard?.instantiateViewController(withIdentifier: "SlideMenuController") as! SlideMenuController
        self.slideMenuController()?.rightViewController = rightSlideMenuController
        self.slideMenuController()?.addLeftGestures()

        
    }
    
    
    func changerRoweNumber (){
        
        let itemSize = UIScreen.main.bounds.width/imageRatio-imageRatio
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0 , 10, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = imageRatio
        layout.minimumLineSpacing = imageRatio
        myCollectionView.collectionViewLayout = layout
        
        myCollectionView.reloadData()
        
    }
    
    func changeImageRatio(){
        if imageRatio <= 3{
    
        imageRatio += 1
        changerRoweNumber()
    
        print(imageRatio)
    
        }else{
        imageRatio = 0
        }
    }
    
    @IBAction func categoriesRowButtonPressed(_ sender: UIBarButtonItem) {
      
        changeImageRatio()
    }
    
  
    
}
