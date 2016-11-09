//
//  ViewController.swift
//  Fiba_Demo
//
//  Created by Cam Nhung on 10/21/16.
//  Copyright © 2016 Cam Nhung. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class ViewController: UIViewController {
    
    @IBOutlet weak var tblview1: UITableView!
    
    @IBOutlet weak var txtTenSP: UITextField!
    @IBOutlet weak var txtGiaSP: UITextField!
    @IBOutlet weak var txtIDSP: UITextField!
    @IBOutlet weak var lbl1: UILabel!
    
    var index:Int = 0
    @IBAction func abtnGui(_ sender: AnyObject) {
        let ref: FIRDatabaseReference = FIRDatabase.database().reference()
        let dic:Dictionary<String,Any> = ["idSP":txtIDSP.text!,"tenSP":txtTenSP.text!,"giaSP": txtGiaSP.text!]
        ref.child("SanPham").child("SP\(index)").setValue(dic)
        let userdefault:UserDefaults = UserDefaults()
        
        index += 1
        userdefault.set(index, forKey: "index")
    }
    
    var arrSP:Array<SanPham> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let userdefault:UserDefaults = UserDefaults()
        if let index2:Int = userdefault.object(forKey: "index") as? Int{
            index = index2
        }
        
     let ref: FIRDatabaseReference = FIRDatabase.database().reference()
        
  ref.child("SanPham").observe(FIRDataEventType.value, with: { (snapshot) in
    let arrOb:Dictionary<String,Dictionary<String,AnyObject>> = snapshot.value as! Dictionary<String,Dictionary<String,AnyObject>>
    for i in arrOb{
        self.arrSP.append(SanPham(object: i.value))
    }
    DispatchQueue.main.async {
        self.tblview1.reloadData()
    }
        self.lbl1.text = snapshot.value as? String
    
    })
        tblview1.delegate = self
        tblview1.dataSource = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//arc4random_uniform(10) + 10 --> cho random tu 10 --> 20

extension ViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSP.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell1
        cell.lbl1.text = arrSP[indexPath.row].ten
    
        return cell
    }
}
struct SanPham {
    let id:Int
    let ten:String
    let gia:String
    init(object:Dictionary<String,AnyObject>){
        id = object["idSP"] as! Int
        ten = object["tenSP"] as! String
        gia = object["giaSP"] as! String
    }
}
