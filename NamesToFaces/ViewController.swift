//
//  ViewController.swift
//  NamesToFaces
//
//  Created by My Nguyen on 8/8/16.
//  Copyright © 2016 My Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // tell the collection view how many items to show in its grid
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    // return an object of type UICollectionViewCell, which is custom class PersonCell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // dequeueReusableCellWithReuseIdentifier() creates a collection view cell using the reuse identifier "Person"
        // this method automatically tries to reuse collection view cells
        // collection view cell is typecast to a PersonCell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Person", forIndexPath: indexPath) as! PersonCell
        return cell
    }
}

