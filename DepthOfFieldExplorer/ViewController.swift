//
//  ViewController.swift
//  DepthOfFieldExplorer
//
//  Created by Simon Gladman on 30/04/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let dofViewer = DepthOfFieldViewer()
    let distanceStepper = UIStepper()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.addSubview(dofViewer)
        view.addSubview(distanceStepper)
        
        distanceStepper.minimumValue = 20
        distanceStepper.maximumValue = 80
        distanceStepper.stepValue = 20
        distanceStepper.value = 20
        dofViewer.camera.focalDistance = 20
        
        distanceStepper.addTarget(self, action: "distanceStepperChange", forControlEvents: .ValueChanged)
    }

    func distanceStepperChange()
    {
        
        
        UIView.animateWithDuration(0.25, animations:
            {
                self.dofViewer.camera.focalDistance = CGFloat(self.distanceStepper.value)
            })
    }
    
    override func viewDidLayoutSubviews()
    {
        dofViewer.frame = CGRect(x: 20, y: 20, width: view.frame.width - 30, height: view.frame.height - 100)
        
        distanceStepper.frame = CGRect(x: 20, y: view.frame.height - 30, width: 50, height: 30)
    }
    
    override func supportedInterfaceOrientations() -> Int
    {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }


}

