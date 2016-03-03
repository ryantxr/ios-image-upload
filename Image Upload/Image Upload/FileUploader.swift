//
//  FileUploader.swift
//  Image Upload
//
//  Created by ryan teixeira on 3/3/16.
//  Copyright © 2016 Ryan Teixeira. All rights reserved.
//

import Foundation
import UIKit

class FileUploader {
    

    func imageUploadRequest(imageView imageView: UIImageView, uploadUrl: NSURL, param: [String:String]?) {
        
        //let myUrl = NSURL(string: "http://localhost/upload.php");
        
        let request = NSMutableURLRequest(URL: uploadUrl);
        request.HTTPMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 1)
        
        if(imageData==nil)  { return; }
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        //myActivityIndicator.startAnimating();
        
        let task =  NSURLSession.sharedSession().dataTaskWithRequest(request,
            completionHandler: {
                (data, response, error) -> Void in
                if let data = data {
                    
                    // You can print out response object
                    print("******* response = \(response)")
                    
                    print(data.length)
                    // you can use data here
                    
                    // Print out reponse body
                    let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
                    print("****** response data = \(responseString!)")
                    
                    let json =  try!NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary
                    
                    print("json value \(json)")
                    
                    //var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err)
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        //self.myActivityIndicator.stopAnimating()
                        //self.imageView.image = nil;
                    });
                    
                } else if let error = error {
                    print(error.description)
                }
        })
        task.resume()
    }


    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }

    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }

}// extension for impage uploading

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}