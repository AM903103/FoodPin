//
//  RestaurantDetailViewController.swift
//  Foodpin
//
//  Created by Apple on 2018/3/26.
//  Copyright © 2018年 Gamma. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var restaurant: Restaurant!

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var mapView: MKMapView!

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

    @objc func showMap() {
        performSegue(withIdentifier: "showMap", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()



        //偵測手適時要呼叫showMap
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMap))
        mapView.addGestureRecognizer(tapGestureRecognizer)

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
        //tableview.tableFooterView = UIView(frame: CGRect.zero)
        //變更分隔線顏色
        tableview.separatorColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 0.8)


        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: {
            placemarks, error in
            if error != nil {
                print("err: ")
                print(error)
                return
            }

            if let placemarks = placemarks {
                let placemark = placemarks[0]
                let annotation = MKPointAnnotation()
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250,250)
                    self.mapView.setRegion(region, animated: false)
                }

            }
        })
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showReview") {
            let destinationController = segue.destination as! ReviewViewController
            destinationController.restaurant = restaurant
        }
    }
}
