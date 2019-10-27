//
//  EmergencyViewController.swift
//  sMARTA
//
//  Created by Declan Nelson on 10/26/19.
//  Copyright © 2019 Declan Nelson. All rights reserved.
//

import UIKit

class EmergencyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        performSegue(withIdentifier: "backToInProgress", sender: self)
    }
    
    @IBAction func callEmergency(_ sender: Any) {
        if let phoneURL = NSURL(string: ("tel://" + "2404086371")) {

            let alert = UIAlertController(title: ("Call " + "2404086371" + "?"), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { (action) in
                UIApplication.shared.open(phoneURL as URL, options: [:], completionHandler: nil)
            }))

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
