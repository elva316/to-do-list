//
//  ViewController.swift
//  to do list
//
//  Created by elva wang on 11/12/17.
//  Copyright © 2017 elva wang. All rights reserved.
//

import UIKit
import CoreData
import Foundation

protocol AddingDelegation {
    func addingfunc (controller: UIViewController, title: String, detail: String, date: NSDate)
}


class TodoListTableViewController: UITableViewController, AddingDelegation {
    
    
    
//    var myArray:[String] = []
    var dbList = [Item]()       //   ++++
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllTodoItems()
        // Do any additional setup after loading the view, typically from a nib.
//        myArray = ["xx", "xxx"]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! AddingViewController
        controller.delegate = self   //// ++++++++++  the delegate is what on AddingViewController
    }
    func addingfunc(controller: UIViewController, title: String, detail: String, date: NSDate) {
        if detail.count >= 1 {
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: managedObjectContext) as! Item
        item.title = title
        item.detail = detail
        item.date = date as Date
        item.completed = false
        dbList.append(item)
        saveContext()
        self.tableView.reloadData()
        }
        dismiss(animated: true, completion: nil)
        //        print("yyyyyyyyyyyyyyyyyyy\(title)")
        //        print(detail)
        //        print(date)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myArray.count
        return dbList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoCell", for: indexPath) as! ToDoCell
        cell.title.text = dbList[indexPath.row].title!
        cell.detail.text = dbList[indexPath.row].detail!
        cell.date.text = updateSelectedDate(date: dbList[indexPath.row].date! as Date)
        
        if dbList[indexPath.row].completed == true{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {    /// ++++
        if dbList[indexPath.row].completed == true{
            dbList[indexPath.row].completed = false
        } else {
            dbList[indexPath.row].completed = true
        }
        saveContext()
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    
    
    func fetchAllTodoItems() {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
//            dbList = request as! [Item]
            self.dbList = try managedObjectContext.fetch(request) as! [Item]
            self.tableView.reloadData()
        } catch {
            print(error)
        }
    }

    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    func updateSelectedDate (date: Date) -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM dd, YYYY"
        let selectedDate = dateformatter.string(from: date)
        return selectedDate
    }
}

