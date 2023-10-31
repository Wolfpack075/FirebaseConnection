//
//  ViewController.swift
//  FirebaseConnection
//
//  Created by Shoumik Barman Polok on 31/10/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var queryField: UITextField!
    @IBOutlet weak var recordShow: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var fullName: UITextField!
    private let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FirebaseApp.configure()
        // Do any additional setup after loading the view.
        
        //let button = UIButton(frame: CGRect(x: 20, y: 200, width: view.frame.size.width-40, height: 50))
        //button.setTitle("Add entry", for: .normal)
        //button.setTitleColor(.white, for: .normal)
        //button.backgroundColor = .link
        //view.addSubview(button)
        //button.addTarget(self, action: #selector(addNewEntry), for: .touchUpInside)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        UploadToCloud()
        var input: String = queryField.text!
            database.child(input).observeSingleEvent(of: .value, with: { snapshot in
                guard let value = snapshot.value as? [String: Any] else {
                    return
                }
                do {
                    let jsonData = try
                    JSONSerialization.data(withJSONObject: value, options: [])
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        self.recordShow.text = jsonString
                    }
                } catch {
                    print("Error Converting")
                }
                
                print("value: \(value)")
                //self.recordShow.text = jsonString
            }
            )
        
    }
    
    func UploadToCloud(){
        let ref = Database.database().reference()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy";
        let strDate = dateFormatter.string(from: datePicker.date)
        
        let currentDateTime = dateFormatter.string(from: Date())
        
        ref.child(fullName.text!).setValue(
         [
            "Uploaded Time": currentDateTime,
            "Date": strDate,
            "name": fullName.text!
                                ]
        )
    }
    

}

