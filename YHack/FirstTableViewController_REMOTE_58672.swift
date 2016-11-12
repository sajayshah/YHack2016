//
//  ViewController.swift
//  YHack
//
//  Created by Atharva Vaidya on 2016-11-11.
//  Copyright © 2016 Atharva. All rights reserved.
//

import UIKit
import Charts

//#00C9FF, 92FE9D
class FirstViewController: UITableViewController
{
    //
    let relations: [String] = ["Promocode vs Gender", "Promocode vs Marital Status"]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcell")!
        
        cell.textLabel?.text = relations[indexPath.row]
        cell.textLabel?.font = UIFont(name:"Helvetica", size:22)
        cell.textLabel?.textColor = UIColor.purple
        cell.textLabel?.textAlignment = NSTextAlignment.center
        cell.backgroundColor = UIColor(red: 207.0 / 255.0, green: 238.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0)

        // cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0) : UIColor.blue
              
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(red: 207.0 / 255.0, green: 238.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0)
        let whiteRoundedView : UIView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.size.width, height: 120)))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 10.0
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return relations.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC"
        {
            let destinationVC = segue.destination as! SecondTableViewController
            destinationVC.fromIndex = (self.tableView.indexPathForSelectedRow?.row)!
        }
    }
}

