//
//  adding.swift
//  to do list
//
//  Created by elva wang on 11/13/17.
//  Copyright © 2017 elva wang. All rights reserved.
//

import Foundation
import UIKit

class AddingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var delegate: AddingDelegation?
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var detailLabel: UITextField!
    @IBOutlet weak var datePickerLabel: UIDatePicker!
    
    @IBAction func addPressed(_ sender: UIButton) {
        let title = titleLabel.text!
        let detail = detailLabel.text!
        let date = datePickerLabel.date as NSDate
        print("xxxxxxxxxxxxxxxxxxxxxxxx\(title)")
        print(detail)
        print(date)
        delegate?.addingfunc(controller: self, title: title, detail: detail, date: date)

    }
    
    
}
