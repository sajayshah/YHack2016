//
//  InsuranceProductTableViewController.swift
//  YHack
//
//  Created by Sajay Shah on 11/12/16.
//  Copyright © 2016 Atharva. All rights reserved.
//

import UIKit

class InsuranceProductTableViewController: UITableViewController {
    
    var fromIndex: Int = 0
    let insuranceProducts: [String] = ["Accident", "Dental"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return insuranceProducts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "insuranceProductCells")!
        cell.textLabel?.font = UIFont(name:"Helvetica Neue-Medium", size:24)
        cell.textLabel?.text = insuranceProducts[indexPath.row]
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
        self.performSegue(withIdentifier: "showChart2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showChart2"
        {
            let destinationVC = segue.destination as! ChartsViewController
            destinationVC.fromIndex = fromIndex
            destinationVC.insuranceProduct = insuranceProducts[(self.tableView.indexPathForSelectedRow?.row)!]
        }
        
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
