//
//  ViewController.swift
//  TestSwift
//
//  Created by WangShuChao on 2017/8/16.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var total = 0
        for i in 0..<4 {
            total += i
        }
        print(total)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

