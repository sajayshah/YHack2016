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

class ChartsViewController: UIViewController, ChartViewDelegate
{
    @IBOutlet weak var pieChartView: PieChartView!
    var data: [Int] = [Int](repeating: 0, count: 2)
    var promocode: String = ""
    var fromIndex = 0
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //WARNING:- Unexpected query data
        pieChartView.noDataText = ""
        let activityview = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
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
            firstRequest = "https://v3v10.vitechinc.com/solr/participant/select?indent=on&q=dob%3A[1990-02-01T00%3A00%3A00Z%20TO%202016-03-01T00%3A00%3A00Z]%20AND%20%7B!join%20from%3Dparticipant_id%20to%3Did%20fromIndex%3Dpolicy_info%7Dinsurance_product%3AAccident&wt=json"
            secondrequest = ""
        default: break
            
        }
        
        Alamofire.request(firstRequest).responseJSON(completionHandler: {response in
            let json = JSON(response.result.value!)
            print("JSON: \(json)")
            let numfound = json["response"]["numFound"].int!
            print("numFound1: \(numfound)")
            self.data[0] = numfound
            activityview.stopAnimating()
            activityview.snp.removeConstraints()
            activityview.removeFromSuperview()
        })
        
        Alamofire.request(secondrequest).responseJSON(completionHandler: {response in
            let json = JSON(response.result.value!)
            print("JSON2: \(json)")
            let numFemales = json["response"]["numFound"].int!
            print("numFound2: \(numFemales)")
            self.data[1] = numFemales
            self.setChart(dataPoints: Array(0..<self.data.count), values: self.data.map({Double($0)}))
            activityview.stopAnimating()
            activityview.snp.removeConstraints()
            activityview.removeFromSuperview()
        })
        
    }
    
    func setChart(dataPoints: [Int], values: [Double]) {
        
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<dataPoints.count
        {
            let dataEntry = PieChartDataEntry(value: values[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        
        pieChartDataSet.colors = ChartColorTemplates.colorful()
    }
}
