//
//  ViewController.swift
//  Image Upload
//
//  Created by ryan teixeira on 3/3/16.
//  Copyright © 2016 Ryan Teixeira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doUpload(sender: AnyObject) {
        print("doUpload")
        let myUrl = NSURL(string: "http://localhost/upload.php");
        let uploader = FileUploader()
        uploader.imageUploadRequest(imageView: imageView, uploadUrl: myUrl!, param: ["userId" : "4321", "firstName" : "Red", "lastName" : "Bunny"])
    }

}

