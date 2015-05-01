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
    
    let distanceWidget = LabelledSegmentedControl(items: ["20", "40", "60", "80"], label: "Distance")
    let focalSizeWidget = LabelledSegmentedControl(items: ["0", "1", "2", "4", "8"], label: "Focal Size")
    let focalBlurWidget = LabelledSegmentedControl(items: ["1", "2", "4", "8", "16"], label: "Focal Blur Radius")
    let apertureWidget = LabelledSegmentedControl(items: ["1/2", "1/4", "1/8", "1/16"], label: "Aperture")
    
    let fogStartWidget = LabelledSegmentedControl(items: ["0", "20", "40", "60", "80"], label: "Fog Start")
    let fogEndWidget = LabelledSegmentedControl(items: ["0", "20", "40", "60", "80"], label: "Fog End")
    let fogDensityExponentWidget = LabelledSegmentedControl(items: ["0", "1", "2"], label: "Fog Density Exponent")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.addSubview(dofViewer)
        
        initialiseWidget(apertureWidget, selectedIndex: 2)
        initialiseWidget(focalBlurWidget, selectedIndex: 3)
        initialiseWidget(focalSizeWidget, selectedIndex: 2)
        initialiseWidget(distanceWidget, selectedIndex: 2)
        initialiseWidget(fogStartWidget, selectedIndex: 0)
        initialiseWidget(fogEndWidget, selectedIndex: 0)
        initialiseWidget(fogDensityExponentWidget, selectedIndex: 1)
        
        cameraPropertiesChange()
    }
    
    func initialiseWidget(widget: LabelledSegmentedControl, selectedIndex: Int)
    {
        view.addSubview(widget)
        
        widget.selectedSegmentIndex = selectedIndex
        widget.addTarget(self, action: "cameraPropertiesChange", forControlEvents: .ValueChanged)
    }

    func cameraPropertiesChange()
    {
        let apertures: [CGFloat] = [1 / 2, 1 / 4, 1 / 8, 1 / 16]
        let fogDistances: [CGFloat] = [0, 20, 40, 60, 80]
        
        SCNTransaction.setAnimationDuration(1.0)
        SCNTransaction.begin()
            dofViewer.camera.aperture = apertures[apertureWidget.selectedSegmentIndex]
            dofViewer.camera.focalSize = CGFloat([0, 1, 2, 4, 8][focalSizeWidget.selectedSegmentIndex])
            dofViewer.camera.focalBlurRadius = CGFloat([1, 2, 4, 8, 16][focalBlurWidget.selectedSegmentIndex])
            dofViewer.camera.focalDistance = CGFloat([20, 40, 60, 80][distanceWidget.selectedSegmentIndex])
        
            dofViewer.scene?.fogStartDistance = fogDistances[fogStartWidget.selectedSegmentIndex]
            dofViewer.scene?.fogEndDistance = fogDistances[fogEndWidget.selectedSegmentIndex]
            dofViewer.scene?.fogDensityExponent = CGFloat([0, 1, 2][fogDensityExponentWidget.selectedSegmentIndex])
        SCNTransaction.commit()
    }
    
    override func viewDidLayoutSubviews()
    {
        dofViewer.frame = CGRect(x: 20, y: 20, width: view.frame.width - 30, height: view.frame.height - 140)
        
        let qtrWidth = (view.frame.width - 40) / 4
        
        distanceWidget.frame = CGRect(x: 20, y: view.frame.height - 120, width: qtrWidth, height: 50).rectByInsetting(dx: 5, dy: 0)
        focalSizeWidget.frame = CGRect(x: 20 + qtrWidth, y: view.frame.height - 120, width: qtrWidth, height: 50).rectByInsetting(dx: 5, dy: 0)
        focalBlurWidget.frame = CGRect(x: 20 + qtrWidth * 2, y: view.frame.height - 120, width: qtrWidth, height: 50).rectByInsetting(dx: 5, dy: 0)
        apertureWidget.frame = CGRect(x: 20 + qtrWidth * 3, y: view.frame.height - 120, width: qtrWidth, height: 50).rectByInsetting(dx: 5, dy: 0)
        
        fogStartWidget.frame = CGRect(x: 20, y: view.frame.height - 60, width: qtrWidth, height: 50).rectByInsetting(dx: 5, dy: 0)
        fogEndWidget.frame = CGRect(x: 20 + qtrWidth, y: view.frame.height - 60, width: qtrWidth, height: 50).rectByInsetting(dx: 5, dy: 0)
        fogDensityExponentWidget.frame = CGRect(x: 20 + qtrWidth * 2, y: view.frame.height - 60, width: qtrWidth, height: 50).rectByInsetting(dx: 5, dy: 0)
    }
    
    override func supportedInterfaceOrientations() -> Int
    {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }


}

