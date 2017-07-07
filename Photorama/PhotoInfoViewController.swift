//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by Jonathan Salin Lee on 6/26/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var views: UITextView!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.accessibilityLabel = photo.title
        
        views.isUserInteractionEnabled = false
        
        switch photo.views {
        case 1:
            views.text = "\(String(photo.views)) view"
        default:
            views.text = "\(String(photo.views)) views"
        }
        
        store.fetchImage(for: photo) { (result) -> Void in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTags"?:
            let navController = segue.destination as! UINavigationController
            let tagController = navController.topViewController as! TagsViewController
            
            tagController.store = store
            tagController.photo = photo
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
}
