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

class ChartsViewController: UIViewController, ChartViewDelegate
{
    var pieChartview: PieChartView = PieChartView()
    var data: [Int] = [Int]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(pieChartview)
        pieChartview.snp.makeConstraints({ (make) -> Void in
            let superview = self.view!
            make.trailing.equalTo(superview)
            make.leading.equalTo(superview)
            make.height.equalTo(superview).dividedBy(2)
            make.centerY.equalTo(superview)
        })
        
        self.pieChartview.delegate = self
        //self.setup(pieChartView: self.pieChartview)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let chartdataentrys = data.map({ PieChartDataEntry(value: Double($0)) })
        let dataset = PieChartDataSet(values: chartdataentrys, label: "Gender")
        dataset.colors = [.blue, .black]
        let dataP = PieChartData(dataSet: dataset)
        
        pieChartview.data = dataP
        
    }
    
    func setDataCount(count: Int, range: Double)
    {
//        let mult = range
//        let values: [PieChartDataEntry] = [PieChartDataEntry]()
//        value =
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight)
    {
        print("Entry: \(entry) highlighted")
    }
    
    func setup(pieChartView chartView: PieChartView)
    {
        chartView.usePercentValuesEnabled = true
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.58
        
        chartView.transparentCircleRadiusPercent = 0.61;
        chartView.chartDescription?.enabled = false
        chartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        
        chartView.drawCenterTextEnabled = true;
        
        chartView.drawHoleEnabled = true;
        chartView.rotationAngle = 0.0;
        chartView.rotationEnabled = true;
        chartView.highlightPerTapEnabled = true;
        
        let l: Legend = chartView.legend;
        l.horizontalAlignment = .right;
        l.verticalAlignment = .top;
        l.orientation = .vertical;
        l.drawInside = false;
        l.xEntrySpace = 7.0;
        l.yEntrySpace = 0.0;
        l.yOffset = 0.0;

    }
}
