//
//  SwitchingViewController.swift
//  ios-view-switcher
//
//  Created by Xiao Lu on 9/30/15.
//  Copyright © 2015 Xiao Lu. All rights reserved.
//

import UIKit

class SwitchingViewController: UIViewController {

    private var blueViewController: BlueViewController!
    private var yellowViewController: YellowViewController!
    
    @IBAction func switchViews(sender: UIBarButtonItem) {
        if yellowViewController?.view.superview == nil {
            if yellowViewController == nil {
                yellowViewController = storyboard?.instantiateViewControllerWithIdentifier("Yellow") as! YellowViewController
            }
        }
        else if blueViewController?.view.superview == nil {
            if blueViewController == nil {
                blueViewController = storyboard?.instantiateViewControllerWithIdentifier("Blue") as! BlueViewController
            }
        }
        
        if blueViewController != nil && blueViewController!.view.superview != nil {
            yellowViewController.view.frame = view.frame
            switchViewController(from: blueViewController, to: yellowViewController)
        }
        else {
            blueViewController.view.frame = view.frame
            switchViewController(from: yellowViewController, to: blueViewController)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blueViewController = storyboard?.instantiateViewControllerWithIdentifier("Blue") as! BlueViewController
        blueViewController.view.frame = view.frame
        switchViewController(from: nil, to: blueViewController)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        if blueViewController != nil && blueViewController!.view.superview == nil {
            blueViewController = nil
        }
        if yellowViewController != nil
            && yellowViewController!.view.superview == nil {
                yellowViewController = nil
        }
    }
    
    private func switchViewController(from fromVc:UIViewController?, to toVC:UIViewController?) {
        if fromVc != nil {
            fromVc!.willMoveToParentViewController(nil)
            fromVc!.view.removeFromSuperview()
            fromVc!.removeFromParentViewController()
        }
        
        if toVC != nil {
            self.addChildViewController(toVC!)
            self.view.insertSubview(toVC!.view, atIndex: 0)
            toVC!.didMoveToParentViewController(self)
        }
    }
}
