//
//  ArrivedViewController.swift
//  sMARTA
//
//  Created by Declan Nelson on 10/26/19.
//  Copyright © 2019 Declan Nelson. All rights reserved.
//

import UIKit

class ArrivedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func newTrip(_ sender: Any) {
        performSegue(withIdentifier: "unwindToViewController1", sender: self)
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
