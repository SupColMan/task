//
//  TodoController.swift
//  Todos
//
//  Created by apple on 2020/3/17.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RealmSwift

protocol TodoDelegate {
    func didAdd(name: String)
    func didEdit(name: String)
}


class TodoController: UITableViewController {

    var delegete: TodoDelegate?
    var name: String?
    
    @IBOutlet weak var todoInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoInput.becomeFirstResponder()
        todoInput.text = name
        
        if name != nil{
            navigationItem.title = "编辑记录"
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    @IBAction func done(_ sender: Any) {
        if !todoInput.text!.isEmpty{
            if (self.name != nil){
                delegete?.didEdit(name: todoInput.text!)
            }else{
                delegete?.didAdd(name: todoInput.text!)
            }

        }
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
