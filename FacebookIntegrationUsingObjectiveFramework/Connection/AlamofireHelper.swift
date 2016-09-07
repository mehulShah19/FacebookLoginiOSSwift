//
//  AlamofireHelper.swift
//  FacebookIntegrationUsingObjectiveFramework
//
//  Created by Mehul Shah on 02/09/16.
//  Copyright © 2016 Mehul Shah. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireHelper{

    func socialLogin(device_id : String, login_type : String, sn_token : String, id : String)
    {
        var parameters = [String : String]();
        parameters["device_id"] = "12345"
        parameters["login_type"] = "facebook"
        parameters["sn_token"] = "13141efvdges2114"
        parameters["id"] = "424315491431284129"
    
        
    Alamofire.request(.POST, "http://lit-thicket-2046.herokuapp.com/api/authenticate", parameters: parameters).validate().responseJSON { (response) in
        guard response.result.isSuccess else{
            print("Error")
            return
        }
         //Parsing Data
          let userDataObject = response.result.value as? [String : AnyObject]
            let success = userDataObject?["success"] as? Bool
            if(success == nil || success?.boolValue == false){
                return
            }
            let dataObject = userDataObject?["data"] as? [String : AnyObject]
            let user_id = dataObject?["user_id"] as? String
            print(user_id)
        }
    }
    
    
    func socialLogout(device_id : String, login_type : String, id : String){
        {
        var parameters = [String : String]();
        parameters["device_id"] = "12345"
        parameters["login_type"] = "facebook"
        parameters["id"] = "424315491431284129"
       
     Alamofire.request(.POST, "http://192.168.0.7:9876/api/authenticate/logout", parameters: parameters).validate().responseJSON(completionHandler: { (response) in
            let
     })
        
        
    }
    
    
//    Alamofire.request(.POST, "http://lit-thicket-2046.herokuapp.com/api/authenticate", parameters: parameters).validate().responseJSON(queue: dispatch_queue_t?, options: NSJSONReadingOptions) { (response, error) in
//            print(response)
//            print(error)
//        }
//    }
//}
}