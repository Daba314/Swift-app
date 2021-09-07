//
//  ViewController.swift
//  ProjectDaba
//
//  Created by user198847 on 7/29/21.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var tableView: UITableView!
    
    
    //reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items:[News]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchNews()
    }
    
    func fetchNews(){
        //fetch the data from Core Data
        do{
            self.items = try context.fetch(News.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        catch{
            print("Error fetching news")
        }
    }
    private func addItem(withName labelNews: String) {
        //MARK: Creating new item
        // Create a new News object
        let newItem = News(context: context)
        newItem.labelNews = labelNews
        
        newItem.pictures = Data()
        
        // Save the data
        do {
            try self.context.save()
        } catch {
            print("Error saving context.")
        }
        
  
    }
    @IBAction func addBtn(_ sender: Any) {
        let alertController = UIAlertController(title: "Add news", message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        let addAction = UIAlertAction(title: "Add", style: .default, handler: { [weak alertController] (action) in
            if let text = alertController?.textFields?.first?.text, !text.isEmpty {
                self.addItem(withName: text)
                // Refresh table view
                self.fetchNews()
        
            }
        })
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Add news"
            textfield.addAction(UIAction(title: "", handler: { _ in
                addAction.isEnabled = !(textfield.text ?? "").isEmpty
            }), for: .editingChanged)
        }
        
        addAction.isEnabled = false
        alertController.addAction(addAction)
        
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
      
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Selected News
                let news = self.items![indexPath.row]

                // Create alert
                let alert = UIAlertController(title: "Edit news", message: "", preferredStyle: .alert)
                alert.addTextField()

                let textField = alert.textFields![0]
                textField.text = news.labelNews

                // Save button
                let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in

                    // Get the textField for the alert
                    let textField = alert.textFields![0]

                    // Edit name property of person object
                    news.labelNews = textField.text

                    // Save the data
                    do {
                        try self.context.save()
                    }
                    catch {
                        print("Eroor related to saving data")
                    }

                    // Re-fetch the data
                    self.fetchNews()
                }
                
                // Add Button
                alert.addAction(saveButton)
                
                // Show alert
                self.present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.items?.count)!
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        let news = self.items![indexPath.row]
        cell.textLabel?.text = news.labelNews
        //let me see whole text
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Create swipe
         let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, copletionHandler) in
             // Which news to remove
             let newsToRemove = self.items![indexPath.row]
             
             // Remove the news
             self.context.delete(newsToRemove)
             
             // Save the news
             do {
                 try! self.context.save()
             }
             catch {
                print("can not save news")
                 
             }
            self.fetchNews()
         }
         
         // Return swipe action
         return UISwipeActionsConfiguration(actions: [action])
    }
    
   
 


}

