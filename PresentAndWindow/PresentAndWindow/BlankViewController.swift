//
//  PresentViewController.swift
//  PresentAndWindow
//
//  Created by Kieu, Hai N on 4/10/17.
//  Copyright © 2017 Hai Kieu. All rights reserved.
//

import Foundation
import UIKit

class BlankViewController : UIViewController {
    
    @IBOutlet weak var mainText: UILabel!
    @IBAction func tapOnDismiss(_ sender: Any) {
        self.dismiss(animated: true) { 
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.isPresented {
            self.mainText.text = "\(self.modalPresentationStyle.stringValue) Level #\(self.currentPresentLevel)"
        }
    }
}
