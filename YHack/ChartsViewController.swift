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

class ChartsViewController: UIViewController
{
    var chartView: UIView = UIView()
    var pieChartview: PieChartView!
    var data: [Int] = [Int]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(chartView)
        chartView.snp.makeConstraints({ (make) -> Void in
            let superview = self.view!
            make.trailing.equalTo(superview)
            make.leading.equalTo(superview)
            make.height.equalTo(superview).dividedBy(2)
            make.centerY.equalTo(superview)
        })
        
        pieChartview = PieChartView(frame: chartView.frame)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pieChartview
    }
}
