//
//  BarGraphviewController.swift
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

class BarGraphViewController: UIViewController, ChartViewDelegate
{
    var barChartView: BarChartView!
    
    var minAge: Int = 0, maxAge: Int = 0
    
    var numberofPeopleSignedUp: [Int] = [Int](repeating: 0, count: 2)
    
    var fromIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        barChartView = BarChartView(frame: self.view.frame)
        self.view.addSubview(barChartView)
        
        barChartView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).inset((self.navigationController?.navigationBar.frame.height)! + 10)
            make.bottom.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.leading.equalTo(self.view)
        }
        
        barChartView.delegate = self
        self.view.backgroundColor = .white
        barChartView.backgroundColor = .white
        
        let dob1 = 2016 - minAge, dob2 = 2016 - maxAge
        print("dob1: \(dob1), dob2: \(dob2)")
        
        var request = ""
        var secondRequest = ""
        
        switch fromIndex {
        case 2:
            // don something
            request = "https://v3v10.vitechinc.com/solr/participant/select?indent=on&q=dob%3A[\(dob2)-01-01T00%3A00%3A00Z%20TO%20\(dob1)-01-01T00%3A00%3A00Z]%20AND%20%7B!join%20from%3Dparticipant_id%20to%3Did%20fromIndex%3Dpolicy_info%7Dinsurance_coverage%3ASingle&wt=json"
            secondRequest = "https://v3v10.vitechinc.com/solr/participant/select?indent=on&q=dob%3A[\(dob2)-01-01T00%3A00%3A00Z%20TO%20\(dob1)-01-01T00%3A00%3A00Z]%20AND%20%7B!join%20from%3Dparticipant_id%20to%3Did%20fromIndex%3Dpolicy_info%7Dinsurance_coverage%3AFamily&wt=json"
            break
        case 4:
            // do something
            request = "https://v3v10.vitechinc.com/solr/participant/select?indent=on&q=dob%3A[\(dob2)-01-01T00%3A00%3A00Z%20TO%20\(dob1)-01-01T00%3A00%3A00Z]%20AND%20%7B!join%20from%3Dparticipant_id%20to%3Did%20fromIndex%3Dpolicy_info%7Dinsurance_product%3AAccident&wt=json"
            
            secondRequest = "https://v3v10.vitechinc.com/solr/participant/select?indent=on&q=dob%3A[\(dob2)-02-01T00%3A00%3A00Z%20TO%20\(dob1)-01-01T00%3A00%3A00Z]%20AND%20%7B!join%20from%3Dparticipant_id%20to%3Did%20fromIndex%3Dpolicy_info%7Dinsurance_product%3ADental&wt=json"
            
        default:
            break
        }
        

        
        Alamofire.request(request).responseJSON(completionHandler: { response in
        
            if response.result.isSuccess
            {
                let json = JSON(response.result.value!)
                let numfound = json["response"]["numFound"].int!
                self.numberofPeopleSignedUp[0] = numfound
                print(json)
            }
            
            else
            {
                print("You blithering idiot!")
            }
        })
        

        
        Alamofire.request(secondRequest).responseJSON(completionHandler: { response in
        
            let json = JSON(response.result.value!)
            let numfound = json["response"]["numFound"].int!
            self.numberofPeopleSignedUp[1] = numfound
            print(json)
            self.setChart(data: Array(0..<self.numberofPeopleSignedUp.count), values: self.numberofPeopleSignedUp)
        })
        
        
    }
    
    func setChart(data: [Int], values: [Int])
    {
        barChartView.noDataText = ""
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<data.count - 1 {
            let dataEntry = BarChartDataEntry(x: 0, yValues: [Double(values[i])])
            dataEntries.append(dataEntry)
        }
        
        
        
        let dateEntries2: [BarChartDataEntry] = [BarChartDataEntry(x: 1, y: Double(values[1]))]
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Accidental")
        let chartDataSet2 = BarChartDataSet(values: dateEntries2, label: "Dental")
        
        let chartData = BarChartData(dataSets: [chartDataSet, chartDataSet2])
        barChartView.data = chartData
        
        barChartView.chartDescription?.text = ""
        
        //chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        chartDataSet.colors = ChartColorTemplates.material()
        chartDataSet2.colors = ChartColorTemplates.pastel()
        
        //barChartView.xAxis.labelPosition = .bottom
        
        //barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
        //        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        //barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
//        let ll = ChartLimitLine(limit: 10.0, label: "Target")
//        barChartView.rightAxis.addLimitLine(ll)
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight) {
        //print("\(entry.x) in \(numberofPeopleSignedUp[entry])")
    }
}
