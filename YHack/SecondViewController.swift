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
        let totalString = "http://v3v10.vitechinc.com/solr/policy_info/select?indent=on&q=promo_code%3D\(promocodes[indexPath.row])%20AND%20%7B!join%20from%3Did%20to%3Dparticipant_id%20fromIndex%3Dparticipant%7Dgender%3AM&wt=json"
        Alamofire.request(totalString).responseJSON(completionHandler: {response in
            
            let json = JSON(response.result.value!)
            print("JSON: \(json)")
            let numfound = json["response"]["numFound"].int!
            print("numFound: \(numfound)")
            self.total = numfound
        })
        
        let menString = "https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&q=promo_code%3\(promocodes[indexPath.row])%20AND%20%7B!join%20from%3Did%20to%3Dparticipant_id%20fromIndex%3Dparticipant%7Dgender%3AM&wt=json"
        
        Alamofire.request(menString).responseJSON(completionHandler: {response in
            let json = JSON(response.result.value!)
            self.numMen = json["response"]["numFound"].int!
            self.numWomen = self.total - self.numMen
        })
        
    }

}
