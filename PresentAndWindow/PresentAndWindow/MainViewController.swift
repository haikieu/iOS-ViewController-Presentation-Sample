//
//  ViewController.swift
//  PresentAndWindow
//
//  Created by Kieu, Hai N on 4/10/17.
//  Copyright © 2017 Hai Kieu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.isPresented {
            let dismissBtn = UIBarButtonItem.init(title: "Dismiss", style: .plain, target: self, action: #selector(MainViewController.dismissVC))
            self.navigationItem.leftBarButtonItem = dismissBtn
            
            self.title = "Level #\(self.currentPresentLevel)"
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var vcSegment: UISegmentedControl!
    @IBOutlet weak var transitionStyleSegment: UISegmentedControl!
    @IBAction func transitionStyleChanged(_ sender: Any) {
        tableView.reloadData()
    }
    
    internal var isSelectedPartialCurl : Bool {
        let selectedTransion = UIModalTransitionStyle.init(rawValue: transitionStyleSegment.selectedSegmentIndex)
        return selectedTransion == .partialCurl
    }
    
    internal func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func pushViewController(_ sender: Any) {
        
        let vcType = "MainViewController"
        guard let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
            self.alert(withTitle: "Not found This Kind of \(vcType)")
            return
        }
        
        guard let navigationController = self.navigationController else {
            self.alert(withTitle: "Cannot keep pushing vc because there's no navigation vc")
            return
        }
        
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    @IBAction func presentPopover(_ sender: Any) {
        let vcType = "NavigationController"
        guard let presentedVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationController") as? UINavigationController else {
            self.alert(withTitle: "Not found This Kind of \(vcType)")
            return
        }
        
        var presentingVC : UIViewController = self
        if vcSegment.selectedSegmentIndex == 1 {
            //From root view controller
            presentingVC = (UIApplication.shared.keyWindow?.rootViewController)!
        }
        
        presentedVC.modalPresentationStyle = .popover
        
        let popOverController = presentedVC.popoverPresentationController
        popOverController?.permittedArrowDirections = .any
        popOverController?.barButtonItem = self.navigationItem.rightBarButtonItem
        
        presentingVC.present(presentedVC, animated: true) {
            //Do something
        }
    }
}


extension MainViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vcType = "RootViewController"
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationController") as? NavigationController else {
            self.alert(withTitle: "Not found This Kind of \(vcType)")
            return
        }
        
        var presentStyle = UIModalPresentationStyle.fullScreen
        if isSelectedPartialCurl == false {
            switch indexPath.row {
            case 0:
                presentStyle = UIModalPresentationStyle.fullScreen
            case 1:
                presentStyle = UIModalPresentationStyle.pageSheet
            case 2:
                presentStyle = UIModalPresentationStyle.formSheet
            case 3:
                presentStyle = UIModalPresentationStyle.currentContext
            case 4:
                presentStyle = UIModalPresentationStyle.custom
            case 5:
                presentStyle = UIModalPresentationStyle.overFullScreen
            case 6:
                presentStyle = UIModalPresentationStyle.overCurrentContext
            default:
                presentStyle = UIModalPresentationStyle.none
            }
        }

        vc.modalPresentationStyle = presentStyle
        vc.modalTransitionStyle = UIModalTransitionStyle.init(rawValue: transitionStyleSegment.selectedSegmentIndex)!
        
        if vcSegment.selectedSegmentIndex == 0 {
            //From current VC
            self.present(vc, animated: true)
        } else {
            //From root view controller
            UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true)
        }
    }
    
}

extension MainViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSelectedPartialCurl {
            return 1
        }
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var acell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if acell == nil {
            acell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        
        guard let cell = acell else {
            return UITableViewCell.init()
        }
        
        var text = UIModalPresentationStyle.fullScreen.stringValue
        switch indexPath.row {
            case 0:
                text = UIModalPresentationStyle.fullScreen.stringValue
            case 1:
                text = UIModalPresentationStyle.pageSheet.stringValue
            case 2:
                text = UIModalPresentationStyle.formSheet.stringValue
            case 3:
                text = UIModalPresentationStyle.currentContext.stringValue
            case 4:
                text = UIModalPresentationStyle.custom.stringValue
            case 5:
                text = UIModalPresentationStyle.overFullScreen.stringValue
            case 6:
                text = UIModalPresentationStyle.overCurrentContext.stringValue
            case 7:
                fallthrough
            default:
                text = "none"
        }
        cell.textLabel?.text = text
        return cell
    }
}
