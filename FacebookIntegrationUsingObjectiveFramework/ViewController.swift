//
//  ViewController.swift
//  FacebookLoginVeoSoftware
//
//  Created by Mehul Shah on 31/08/16.
//  Copyright © 2016 Mehul Shah. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
     struct FacebookUserFields{
         static let publicProfile = "public_profile"
         static let email = "email"
         static let userFriends = "user_friends"
         static let firstName = "first_name"
         static let lastName = "last_name"
         static let pictureUrl = "picture.type(large)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(FBSDKAccessToken.currentAccessToken() == nil || FBSDKAccessToken.currentAccessToken() == ""){
            print("Already login")
        }
        let fbsdkLoginButton = FBSDKLoginButton.init()
        fbsdkLoginButton.readPermissions = [FacebookUserFields.publicProfile,FacebookUserFields.email,FacebookUserFields.userFriends]
        fbsdkLoginButton.center = view.center
        fbsdkLoginButton.delegate = self
        view.addSubview(fbsdkLoginButton)
        
        
        var alamoFire = AlamofireHelper()
        alamoFire.socialLogin("21341", login_type: "facebook", sn_token: "dada", id: "121d3d14e1e")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
  
        
        if(error != nil){
            //TODO: To show user that because of some reason it's being failed
            return
        }else{
            getFacebookUserValues(result)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        print("Logout\(loginButton)")
        
    }
    
    func getFacebookUserValues(result : FBSDKLoginManagerLoginResult!){
        if(result == nil){
            return
        }
       //TODO: save UserID, TokenString ExpirationDate
        let userID =  result.token.userID
        let tokenString = result.token.tokenString
        let expirationDate = result.token.expirationDate
        
        
        var grantedFieldStringSet : Set<String> = Set<String>()
        //Get Profile and email data
        if(result.grantedPermissions.contains(FacebookUserFields.email)){
            grantedFieldStringSet.insert(FacebookUserFields.email)
        }
        if(result.grantedPermissions.contains(FacebookUserFields.publicProfile)){
            grantedFieldStringSet.insert(FacebookUserFields.firstName)
            grantedFieldStringSet.insert(FacebookUserFields.lastName)
            grantedFieldStringSet.insert(FacebookUserFields.pictureUrl)
        }
        
        if(grantedFieldStringSet.isEmpty){
            return
        }
        
        var grantedFieldString: String = ""
        
//        for singleGrantedFieldString in grantedFieldStringSet{
//            grantedFieldString += singleGrantedFieldString + ", "
//    
//        }
//        grantedFieldString.removeAtIndex(grantedFieldString.endIndex.predecessor())
//        grantedFieldString.removeAtIndex(grantedFieldString.endIndex.predecessor())

        //
        //
        //for singleGrantedFieldString in stringSet{
        //        grantedFieldString += singleGrantedFieldString
        //
        //            if(singleGrantedFieldString != stringSet[stringSet.startIndex.advancedBy(stringSet.count - 1)])
        //            {
        //            grantedFieldString += ", "
        //        }
        //        
        //    }
        
        
        for i in 0...(grantedFieldStringSet.count as Int - 1 ){
            grantedFieldString += grantedFieldStringSet[grantedFieldStringSet.startIndex.advancedBy(i)]
            print(grantedFieldString)
            if(i != (grantedFieldStringSet.count - 1)){
                grantedFieldString += ", "
            }
        }
        
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": grantedFieldString]).startWithCompletionHandler { (connection, result, error) -> Void in
            if(error != nil){
                return
            }
            
            let strFirstName: String = (result.objectForKey(FacebookUserFields.firstName) as? String)!
            let strLastName: String = (result.objectForKey(FacebookUserFields.lastName) as? String)!
            let email : String = (result.objectForKey(FacebookUserFields.email) as? String)!
            let strPictureURL: String = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            print("First Name \(strFirstName)  Last Name \(strLastName) Picture Url \(strPictureURL)")
        
        }
        

        if(result.grantedPermissions.contains(FacebookUserFields.email)){
            
        }
    }
    
    
    
    
    
    func facebookLogout(){
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
     }
    
    
}

