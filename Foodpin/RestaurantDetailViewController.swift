//
//  RestaurantDetailViewController.swift
//  Foodpin
//
//  Created by Apple on 2018/3/26.
//  Copyright © 2018年 Gamma. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var restaurant: Restaurant!

    @IBOutlet weak var restaurantImageView: UIImageView!

    @IBOutlet weak var tableview: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantDetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = (restaurant.isVisited) ? "Yes, I've been here before. \(restaurant.rating)" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }

        //cell變透明
        cell.backgroundColor = UIColor.clear

        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //啟用自適應Cell
        tableview.estimatedRowHeight = 36
        tableview.rowHeight = UITableViewAutomaticDimension

        //標題顯示餐廳名稱
        title = restaurant.name

        // Do any additional setup after loading the view.
        restaurantImageView.image = UIImage(named: restaurant.image)
        //設定表格背景色
        tableview.backgroundColor = UIColor(red: 0 / 255, green: 240 / 255, blue: 240 / 255, alpha: 0.2)
        //移除空白列的分隔線
        tableview.tableFooterView = UIView(frame: CGRect.zero)
        //變更分隔線顏色
        tableview.separatorColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 0.8)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func close(segue: UIStoryboardSegue) {

    }

    @IBAction func ratingButtionTapped(segue: UIStoryboardSegue) {
        if let rating = segue.identifier {
            restaurant.isVisited = true

            switch rating {
            case "great": restaurant.rating = "Absoultely love it! Must try."
            case "good": restaurant.rating = "Pretty good"
            case "dislike": restaurant.rating = "I don't like it."
            default:break
            }
        }
        tableview.reloadData()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
