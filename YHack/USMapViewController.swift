//
//  USMapViewController.swift
//  YHack
//
//  Created by Atharva Vaidya on 2016-11-13.
//  Copyright © 2016 Atharva. All rights reserved.
//

import UIKit
import FSInteractiveMap
import Alamofire
import SwiftyJSON

class USMapviewController: UIViewController
{
    var promocode: String = String()
    var genericDictionaryToSaveJSONData: [String : Int] = [:]
    var map: FSInteractiveMapView = FSInteractiveMapView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map = FSInteractiveMapView(frame: self.view.frame)
        getDataFor50States()
    }
    
    func getDataFor50States()
    {
        var states = ""
        do
        {
            states = try String(contentsOf: Bundle.main.url(forResource: "states", withExtension: ".txt")!)
        }
        catch
        {
            print("Oh cock! couldn't get states.")
        }
        
        let statesArray = states.components(separatedBy: "\n").filter({$0 != ""})
        print("States: \(statesArray)")
        for (index, state) in statesArray.enumerated()
        {
            let request = "https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&q=promo_codes=\(promocode)%20AND%20%7B!join%20from=id%20to=participant_id%20fromIndex=participant%7Dstate:\(state)&wt=json"
            print(request)
            Alamofire.request(request).responseJSON(completionHandler: { response in
                
                if response.result.isSuccess
                {
                    guard let resultValue = response.result.value else { fatalError("couldn't parse JSON") }
                    let json = JSON(resultValue)
                    guard let numberOfPeople = json["response"]["numFound"].int else { fatalError("couldn't parse number of people" ) }
                    self.genericDictionaryToSaveJSONData[state] = numberOfPeople
                    print("\(numberOfPeople) in \(state)")
                    if index == 49
                    {
                        self.map.loadMap("usaHigh", withData: self.genericDictionaryToSaveJSONData, colorAxis: [UIColor.lightGray, UIColor.darkGray])
                        self.map.clickHandler = { (string, shapelayer) in print("\(string!) clicked") }
                    }
                }
                    
                else
                {
                    print("sorry mate it failed. \(response.data)\n\(response.result)))")
                }
            })
        }
    }
}
