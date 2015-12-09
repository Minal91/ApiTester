//
//  ViewController.swift
//  ApiTesterSwift
//
//  Created by punchh on 14/07/15.
//  Copyright (c) 2015 punchh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let tableData = [["name":"minal"],["name":"seema"],["name":"priya"]]
    var name:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "testCell")
        if let rowData:NSDictionary = self.tableData[indexPath.row] as NSDictionary?{
            name = rowData["name"] as! String?
                cell.textLabel?.text = self.name
        }
        return cell
    }

}

