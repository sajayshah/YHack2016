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
class firstViewController: UITableViewController
{
    var dataPassed:String!
    //
    let relations: [String] = ["Promocode vs Gender"]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcell")!
        
        cell.textLabel?.text = relations[indexPath.row]
        
        let color = UIColor.blue.withAlphaComponent(indexPath.row % 2 == 0 ? 1.0 : 0.7)
        
        switch dataPassed {
            
        case "1":
            self.view.backgroundColor = UIColor(red: 0.3529, green: 0.7608, blue: 0.8471, alpha: 1.0)
            cell.textLabel?.textColor = UIColor.white
        case "2":
            self.view.backgroundColor = UIColor(red: 0.9882, green: 0.5804, blue: 0.0078, alpha: 1.0)
            cell.textLabel?.textColor = UIColor.white
            
        default: break
        }
        
        cell.backgroundColor = color
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = cell.contentView.backgroundColor;
        let whiteRoundedView : UIView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.size.width, height: 120)))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: -1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

}
