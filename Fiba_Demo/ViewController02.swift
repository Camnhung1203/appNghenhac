//
//  ViewController02.swift
//  Fiba_Demo
//
//  Created by Cam Nhung on 10/26/16.
//  Copyright © 2016 Cam Nhung. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController02: UIViewController {

    @IBOutlet weak var lblKetqua: UILabel!
    @IBOutlet weak var txtUser: UITextField!
    
    @IBOutlet weak var txtpw: UITextField!
    var email:String{
        return txtUser.text!
    }
    
    var pw:String{
        return txtpw.text!
    }
    @IBAction func abtnLogOut(_ sender: AnyObject) {
        do{
            //try mà để dấu chấm ¡ phía sau thì nếu ko login được nó bị rác
            try FIRAuth.auth()!.signOut()
            lblKetqua.text = "ban vui long Login"
        }catch{
        lblKetqua.text = "ban chua login!"
        }
    }
    @IBAction func abtnLogin(_ sender: AnyObject) {
   
        FIRAuth.auth()?.signIn(withEmail: email, password: pw) { (user, error) in
            if user != nil{
            self.lblKetqua.text = user!.uid
                print("tui dang test")
            }else{
               self.lblKetqua.text = error?.localizedDescription
                print("pha qua")
            }
        }
    }
    
    @IBAction func abtnRegister(_ sender: AnyObject) {
        FIRAuth.auth()?.createUser(withEmail: email, password: pw) { (user, error) in
            if user != nil{
                self.lblKetqua.text = user?.uid
                user?.sendEmailVerification(completion: { (error) in
                    if error != nil {
                        self.lblKetqua.text = error?.localizedDescription
                    }else{
                        self.lblKetqua.text = "email sent successfully"
                    }
                    
                })
            }else{
                self.lblKetqua.text = error?.localizedDescription
            }
        }
        
    }
    
    @IBAction func abtnResetPW(_ sender: AnyObject) {
        FIRAuth.auth()?.sendPasswordReset(withEmail: email) { error in
            if error != nil {
                self.lblKetqua.text = error?.localizedDescription
            } else {
                self.lblKetqua.text = "reset pass thanh cong"
            }
        }
    }
    
    @IBAction func abtnVerify(_ sender: AnyObject) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = FIRAuth.auth()?.currentUser {
            lblKetqua.text = user.uid
            print(user.isEmailVerified)
        } else {
            lblKetqua.text = "Vui long Log in"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
