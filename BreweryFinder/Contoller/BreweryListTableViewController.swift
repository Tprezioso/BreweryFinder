//
//  BreweryListTableViewController.swift
//  BreweryFinder
//
//  Created by Thomas Prezioso on 7/6/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import UIKit

class BreweryListTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var clientCall = ClientCall()
    var searchData = [[String : Any]]()
   
    // Mark: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        getData()
    }
    
    // MARK: - Retrive Data
    
    func getData() {
        DispatchQueue.main.async {
            self.clientCall.searchBreweryByName(completion: { (json) in
                self.searchData = json!
                self.tableView.reloadData()
            })
            
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreweryCell", for: indexPath)
        cell.textLabel?.text = self.searchData[indexPath.row]["name"] as! String?

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegue(withIdentifier: "detailSegueIdentifier", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let  destinationVC = segue.destination as! DetailViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.detailBreweryArray = searchData[indexPath.row] 
        }
    }

}

// MARK: - Search Bar Methods

extension BreweryListTableViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        self.arr  = arr.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        print("working")
        tableView.reloadData()
//

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            print("working")
//            getData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.tableView.reloadData()
            }
        }
    }

}
