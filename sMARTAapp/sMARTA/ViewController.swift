//
//  ViewController.swift
//  SMARTA
//
//  Created by Declan Nelson on 10/26/19.
//  Copyright © 2019 Declan Nelson. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var dropdown1: UIPickerView!
    @IBOutlet weak var dropdown2: UIPickerView!
    @IBOutlet weak var userStart: UITextField!
    @IBOutlet weak var userStop: UITextField!
    @IBOutlet weak var timeToDest: UILabel!
    @IBOutlet weak var friend: UITextField!
    @IBOutlet weak var addedFriend: UILabel!
    var friendName: String!
    var trainTable = RedLine()
    //var trainTable = ["Atlantic Station": 0, "Dunwoody": 10, "Butt fuck no where": 15, "midtown": 17, "hell": 30]
    var first = false
    var start = Stop()
    var stop = Stop()
    var name: String!
    var numbers = [String]()
    
    //var stops = ["Atlantic Station", "Dunwoody", "Butt fuck no where", "midtown", "hell"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int = trainTable.size()
        if pickerView == dropdown2 {
        
        countrows = self.trainTable.size()
        }
        
        return countrows
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == dropdown1 {
        
            let titleRow = trainTable.get(getIndex: row).name

            return titleRow
            
        }

        else if pickerView == dropdown2{
            let titleRow = trainTable.get(getIndex: row).name
            
            return titleRow
        }
        
        return ""
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dropdown1 {
            self.userStart.text = trainTable.get(getIndex: row).name
            self.dropdown1.isHidden = false
            start.name = userStart.text!
            start.offset = trainTable.get(getIndex: row).offset
        }
        
        else if pickerView == dropdown2{
            self.userStop.text = trainTable.get(getIndex: row).name
            self.dropdown2.isHidden = false
            stop.name = userStop.text!
            stop.offset = trainTable.get(getIndex: row).offset

        }
        
        timeToDest.text = "Time to Destination: " + String(abs(_: start.offset - stop.offset)) + " mins"
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == self.userStart){
        self.dropdown1.isHidden = false
        
        }
        else if (textField == self.userStop){
            self.dropdown2.isHidden = false

            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userStart.delegate = self
        userStop.delegate = self
        friend.delegate = self
        friendName = "Friends Added: "
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == userStart) {
            userStart.resignFirstResponder()
            userStop.becomeFirstResponder()
            
        } else if (textField == userStop) {
            
            
            
            userStop.resignFirstResponder()
            friend.becomeFirstResponder()
        } else if (textField == friend){
            if (!first) {
                friendName = friendName + friend.text!
                first = true
            } else {
                friendName = friendName + ", " + friend.text!
            }
            name = friend.text!
            authContacts()

            addedFriend.text = friendName
            friend.resignFirstResponder()
            friend.text = ""
        }
        
        
        return true
    }
  
    @IBAction func startButton(_ sender: Any) {
        
        
        performSegue(withIdentifier: "moveToInProg", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is inProgressViewController
        {
            let vc = segue.destination as? inProgressViewController
            vc?.start = start
            vc?.stop = stop
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

    }
    
    func authContacts() {
        let store = CNContactStore()
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)

        // 2
        if authorizationStatus == .notDetermined {
            // 3
            store.requestAccess(for: .contacts) { [weak self] didAuthorize,
                error in
                if didAuthorize {
                    self?.retrieveContacts(from: store)
                }
            }
        } else if authorizationStatus == .authorized {
            retrieveContacts(from: store)
        }
        
    }

    func retrieveContacts(from store: CNContactStore) {
      // 4
      let keysToFetch = [CNContactPhoneNumbersKey as CNKeyDescriptor]
         let predicate: NSPredicate = CNContact.predicateForContacts(matchingName: name!)
      let contacts = try! store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)

      // 5
        if contacts.count > 0 {
            var toAdd = ""
            let isNum : String!
            isNum = "1234567890"
            let num = (contacts[0].phoneNumbers.first?.value)?.stringValue
            for char in num ?? "" {
                if isNum.contains(char) {
                    toAdd.append(char)
                }
            }
            numbers.append(toAdd)
            print(numbers)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
