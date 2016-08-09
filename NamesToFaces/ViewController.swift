//
//  ViewController.swift
//  NamesToFaces
//
//  Created by My Nguyen on 8/8/16.
//  Copyright © 2016 My Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var collectionView: UICollectionView!
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addNewPerson))
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

    // implementation for UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // dismiss the image picker if the user cancels it
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage: UIImage
        /// extract the image from the dictionary parameter
        // info is a dictionary containing 2 keys: UIImagePickerControllerEditedImage and UIImagePickerControllerOriginalImage
        // need to use optional typecasting (as?) to make sure the dictionary value extracted is of type UIImage
        if let possibleImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }

        // generate a unique filename for the image
        let imageName = NSUUID().UUIDString
        let imagePath = getDocumentsDirectory().stringByAppendingPathComponent(imageName)
        // convert UIImage to NSData (JPEG)
        if let jpegData = UIImageJPEGRepresentation(newImage, 80) {
            // save NSData to file
            jpegData.writeToFile(imagePath, atomically: true)
        }

        // store the image filename in a Person object with the default name "Unknown"
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        // reload the collection view
        collectionView.reloadData()

        dismissViewControllerAnimated(true, completion: nil)
    }

    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func addNewPerson() {
        let picker = UIImagePickerController()
        // allow user to crop the picture
        picker.allowsEditing = true
        // the current class needs to conform to both UIImagePickerControllerDelegate and UINavigationControllerDelegate
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
}

