//
//  RestaurantTableViewController.swift
//  Foodpin
//
//  Created by Apple on 2018/3/22.
//  Copyright © 2018年 Gamma. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    var restaurantImages = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg", "cafeloisl.jpg", "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg", "bourkestreetbakery.jpg", "haighschocolate.jpg", "palominoespresso.jpg", "upstate.jpg", "traif.jpg", "grahamavenuemeats.jpg", "wafflewolf.jpg", "fiveleaves.jpg", "cafelore.jpg", "confessional.jpg", "barrafina.jpg", "donostia.jpg", "royaloak.jpg", "caskpubkitchen.jpg"]
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]

    //宣告21個false用來記錄是否有勾選
    var restaurantIsVisited = Array(repeating: false, count: 21)

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
        return restaurantNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //這裡要打大寫開頭
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        as! RestaurantTableViewCell

        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]

        //圓角(兩行)
        cell.thumbnailImageView.layer.cornerRadius = 30.0
        cell.thumbnailImageView.clipsToBounds = true

        //這裡也要加 不然拖曳 會標到別列
        cell.accessoryType = restaurantIsVisited[indexPath.row] ? .checkmark : .none

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
        let title = self.restaurantIsVisited[indexPath.row] ? "Undo check in" : "Check in"

        let checkAction = UIAlertAction(title: title, style: .default, handler:
        {
            (action: UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath)

            //原本有勾選的取消 沒有就勾選
            if self.restaurantIsVisited[indexPath.row] {
                cell?.accessoryType = .none
                self.restaurantIsVisited[indexPath.row] = false
            } else {
                cell?.accessoryType = .checkmark
                self.restaurantIsVisited[indexPath.row] = true
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
        print("Total item: \(restaurantNames.count)")
        if editingStyle == .delete {
            // Delete the row from the data source
            deleteRow(indexPath: indexPath)

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }

        // comfirm the item was deleted
        print("Total item: \(restaurantNames.count)")
        for item in restaurantNames {
            print(item)
        }
    }

    private func deleteRow(indexPath: IndexPath) {
        restaurantNames.remove(at: indexPath.row)
        restaurantLocations.remove(at: indexPath.row)
        restaurantTypes.remove(at: indexPath.row)
        restaurantIsVisited.remove(at: indexPath.row)
        restaurantImages.remove(at: indexPath.row)
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
                    let defaultText = "Just checking in at " + self.restaurantNames[indexPath.row]
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
                let destinationControllor = segue.destination as! RestaurantDetailViewController
                destinationControllor.restaurantImage = restaurantImages[indexPath.row]
            }
        }
    }

}
