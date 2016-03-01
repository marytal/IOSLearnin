//
//  ViewController.swift
//  takeTwo
//
//  Created by Mary Briskin on 3/1/16.
//  Copyright © 2016 Mary Briskin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addName(sender: AnyObject) {
        let alert = UIAlertController(title: "New Name",
            message: "Add a new name",
            preferredStyle: .Alert)
        let saveAction = UIAlertAction(title: "Save",
            style: .Default,
            handler: { (action:UIAlertAction) -> Void in

                let textField = alert.textFields!.first
                self.names.append(textField!.text!)
                self.tableView.reloadData()


        })

        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction) -> Void in }

        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        presentViewController(alert,
            animated: true,
            completion: nil)
    }

    var names = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        title = "\"The List\""
        tableView.registerClass(UITableViewCell.self,
          forCellReuseIdentifier:  "Cell")
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return names.count
    }

    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
            cell!.textLabel!.text = names[indexPath.row]
            return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

