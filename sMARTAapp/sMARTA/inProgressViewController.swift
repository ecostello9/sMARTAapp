//
//  inProgressViewController.swift
//  sMARTA
//
//  Created by Declan Nelson on 10/26/19.
//  Copyright © 2019 Declan Nelson. All rights reserved.
//

import UIKit

class inProgressViewController: UIViewController {

    
    @IBOutlet weak var arrivalTime: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var origin: UILabel!
    var start = Stop()
    var stop = Stop()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        origin.text = "Origin: " + start.name
        destination.text = "Destination: " + stop.name
        let date = Date()
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        var minutes = calendar.component(.minute, from: date)
        print(String(minutes))
        minutes = minutes + abs(_: start.offset - stop.offset)
        print(String(minutes))
        let leftover = minutes / 60
        hour = (hour + leftover) % 12
        minutes = minutes % 60
        if minutes < 10 {
            let strMin = "0" + String(minutes)
            arrivalTime.text = "Arrival Time: " + String(hour) + ":" + strMin
        } else {
            arrivalTime.text = "Arrival Time: " + String(hour) + ":" + String(minutes)
        }
        
    }
    

    @IBAction func arrivedPushed(_ sender: Any) {
        performSegue(withIdentifier: "toArrived", sender: self)
    }
    
    @IBAction func emergencyPushed(_ sender: Any) {
        performSegue(withIdentifier: "toEmergency", sender: self)
        
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
