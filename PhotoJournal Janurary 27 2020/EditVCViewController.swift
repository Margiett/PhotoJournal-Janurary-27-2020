//
//  EditVCViewController.swift
//  PhotoJournal Janurary 27 2020
//
//  Created by Margiett Gil on 1/27/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
//MARK: Step 1: custom delegation - defining the protocol 
protocol imageJorunalDelegate: AnyObject {
    func imagePic(_ editVC: EditVCViewController, _ pic: PhotoModel)
    func didLongPress(_ imageCell: PhotoCVC)
}

class EditVCViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var imageJor: UIImage!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
