//
//  ViewController.swift
//  PhotoJournal Janurary 27 2020
//
//  Created by Margiett Gil on 1/27/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import AVFoundation // we want to use AVMakeRect() to maintain image aspect ratio

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var gearBar99Button: UIBarButtonItem!
    
    private let imagePickerController = UIImagePickerController()
    
    private var imageObjects = [PhotoModel]()
    
    private var photoDidSet: UIImage? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    // create an instance of data persistence
    let dataPersistence = PersistenceHelper<PhotoModel>(filename: "photoJournal.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        loadImageObject()
    }
    private func loadImageObject() {
        do {
            imageObjects = try dataPersistence.loadPhotoJournal()
            
        } catch {
            print("loading obkects error: \(error)")
        }
    }
    private func appendNewPhotoToCollection() {
        guard let photo = photoDidSet else {
            print("image is nil")
            return
        }
        print("original image size is \(photo.size)")
        
        //MARK: The size for rsizing of image
        let size = UIScreen.main.bounds.size
        
        //MARK: we will maintain the aspect ration of the image
        let rect = AVMakeRect(aspectRatio: photo.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
        
        //MARK: resize image
        let resizePhoto = photo.resizeImage(to: rect.size.width, height: rect.size.height)
        print("resized image size is \(resizePhoto.size)")
        
        //jpegData(compressionQuality: 1.0) converts UIImage to Data
        guard let resizedImageData = resizePhoto.jpegData(compressionQuality: 1.0) else {
            return
        } // create an photoObject using the image selected
        let creatingPhoto = PhotoModel(imageData: resizedImageData, date: String(), title: String())
        
        //insert new imageObject into imageObjects
        imageObjects.insert(creatingPhoto, at: 0)
        
        // create an indexPath for insertion into collection view
        let indexPath = IndexPath(row: 0, section: 0)
        
        //insert new cell into collection view
        collectionView.insertItems(at: [indexPath])
        
        //persist imageObject to documents directory
        do {
            try dataPersistence.create(item: creatingPhoto)
            
        } catch {
            print("saving error: \(error)")
        }
    }


@IBAction func addPictureButtonPressed(_ sender: UIBarButtonItem) {
    let alerController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] alerAction in
        self?.showImageController(isCameraSelected: true)
    }
    let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] alertAction in
        self?.showImageController(isCameraSelected: false)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    
    //check if camera is avaiable, if camera is not available and you attempt to show
    // the camera the app will crash
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
        alerController.addAction(cameraAction)
    }
    alerController.addAction(photoLibraryAction)
    alerController.addAction(cancelAction)
    present(alerController, animated: true)
}
    private func showImageController(isCameraSelected: Bool) {
        imagePickerController.sourceType = .photoLibrary
        
        if isCameraSelected {
            imagePickerController.sourceType = .camera
        }
        present(imagePickerController, animated: true)
    }
} // the class curly


//MARK: DataSource
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // imageObjects.count
        return imageObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCVC else {
            fatalError("unable to type cast reusuable cell")
        }
        let image = imageObjects[indexPath.row]
        
        cell.configureCell(for: image)
        
        return cell
    }
}

//MARK: Delegate
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    //MARK: This is what size the pictures in the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing = CGFloat(1)
        let maxWidth = UIScreen.main.bounds.size.width // device's width
        //      let maxHeight = UIScreen.main.bounds.size.height
        let numberOfItems: CGFloat = 1 // items per row
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        
        //this sizing is so it prints squares.
        return CGSize(width: itemWidth, height: itemWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
}
// more here: https://nshipster.com/image-resizing/
// MARK: - UIImage extension
extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
            
        }
    }
    
}


