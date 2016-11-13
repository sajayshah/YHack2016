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
    //@IBOutlet weak var detailButton: UIButton!
    //
    let relations: [String] = ["Promocode vs Gender", "Promocode vs Marital Status", "Age vs Insurance Coverage", "Season vs Insurance Product", "Age vs. Insurance Product"]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
    }
    


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcell")!
        
        cell.textLabel?.text = relations[indexPath.row]
        cell.textLabel?.font = UIFont(name:"Helvetica-Medium", size:24)
        cell.textLabel?.textColor = UIColor(red:0.00, green:0.85, blue:0.45, alpha:1.00)
        cell.textLabel?.textAlignment = NSTextAlignment.center
        cell.backgroundColor = UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0)
       // detailButton.tag = indexPath.row
        //detailButton.addTarget(self, action: Selector(("buttonClicked:")), for: UIControlEvents.touchUpInside)
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return relations.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 || indexPath.row == 2 { self.performSegue(withIdentifier: "toBarGraph", sender: self) }
        else if indexPath.row == 3 { self.performSegue(withIdentifier: "toSeasonVC", sender: self)}
        else { self.performSegue(withIdentifier: "toSecondVC", sender: self)}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toSecondVC"
        {
            let destinationVC = segue.destination as! SecondTableViewController
            destinationVC.fromIndex = (self.tableView.indexPathForSelectedRow?.row)!
        }
        else if segue.identifier == "toSeasonVC"
        {
           
        }
        else if segue.identifier == "toBarGraph"
        {
            let destinationVC = segue.destination as! QueryTableViewController
            destinationVC.fromIndex = (self.tableView.indexPathForSelectedRow?.row)!
        }
    }
    @IBAction func detailButtonTapped(_ sender: UIButton) {
        _ = sender.tag
    }
    
}

