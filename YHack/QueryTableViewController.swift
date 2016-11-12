//
//  DatePickerViewController.swift
//  YHack
//
//  Created by Atharva Vaidya on 2016-11-12.
//  Copyright © 2016 Atharva. All rights reserved.
//

import UIKit

class QueryTableViewController: UITableViewController
{
    //Min age, max age, Insurance product: Accidental or dental.
    @IBOutlet weak var minTextfield: UITextField!
    @IBOutlet weak var maxTextField: UITextField!
    
    @IBAction func donePressed(_ sender: UIBarButtonItem)
    {
        if minTextfield.text == nil && maxTextField.text == nil { return }
        else
        {
            let vc = BarGraphViewController()
            if let minAge = self.minTextfield.text
            {
                vc.minAge = Int(minAge)!
            }
            if let maxAge = self.maxTextField.text
            {
                vc.maxAge = Int(maxAge)!
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
