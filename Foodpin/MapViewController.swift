//
//  MapViewController.swift
//  Foodpin
//
//  Created by Apple on 2018/3/27.
//  Copyright © 2018年 Gamma. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var restaurant: Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        //指南針
        mapView.showsCompass = true
        //比例尺
        mapView.showsScale = true
        //交通流量
        mapView.showsTraffic = true


        //將地址轉換為座標後並標註在地圖上
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: {
            placemarks, error in
            if error != nil {
                print("err: ")
                print(error)
                return
            }

            if let placemarks = placemarks {
                //取得第一個標註
                let placemark = placemarks[0]
                //加上標註
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type

                if let location = placemark.location {
                    annotation.coordinate = location.coordinate

                    //顯示標註
                    self.mapView.showAnnotations([annotation], animated: true)
                    //標註泡泡
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"

        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }

        //如果可以的話重複使用此標註
        var annotationView: MKPinAnnotationView? =
                mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

        //改變大頭針顏色
        annotationView?.pinTintColor = UIColor.orange

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }

        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = UIImage(named: restaurant.image)
        annotationView?.leftCalloutAccessoryView = leftIconView

        return annotationView
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
