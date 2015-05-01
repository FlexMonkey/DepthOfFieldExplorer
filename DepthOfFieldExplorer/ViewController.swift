//
//  ViewController.swift
//  DepthOfFieldExplorer
//
//  Created by Simon Gladman on 30/04/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    let dofViewer = DepthOfFieldViewer()
    
    let distanceWidget = UISegmentedControl(items: ["20", "40", "60", "80"])
    let focalSizeWidget = UISegmentedControl(items: ["0", "1", "2", "4", "8"])
    let focalBlurWidget = UISegmentedControl(items: ["1", "2", "4", "8"])
    let apatureWidget = UISegmentedControl(items: ["1/2", "1/4", "1/8", "1/16"])
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.addSubview(dofViewer)
        view.addSubview(distanceWidget)
        view.addSubview(focalSizeWidget)
        view.addSubview(focalBlurWidget)
        view.addSubview(apatureWidget)

        apatureWidget.selectedSegmentIndex = 2
        apatureWidget.addTarget(self, action: "apatureChange", forControlEvents: .ValueChanged)
        
        focalBlurWidget.selectedSegmentIndex = 0
        focalBlurWidget.addTarget(self, action: "focalBlurSliderChange", forControlEvents: .ValueChanged)
        
        focalSizeWidget.selectedSegmentIndex = 0
        focalSizeWidget.addTarget(self, action: "focalSizeSliderChange", forControlEvents: .ValueChanged)
        
        distanceWidget.selectedSegmentIndex = 0
        distanceWidget.addTarget(self, action: "distanceStepperChange", forControlEvents: .ValueChanged)
    }

    func apatureChange()
    {
        let apatures: [CGFloat] = [1 / 2, 1 / 4, 1 / 8, 1 / 16]
        
        SCNTransaction.setAnimationDuration(1.0)
        SCNTransaction.begin()
        dofViewer.camera.aperture = apatures[apatureWidget.selectedSegmentIndex]
        SCNTransaction.commit()
    }
    
    func focalSizeSliderChange()
    {
        SCNTransaction.setAnimationDuration(1.0)
        SCNTransaction.begin()
        dofViewer.camera.focalSize = CGFloat([0, 1, 2, 4, 8][focalSizeWidget.selectedSegmentIndex])
        SCNTransaction.commit()
    }
    
    func focalBlurSliderChange()
    {
        SCNTransaction.setAnimationDuration(1.0)
        SCNTransaction.begin()
        dofViewer.camera.focalBlurRadius = CGFloat([1, 2, 4, 8][focalBlurWidget.selectedSegmentIndex])
        SCNTransaction.commit()
    }
    
    func distanceStepperChange()
    {
        let newFocalDistance = CGFloat([20, 40, 60, 80][distanceWidget.selectedSegmentIndex])
        
        SCNTransaction.setAnimationDuration(1.0)
        SCNTransaction.begin()
        dofViewer.camera.focalDistance = newFocalDistance
        SCNTransaction.commit()
        
/*
        if newFocalDistance != dofViewer.camera.focalDistance
        {
            let anim = CABasicAnimation(keyPath: "focalDistance")
            anim.autoreverses = false
            anim.removedOnCompletion = false
            anim.fromValue = dofViewer.camera.focalDistance
            dofViewer.camera.focalDistance = newFocalDistance
            anim.duration = 0.5
            anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            self.dofViewer.camera.addAnimation(anim, forKey: "focalDistance")
        }
*/
    }
    
    override func viewDidLayoutSubviews()
    {
        dofViewer.frame = CGRect(x: 20, y: 20, width: view.frame.width - 30, height: view.frame.height - 100)
        
        let qtrWidth = (view.frame.width - 40) / 4
        
        distanceWidget.frame = CGRect(x: 20, y: view.frame.height - 50, width: qtrWidth, height: 30).rectByInsetting(dx: 5, dy: 0)
        
        focalSizeWidget.frame = CGRect(x: 20 + qtrWidth, y: view.frame.height - 50, width: qtrWidth, height: 30).rectByInsetting(dx: 5, dy: 0)
        
        focalBlurWidget.frame = CGRect(x: 20 + qtrWidth * 2, y: view.frame.height - 50, width: qtrWidth, height: 30).rectByInsetting(dx: 5, dy: 0)
        
        apatureWidget.frame = CGRect(x: 20 + qtrWidth * 3, y: view.frame.height - 50, width: qtrWidth, height: 30).rectByInsetting(dx: 5, dy: 0)
    }
    
    override func supportedInterfaceOrientations() -> Int
    {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }


}

