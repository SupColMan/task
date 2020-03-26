//
//  TodosController.swift
//  Todos
//
//  Created by apple on 2020/3/16.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RealmSwift

class TodosController: UITableViewController {
    
    
    //    var todos:[Todo] = []
    var todos:Results<Todo>?
    var row = 0
    
    let realm = try! Realm()
    
    //    @IBAction func bathDelete(_ sender: Any) {
    //        if let indexPaths = tableView.indexPathsForSelectedRows{
    //            for indexPath in indexPaths{
    ////                todos.remove(at: indexPath.row)
    //            }
    ////            saveDate()
    //            tableView.beginUpdates()
    //            tableView.deleteRows(at: indexPaths, with: .automatic)
    //            tableView.endUpdates()
    //
    //
    //        }
    //
    //    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.title = "编辑"
        //        if let data = UserDefaults.standard.data(forKey: "todos"){
        //            do{
        ////               todos = try JSONDecoder().decode([Todo].self, from: data)
        //            }catch{
        //                print(error)
        //            }
        //        }
        todos = realm.objects(Todo.self)
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
    }
    //
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //重用单元格
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath) as! TodoCell
        if let todos = todos{
            cell.checkMark.text = todos[indexPath.row].checked ? "√" : ""
            cell.todo.text = todos[indexPath.row].name
        }
        
        
        
        // Configure the cell...
        
        return cell
    }
    
    //当此用户选中cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        do{
            try realm.write{
                todos![indexPath.row].checked = !todos![indexPath.row].checked
            }
        }catch{
            print(error)
        }
        tableView.reloadData()
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        do{
            try realm.write{
                realm.delete(todos![indexPath.row])
            }
        }catch{
            print(error)
        }
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        //
        
    }
    
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addTodo"{
            let vc = segue.destination as! TodoController
            vc.delegete = self
        }else if segue.identifier == "editTodo"{
            let vc = segue.destination as! TodoController
            let cell = sender as! TodoCell
            row = tableView.indexPath(for: cell)!.row
            vc.name = todos?[row].name
            vc.delegete = self
        }
        
    }
}
extension TodosController:TodoDelegate,UISearchBarDelegate{
    func didAdd(name: String) {
        let todo = Todo()
        todo.name = name
        saveDate(todo: todo )
        tableView.reloadData()
    }
    func didEdit(name: String) {
        do{
            try realm.write{
                todos![row].name = name
            }
        }catch{
            print(error)
        }
        tableView.reloadData()
    }
    //使用realm存储数据
    func saveDate(todo: Todo){
        do{
            try realm.write(){
                realm.add(todo)
            }
        }catch{
            print(error)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //        todos = realm.objects(Todo.self)
        todos = realm.objects(Todo.self).filter("name CONTAINS %@", searchBar.text!).sorted(byKeyPath: "createdAT", ascending: false)
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.isEmpty{
            //显示所有数据
            todos = realm.objects(Todo.self)
            tableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
    
    
}




