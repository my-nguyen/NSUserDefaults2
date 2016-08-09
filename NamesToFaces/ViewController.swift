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
        return people.count
    }

    // return an object of type UICollectionViewCell, which is custom class PersonCell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // dequeueReusableCellWithReuseIdentifier() creates a collection view cell using the reuse identifier "Person"
        // this method automatically tries to reuse collection view cells
        // collection view cell is typecast to a PersonCell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Person", forIndexPath: indexPath) as! PersonCell

        // pull out the person from the people array at the correct position
        let person = people[indexPath.item]

        // set the name label to the person's name
        cell.name.text = person.name

        // createa a UIImage from the person's image filename
        let path = getDocumentsDirectory().stringByAppendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path)
        // set a border on the image view
        cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).CGColor
        cell.imageView.layer.borderWidth = 2
        // set rounded corners on the image view
        cell.imageView.layer.cornerRadius = 3

        // also set rounded corners on the whole cell
        cell.layer.cornerRadius = 7

        return cell
    }

    // this method is triggered when the user taps a cell
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // extract the person from the people array at the index tapped
        let person = people[indexPath.item]

        /// show a UIAlertController asking the user to rename that person
        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .Alert)
        // add a text field to the alert controller
        ac.addTextFieldWithConfigurationHandler(nil)
        // add an action to cancel the alert
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        // add an action to save the change; note the closure
        ac.addAction(UIAlertAction(title: "OK", style: .Default) { [unowned self, ac] _ in
            // pull out the text field value
            let newName = ac.textFields![0]
            // assign the value to the person's name property
            person.name = newName.text!
            // reload the collection view
            self.collectionView.reloadData()
            })

        presentViewController(ac, animated: true, completion: nil)
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

