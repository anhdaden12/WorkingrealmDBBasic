//
//  ViewController2.swift
//  WorkingWithRealmDB
//
//  Created by Apple on 10/31/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController2: UIViewController {
    

    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textPhone: UITextField!
    
    let realm = try! Realm()
    
    var detailPerson: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textName.text = detailPerson?.name
        textPhone.text = "\(String(describing: detailPerson!.phone))"
    }
    
    
    @IBAction func onClickEdit(_ sender: Any) {
        try! realm.write {
            guard let data = detailPerson else { return }
            data.name = textName?.text ?? ""
            data.phone = Int(textPhone?.text ?? "0") ?? 0
            realm.add(data, update: .modified)
        }
        navigationController?.popViewController(animated: true)
    }
    

}
