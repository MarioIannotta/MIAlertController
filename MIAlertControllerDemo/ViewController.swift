//
//  ViewController.swift
//  MIAlertControllerDemo
//
//  Created by Mario on 11/07/16.
//  Copyright © 2016 Mario Iannotta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var customAlertControllerConfig: MIAlertController.Config!
    var googlishAlertControllerConfig: MIAlertController.Config!
    var googlishAlertControllerLeftButtonConfig: MIAlertController.Button.Config!
    var googlishAlertControllerRightButtonConfig: MIAlertController.Button.Config!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadConfigs()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private
    private func loadConfigs() {
        
        // Googlish alert
        googlishAlertControllerConfig = MIAlertController.Config()
        
        googlishAlertControllerConfig.firstButtonRatio = 0.8
        googlishAlertControllerConfig.alertViewCornerRadius = 1
        googlishAlertControllerConfig.messageLabelTextColor = UIColor(white: 0.45, alpha: 1)
        
        googlishAlertControllerConfig.messageVerticalSpaceFromTitle = 25
        googlishAlertControllerConfig.messageLabelFont = UIFont.systemFontOfSize(17)
        
        googlishAlertControllerConfig.alertMarginSize = CGSize(width: 10, height: 10)
        googlishAlertControllerConfig.alertViewMaxSize = CGSize(width: UIScreen.mainScreen().bounds.size.width - 80, height: 340)
        
        googlishAlertControllerConfig.titleLabelTextAlignment = NSTextAlignment.Left
        googlishAlertControllerConfig.messageLabelTextAlignment = NSTextAlignment.Left
        
        // Googlish alert actions
        googlishAlertControllerLeftButtonConfig = MIAlertController.Button.Config()
        
        googlishAlertControllerLeftButtonConfig.textColor = UIColor(red: 19/255.0, green: 152/255.0, blue: 138/255.0, alpha: 1)
        googlishAlertControllerLeftButtonConfig.textAlignment = .Right
        googlishAlertControllerLeftButtonConfig.font = UIFont.boldSystemFontOfSize(15)
        
        googlishAlertControllerRightButtonConfig = MIAlertController.Button.Config()
        
        googlishAlertControllerRightButtonConfig.textColor = UIColor(red: 19/255.0, green: 152/255.0, blue: 138/255.0, alpha: 1)
        googlishAlertControllerRightButtonConfig.font = UIFont.boldSystemFontOfSize(15)
        
        // Custom alert
        customAlertControllerConfig = MIAlertController.Config()
        
        customAlertControllerConfig.alertViewCornerRadius = 4
        
        customAlertControllerConfig.titleLabelFont = UIFont.boldSystemFontOfSize(18)
        customAlertControllerConfig.titleLabelTextAlignment = NSTextAlignment.Left
        
        customAlertControllerConfig.messageLabelTextColor = UIColor(white: 0.3, alpha: 1)
        customAlertControllerConfig.messageLabelTextAlignment = NSTextAlignment.Left
        
        customAlertControllerConfig.buttonBackgroundView = UIColor(white: 0.98, alpha: 1)
        
        customAlertControllerConfig.separatorColor = UIColor(white: 0.9, alpha: 1)
        customAlertControllerConfig.alertViewMaxSize = CGSize(width: 300, height: 500)
        
    }
    
    // Mark: - IBActions
    @IBAction func showDefaultAlertController(sender: AnyObject) {
        
        MIAlertController(
            
            title: "I'm a default alert, am I cute?",
            message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris",
            buttons: [
                MIAlertController.Button(title: "Yep"),
                MIAlertController.Button(title: "Nope", type: .Destructive)
            ]
            
            ).presentOn(self, buttonTapped: { (buttonIndex) in
                
                print("button \(buttonIndex) tapped")
                
            })
        
    }
    @IBAction func showCustomAlertController(sender: AnyObject) {
        
        MIAlertController(
            
            title: "Custom alert with a very looooooong title",
            message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris",
            buttons: [
                MIAlertController.Button(title: "Option 1"),
                MIAlertController.Button(title: "Option 2"),
                MIAlertController.Button(title: "Option 3")
            ],
            config: customAlertControllerConfig
            
            ).presentOn(self, buttonTapped: { (buttonIndex) in
                
                print("button \(buttonIndex) tapped")
                
            })
        
    }
    @IBAction func showGooglishAlertController(sender: AnyObject) {
        
        MIAlertController(
            
            title: "I'm a googlish alert!",
            message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris",
            buttons: [
                MIAlertController.Button(title: "COOL", config: googlishAlertControllerLeftButtonConfig),
                MIAlertController.Button(title: "OK", config: googlishAlertControllerRightButtonConfig)
            ],
            config: googlishAlertControllerConfig
            
            ).presentOn(self, buttonTapped: { (buttonIndex) in
                
                print("button \(buttonIndex) tapped")
                
            })
        
    }

}

