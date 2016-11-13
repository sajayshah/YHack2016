//
//  ChartsViewController.swift
//  YHack
//
//  Created by Atharva Vaidya on 2016-11-12.
//  Copyright © 2016 Atharva. All rights reserved.
//

import UIKit
import Charts
import SnapKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import FSInteractiveMap

enum InsuranceTypes: String
{
    case regular = "Regular", silver = "Silver", gold = "Gold", premium = "Premium"
}

class ChartsViewController: UIViewController, ChartViewDelegate
{
    @IBOutlet weak var pieChartView: PieChartView!
    var data: [Int] = [Int](repeating: 0, count: 2)
    var promocode: String = ""
    var insuranceProduct: String = ""
    var fromIndex = 0
    var genericdictionaryUsedToSaveJSONData: [String : Int] = [String : Int]()
    var activityview = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //WARNING:- Unexpected query data
        pieChartView.noDataText = ""
        self.view.addSubview(activityview)
        activityview.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self.view)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        activityview.color = UIColor.black
        activityview.startAnimating()
        print(activityview.animating)
        var firstRequest = "", secondrequest = ""
        switch fromIndex
        {
        case 0:
            
            firstRequest = "https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&q=promo_code%3D\(promocode)%20AND%20%7B!join%20from%3Did%20to%3Dparticipant_id%20fromIndex%3Dparticipant%7Dgender%3AM&wt=json"
            secondrequest = "https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&q=promo_code%3D\(promocode)%20AND%20%7B!join%20from%3Did%20to%3Dparticipant_id%20fromIndex%3Dparticipant%7Dgender%3AF&wt=json"

        case 1:
             firstRequest = "https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&q=promo_code%3D\(promocode)%20AND%20%7B!join%20from%3Did%20to%3Dparticipant_id%20fromIndex%3Dparticipant%7Dmarital_status%3AS&wt=json"
            secondrequest = "https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&q=promo_code%3D\(promocode)%20AND%20%7B!join%20from%3Did%20to%3Dparticipant_id%20fromIndex%3Dparticipant%7Dmarital_status%3AM&wt=json"
            
        case 2:
            firstRequest = ""
            secondrequest = ""
            return
        case 3:
            firstRequest = ""
            secondrequest = ""
            print("Calling season data")
            getSeasonData()
            return
            
        case 10:
            firstRequest = "https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&q=insurance_product:Dental&wt=json"
            secondrequest = "https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&q=insurance_product:Accident&wt=json"
        case 11:
            firstRequest = ""
            secondrequest = ""
            getPlanTypes()
            return
        case 12:
            firstRequest = "https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&q=insurance_coverage:Family&wt=json"
            secondrequest = "https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&q=insurance_coverage:Single&wt=json"
        case 13:
            firstRequest = "https://v3v10.vitechinc.com/solr/participant/select?indent=on&q=marital_status:M&wt=json"
            secondrequest = "https://v3v10.vitechinc.com/solr/participant/select?indent=on&q=marital_status:S&wt=json"
        case 14:
            firstRequest = "https://v3v10.vitechinc.com/solr/participant/select?indent=on&q=gender:F&wt=json"
            secondrequest = "https://v3v10.vitechinc.com/solr/participant/select?indent=on&q=gender:M&wt=json"
            
            
        default: break
            
        }
        
        Alamofire.request(firstRequest).responseJSON(completionHandler: {response in
            let json = JSON(response.result.value!)
            print("JSON: \(json)")
            let numfound = json["response"]["numFound"].int!
            print("numFound1: \(numfound)")
            self.data[0] = numfound
            self.activityview.stopAnimating()
            self.activityview.snp.removeConstraints()
            self.activityview.removeFromSuperview()
        })
        
        Alamofire.request(secondrequest).responseJSON(completionHandler: {response in
            let json = JSON(response.result.value!)
            print("JSON2: \(json)")
            let numFemales = json["response"]["numFound"].int!
            print("numFound2: \(numFemales)")
            self.data[1] = numFemales
            self.setChart(dataPoints: Array(0..<self.data.count), values: self.data.map({Double($0)}))
            self.activityview.stopAnimating()
            self.activityview.snp.removeConstraints()
            self.activityview.removeFromSuperview()
        })
        
    }
    
    func getSeasonData()
    {
//        https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&q=policy_start_date:[2016-02-01T00:00:00Z%20TO%202016-03-01T00:00:00Z]AND{!join%20from=id%20to=id%20fromIndex=policy_info}insurance_product:Accident&wt=json
        var querySeasonParameters:[String] = [
            "2015-01-01T00:00:00Z%20TO%202015-03-31T00:00:00Z",
            "2015-04-01T00:00:00Z%20TO%202015-06-30T00:00:00Z",
            "2015-07-01T00:09:30Z%20TO%202015-09-30T00:00:00Z",
            "2015-10-01T00:00:00Z%20TO%202015-12-31T00:00:00Z",
            "2016-01-01T00:00:00Z%20TO%202016-03-31T00:00:00Z",
            "2016-04-01T00:00:00Z%20TO%202016-06-30T00:00:00Z",
            "2016-07-01T00:09:30Z%20TO%202016-09-30T00:00:00Z",
            "2016-10-01T00:00:00Z%20TO%202016-12-31T00:00:00Z"]
        
        var request = ""
        
        for (index, season) in querySeasonParameters.enumerated()
        {
            print(season)
            request = "https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&q=policy_start_date:%5B\(querySeasonParameters[index])%5DAND%7B!join%20from=id%20to=id%20fromIndex=policy_info%7Dinsurance_product:\(insuranceProduct)&wt=json"
            print(request)
            Alamofire.request(request).responseJSON(completionHandler: {response in
                guard let resultValue = response.result.value else { fatalError("couldn't parse JSON") }
                let json = JSON(resultValue)
                
                guard let numberOfPeople = json["response"]["numFound"].int else { fatalError("couldn't parse number of people" ) }
                print(json)
                guard let timeParameter = json["responseHeader"]["params"].dictionary?["q"]?.string else { fatalError("Couldn't parse policy date") }
                self.genericdictionaryUsedToSaveJSONData["\(timeParameter.components(separatedBy: "TO")[0].components(separatedBy: "[")[1])"] = numberOfPeople
                print("\(timeParameter.components(separatedBy: "TO")[0].components(separatedBy: "[")[1])")
                
                if season == querySeasonParameters.last!
                {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    let df = self.genericdictionaryUsedToSaveJSONData.sorted(by: { dateFormatter.date(from: $0.0)! < dateFormatter.date(from: $1.0)! })
                    print(df)
                    self.setChart(dates: df.map({$0.key}), values: df.map({Double($0.value)}), isInsurance: false)
                    self.activityview.stopAnimating()
                    self.activityview.snp.removeConstraints()
                    self.activityview.removeFromSuperview()
                }
            })
        }
    }
    
    
    func setChart(dataPoints: [Int], values: [Double])
    {
        
        var dataEntries: [PieChartDataEntry] = []
        
        
        var parameters: [String] = ["unhandled", "unhandled"]
        
        switch fromIndex {
        case 0:
            parameters = ["Male", "Female"]
        case 1:
            parameters = ["Married", "Single"]
        case 4:
            break
        case 5:
            break
        case 10:
            parameters = ["Dental", "Accident"]
        case 11:
            break
        case 12:
            parameters = ["Family", "Single"]
        case 13:
            parameters = ["Married", "Single"]
        case 14:
            parameters = ["Male", "Female"]
        default:
            break
        }
        
//        parameters: [String] = fromIndex == 0 ? ["Male", "Female"] : ["Single", "Married"]
//        parameters: [String] = fromIndex == 10 ? ["Dental", "Accident"]
        for i in 0..<dataPoints.count
        {
            let dataEntry = PieChartDataEntry(value: values[i], label: parameters[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        
        pieChartDataSet.colors = ChartColorTemplates.pastel()
    }
    
    func getPlanTypes() {
        
        var planTypes:[String] = ["Gold", "Silver", "Regular", "Premium"]
        
        var request = ""
        var planResults:[String : Int] = [:]
        
        
        for (index, plan) in planTypes.enumerated()
        {
            print(plan)
            request = "https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&q=insurance_plan:\(planTypes[index])&wt=json"
            print(request)
            Alamofire.request(request).responseJSON(completionHandler: {response in
                guard let resultValue = response.result.value else { fatalError("couldn't parse JSON") }
                let json = JSON(resultValue)
                
                guard let insuranceType = json["responseHeader"]["params"].dictionary?["q"]?.string else { fatalError("couldn't parse number of people" ) }
                print(json)
                
                guard let numberOfPeople = json["response"]["numFound"].int else { fatalError("couldn't parse number of people" ) }
                
                planResults[insuranceType] = planResults[insuranceType]! + numberOfPeople
                //Gold, Premium, Silver, Regular
                if index == planTypes.count - 1
                {
                    self.setChart(dates: planResults.map({$0.key}), values: planResults.map({Double($0.value)}), isInsurance: true)
                    self.activityview.stopAnimating()
                    self.activityview.snp.removeConstraints()
                    self.activityview.removeFromSuperview()
                }
            })
        }
        
    }
    
    func setChart(dates: [String], values: [Double], isInsurance: Bool)
    {
        var dataEntries: [PieChartDataEntry] = []
        
        
        
        for i in 0...3
        {
            let dataEntry = !isInsurance ? PieChartDataEntry(value: values[i] + values[i + 4], label: ["Winter", "Spring", "Summer", "Fall"][i]) : PieChartDataEntry(value: values[i], label: ["Regular", "Silver", "Gold", "Premium"][i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        
        pieChartDataSet.colors = ChartColorTemplates.pastel()
    }
}
