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
    let relations: [String] = ["Promocode vs Gender", "Promocode vs Marital Status", "Promocode vs Age Range"]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcell")!
        
        cell.textLabel?.text = relations[indexPath.row]
        cell.textLabel?.font = UIFont(name:"Avenir", size:22)
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0) : UIColor.blue

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = cell.contentView.backgroundColor;
        let whiteRoundedView : UIView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.size.width, height: 120)))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 10.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: -1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return relations.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 { self.performSegue(withIdentifier: "toBarGraph", sender: self) }
        else { self.performSegue(withIdentifier: "toSecondVC", sender: self) }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC"
        {
            let destinationVC = segue.destination as! SecondTableViewController
            destinationVC.fromIndex = (self.tableView.indexPathForSelectedRow?.row)!
        }
        
    }
}

