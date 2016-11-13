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
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promocodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondTableViewCells")!
        cell.textLabel?.font = UIFont(name:"Helvetica Neue-Medium", size:24)
        cell.textLabel?.text = promocodes[indexPath.row]

        cell.textLabel?.textColor = UIColor(red:0.00, green:0.85, blue:0.45, alpha:1.00)
        cell.textLabel?.textAlignment = NSTextAlignment.center
        
        cell.backgroundColor = UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = cell.contentView.backgroundColor;
        let whiteRoundedView : UIView = UIView(frame: CGRect(origin: CGPoint(x: 10, y: 0), size: CGSize(width: self.view.frame.size.width - 20, height: 120)))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 10.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: -1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if fromIndex == 6
        {
            let usmapVC = USMapviewController()
            usmapVC.promocode = promocodes[indexPath.row]
            self.navigationController?.pushViewController(usmapVC, animated: true)
        }
        else
        {
            let chartVC = ChartsViewController()
            chartVC.data = [self.numMen, self.numWomen]
            self.performSegue(withIdentifier: "showChart", sender: self)
        }
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
