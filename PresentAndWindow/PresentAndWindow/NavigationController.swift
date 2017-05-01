//
//  RootViewController.swift
//  PresentAndWindow
//
//  Created by Kieu, Hai N on 4/10/17.
//  Copyright © 2017 Hai Kieu. All rights reserved.
//

import Foundation
import UIKit

class NavigationController : UINavigationController {
    var floatingView : UIView = UIView.init(frame: CGRect.init(x: 20, y: 450, width: 200, height: 150))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        floatingView.backgroundColor = UIColor.blue.withAlphaComponent(0.7)
        floatingView.isUserInteractionEnabled = false
        
        let label = UILabel.init()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Floating view on root VC"
        label.textColor = .red
        floatingView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label(30)]-|", options: [], metrics: nil, views: ["label":label])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label]-|", options: [], metrics: nil, views: ["label":label])
        NSLayoutConstraint.activate(constraints)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isPresented == false {
            //In root view controller of window, viewDidAppear usually gets called twice initially
            UIApplication.shared.keyWindow?.insertSubview(floatingView, aboveSubview: (UIApplication.shared.keyWindow?.subviews.last!)!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
