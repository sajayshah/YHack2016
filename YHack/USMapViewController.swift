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
    var oldClickedLayer: CAShapeLayer?
    var labelForStates: UILabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map = FSInteractiveMapView(frame: self.view.frame)
        getDataFor50States()
        self.view.backgroundColor = .white
        labelForStates = UILabel(frame: CGRect(x: 9, y: 0, width: 320, height: 100))
        labelForStates.text = "Select a state"
        labelForStates.textColor = .black
        labelForStates.font = UIFont.systemFont(ofSize: 32)
        labelForStates.textAlignment = .center
        self.view.addSubview(labelForStates)
        labelForStates.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).inset(50)
            make.height.equalTo(100)
            make.centerX.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.leading.equalTo(self.view)
        }
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
                        self.map.clickHandler = { (string, shapelayer) in
                            print("\(string!) clicked")
                            if(self.oldClickedLayer != nil)
                            {
                                self.oldClickedLayer?.zPosition = 0;
                                self.oldClickedLayer?.shadowOpacity = 0;
                            }
                            
                            if self.oldClickedLayer == nil { self.oldClickedLayer = shapelayer }
                            
                            self.oldClickedLayer = shapelayer;
                            
                            // We set a simple effect on the layer clicked to highlight it
                            shapelayer?.zPosition = 10;
                            shapelayer?.shadowOpacity = 0.5;
                            shapelayer?.shadowColor = UIColor.black.cgColor;
                            shapelayer?.shadowRadius = 5
                            shapelayer?.shadowOffset = CGSize(width: 0, height: 0)
                            
                            if string == "US-OR"
                            {
                                self.labelForStates.text = "OR: \((self.genericDictionaryToSaveJSONData["%5COR"])!)"
                            }
                            else
                            {
                                self.labelForStates.text = "\((string?.components(separatedBy: "-")[1])!): \((self.genericDictionaryToSaveJSONData[(string?.components(separatedBy: "-")[1])!])!)"
                            }
                        
                        }
                        
                        DispatchQueue.main.async
                        {
                            self.view.addSubview(self.map)
                            self.map.snp.makeConstraints { (make) -> Void in
                                make.centerX.equalTo(self.view)
                                make.centerY.equalTo(self.view).offset(15)
                                make.height.equalTo(self.view).dividedBy(2)
                                make.width.equalTo(self.view).inset(5)
                            }
                        }
                    }
                }
                    
                else
                {
                    print("sorry mate it failed. \(response.data)\n\(response.result.error)))")
                }
            })
        }

        
        //self.map.backgroundColor = .lightGray
    }
}
