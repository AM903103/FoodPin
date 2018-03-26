//
//  RestaurantTableViewController.swift
//  Foodpin
//
//  Created by Apple on 2018/3/22.
//  Copyright © 2018年 Gamma. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var restaurants:[Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", phone: "232-923423", image: "cafedeadend.jpg", isVisited: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", phone: "348-233423", image: "homei.jpg", isVisited: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", phone: "354-243523", image: "teakha.jpg", isVisited: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", phone: "453-333423", image: "cafeloisl.jpg", isVisited: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", phone: "983-284334", image: "petiteoyster.jpg", isVisited: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", phone: "232-434222", image: "forkeerestaurant.jpg", isVisited: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", phone: "234-834322", image: "posatelier.jpg", isVisited: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", phone: "982-434343", image: "bourkestreetbakery.jpg", isVisited: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", phone: "734-232323", image: "haighschocolate.jpg", isVisited: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", phone: "872-734343", image: "palominoespresso.jpg", isVisited: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", phone: "343-233221", image: "upstate.jpg", isVisited: false),
        Restaurant(name: "Traif", type: "American", location: "New York", phone: "985-723623", image: "traif.jpg", isVisited: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", phone: "455-232345", image: "grahamavenuemeats.jpg", isVisited: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", phone: "434-232322", image: "wafflewolf.jpg", isVisited: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", phone: "343-234553", image: "fiveleaves.jpg", isVisited: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", phone: "342-455433", image: "cafelore.jpg", isVisited: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", phone: "643-332323", image: "confessional.jpg", isVisited: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", phone: "542-343434", image: "barrafina.jpg", isVisited: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", phone: "722-232323", image: "donostia.jpg", isVisited: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", phone: "343-988834", image: "royaloak.jpg", isVisited: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", phone: "432-344050", image: "caskpubkitchen.jpg", isVisited: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //這裡要打大寫開頭
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        as! RestaurantTableViewCell

        cell.nameLabel.text = restaurants[indexPath.row].name
        cell.thumbnailImageView.image = UIImage(named: restaurants[indexPath.row].image)
        cell.locationLabel.text = restaurants[indexPath.row].location
        cell.typeLabel.text = restaurants[indexPath.row].type

        //圓角(兩行)
        cell.thumbnailImageView.layer.cornerRadius = 30.0
        cell.thumbnailImageView.clipsToBounds = true

        //這裡也要加 不然拖曳 會標到別列
        cell.accessoryType = restaurants[indexPath.row].isVisited ? .checkmark : .none

        return cell
    }

    //直接在appcode裡直接打didselect
    //被點選後的事件
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //super.tableView(tableView, didSelectRowAt: indexPath)
//        //彈出視窗
//        let optionMenu = UIAlertController(
//                title: nil, //可以加字串
//                message: "What do you want to do?",
//                preferredStyle: .alert) //UIAlertControllerStyle.actionSheet一樣的 也可以.alert
//        //alert是Modal 且視窗出現在中間
//        //actionSheet 可以點外面就取消 視窗出現在最底部
//
//        addCancelAction(indexPath: indexPath, optionMenu: optionMenu)
//        addCheckAction(tableView: tableView, indexPath: indexPath, optionMenu: optionMenu)
//        present(optionMenu, animated: true, completion: nil)
//        tableView.deselectRow(at: indexPath, animated: false)
//    }

    private func addCheckAction(tableView: UITableView, indexPath: IndexPath, optionMenu: UIAlertController) {
        let title = self.restaurants[indexPath.row].isVisited ? "Undo check in" : "Check in"

        let checkAction = UIAlertAction(title: title, style: .default, handler:
        {
            (action: UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath)

            //原本有勾選的取消 沒有就勾選
            if self.restaurants[indexPath.row].isVisited {
                cell?.accessoryType = .none
                self.restaurants[indexPath.row].isVisited = false
            } else {
                cell?.accessoryType = .checkmark
                self.restaurants[indexPath.row].isVisited = true
            }
        })
        optionMenu.addAction(checkAction)
    }

    private func addCancelAction(indexPath: IndexPath, optionMenu: UIAlertController) {
        let callActionHandler = { (action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message:
            "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }

        let cancelAction = UIAlertAction(
                title: "Call" + "123-000-\(indexPath.row)", //"Cancel"
                style: .cancel, //.cancel或default或destruct(title:"Cancel" 變紅字)
                handler: callActionHandler)
        optionMenu.addAction(cancelAction)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("Total item: \(restaurants.count)")
        if editingStyle == .delete {
            // Delete the row from the data source
            deleteRow(indexPath: indexPath)

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    private func deleteRow(indexPath: IndexPath) {
        restaurants.remove(at: indexPath.row)
        //從tableView移除特定列(或多列)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = addShareAction()
        let deleteAction = addDeleteAction()

        //注意順序:index越小的在UI的越右邊
        return [deleteAction, shareAction]
    }

    private func addDeleteAction() -> UITableViewRowAction { //Delete Button
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete",
                handler: { (action, indexPath) -> Void in
                    self.deleteRow(indexPath: indexPath)
                })
        return deleteAction
    }

    private func addShareAction() -> UITableViewRowAction { //Share Button
        let shareAction = UITableViewRowAction(style: .default, title: "Share",
                handler: { (action, indexPath) -> Void in
                    let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
                    let activityController =
                            UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
                    self.present(activityController, animated: true, completion: nil)
                })

        shareAction.backgroundColor = UIColor(red: 48 / 255, green: 173 / 255, blue: 203 / 255, alpha: 1.0)
        return shareAction
    }

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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showRestaurantDetail") {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = restaurants[indexPath.row]
            }
        }
    }
}
