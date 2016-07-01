//
//  ViewController.swift
//  DribbleExp
//
//  Created by 王笛 on 16/6/28.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    //UIView Part
    @IBOutlet weak var mainDesLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var secDesLabel: UILabel!
    let searchBar = UISearchBar()
    var replicaView = UIView()
    //User Interaction Part
    var allowUserIterAction = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.delegate   = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.clearColor()
        ////////////////////////////////////////////////////////////////////////
        self.searchBar.frame = CGRect(x: 175, y: 0, width: 200, height: 50)
        self.searchBar.searchBarStyle = UISearchBarStyle.Minimal
        self.searchBar.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(searchBar)
        ////////////////////////////////////////////////////////////////////////
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        
        cell.layer.cornerRadius = 5
        
        return cell
    }
    

    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Use for size
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //put a replica view to represent the cell and expand the view so that give an impression of animation.
        let item = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        let attributes: UICollectionViewLayoutAttributes = collectionView.layoutAttributesForItemAtIndexPath(indexPath)!
        self.replicaView.frame = attributes.frame
        self.view.addSubview(replicaView)
        self.replicaView.addSubview(item.img)
        item.img.clipsToBounds = true
        collectionView.userInteractionEnabled = allowUserIterAction
        print(attributes.frame.origin.x)
        print("replicaView:\(replicaView.frame)")
        print("view:\(self.view.frame)")

            UIView.animateWithDuration(1.0, animations: {
                self.view.bringSubviewToFront(item)
                //unable scrolling
                collectionView.scrollEnabled = false
                //give the replica view an animation.
                self.replicaView.frame.origin.x = attributes.frame.origin.x
                self.replicaView.frame.origin.y = self.view.frame.origin.y - attributes.frame.size.height
                self.replicaView.frame.size.width = self.view.frame.size.width
                self.replicaView.frame.size.width = self.view.frame.size.height
            })

    }
    
}