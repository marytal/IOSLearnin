//
//  ViewController.swift
//  takeTwo
//
//  Created by Mary Briskin on 3/1/16.
//  Copyright © 2016 Mary Briskin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func videoButtonsProj(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        self.presentViewController(resultViewController, animated:true, completion:nil)
    }
    
    @IBAction func addName(sender: AnyObject) {
        let alert = UIAlertController(title: "New Name",
            message: "Add a new name",
            preferredStyle: .Alert)
        let saveAction = UIAlertAction(title: "Save",
            style: .Default,
            handler: { (action:UIAlertAction) -> Void in

                let textField = alert.textFields!.first
                self.saveName(textField!.text!)
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

    var events = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "The List"
        tableView.registerClass(UITableViewCell.self,
          forCellReuseIdentifier:  "Cell")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest = NSFetchRequest(entityName: "Event")

        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            events = results as! [NSManagedObject]
        } catch let error as NSError {
            print(error)
        }
    }

    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return events.count
    }

    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")

            let event = events[indexPath.row]

            cell!.textLabel!.text = event.valueForKey("name") as? String

            return cell!
    }

    func saveName(name: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let entity = NSEntityDescription.entityForName("Event",
            inManagedObjectContext: managedContext)

        let event = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)

        event.setValue(name, forKey: "name")

        do {
            try managedContext.save()
            events.append(event)
        } catch let error as NSError {
            print("Error stuff: \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

