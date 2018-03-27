//
//  ReviewViewController.swift
//  Foodpin
//
//  Created by Apple on 2018/3/27.
//  Copyright © 2018年 Gamma. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet var backgroundImageView:UIImageView!
    @IBOutlet var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.transform = CGAffineTransform.init(scaleX: 0,y: 0)

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 3, animations: {
            self.containerView.transform = CGAffineTransform.identity
        })
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
