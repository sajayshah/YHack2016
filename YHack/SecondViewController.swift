//
//  SecondViewController.swift
//  YHack
//
//  Created by Atharva Vaidya on 2016-11-11.
//  Copyright © 2016 Atharva. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SecondTableViewController: UITableViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    
    var fromIndex: Int = 0
    var total = 0
    var numMen = 0, numWomen = 0
    
    let promocodes: [String] = ["ACCOFF10", "FREESPOUSE", "FINCON"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promocodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondTableViewCells")!
        cell.textLabel?.text = promocodes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let chartVC = ChartsViewController()
        chartVC.data = [self.numMen, self.numWomen]
        self.performSegue(withIdentifier: "showChart", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showChart"
        {
            let destinationVC = segue.destination as! ChartsViewController
            destinationVC.fromIndex = fromIndex
            destinationVC.promocode = promocodes[(self.tableView.indexPathForSelectedRow?.row)!]
        }
    }
}
