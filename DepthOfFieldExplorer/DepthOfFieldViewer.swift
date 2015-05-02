//
//  DepthOfFieldViewer.swift
//  DepthOfFieldExplorer
//
//  Created by Simon Gladman on 30/04/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import SceneKit

class DepthOfFieldViewer: SCNView
{
    let camera = SCNCamera()
    
    override func didMoveToSuperview()
    {
        antialiasingMode = SCNAntialiasingMode.Multisampling4X
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1.0)
        layer.borderColor = UIColor.darkGrayColor().CGColor
        layer.borderWidth = 1
        
        let torus = SCNTorus(ringRadius: 8, pipeRadius: 2)
        torus.ringSegmentCount = 64
        
        var material: SCNMaterial = SCNMaterial()
        material.diffuse.contents = UIImage(named: "checkerboard.jpg")
        
        var floorMaterial: SCNMaterial = SCNMaterial()
        floorMaterial.diffuse.contents = UIImage(named: "grid.jpg")
        floorMaterial.diffuse.wrapS = SCNWrapMode.Repeat
        floorMaterial.diffuse.wrapT = SCNWrapMode.Repeat
        
        let thisScene = SCNScene()
        
        scene = thisScene
        
        // camera...
        
        camera.xFov = 60
        camera.yFov = 60
        
        let cameraNode = SCNNode()
        
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)
        
        thisScene.rootNode.addChildNode(cameraNode)
        
        // torus...
        
        let torusNode = SCNNode(geometry: torus)
        torusNode.position = SCNVector3(x: 0, y: 0, z: -20)
        torusNode.rotation = SCNVector4(x: Float(0.0), y: Float(1.0), z: Float(1.0), w: Float(M_PI))
        thisScene.rootNode.addChildNode(torusNode)
        
        let torusNode2 = SCNNode(geometry: torus)
        torusNode2.position = SCNVector3(x: 10, y: 0, z: -40)
        torusNode2.rotation = SCNVector4(x: Float(0.0), y: Float(1.0), z: Float(1.0), w: Float(M_PI))
        thisScene.rootNode.addChildNode(torusNode2)
        
        let torusNode3 = SCNNode(geometry: torus)
        torusNode3.position = SCNVector3(x: -10, y: 0, z: -60)
        torusNode3.rotation = SCNVector4(x: Float(0.0), y: Float(1.0), z: Float(1.0), w: Float(M_PI))
        thisScene.rootNode.addChildNode(torusNode3)

        let torusNode4 = SCNNode(geometry: torus)
        torusNode4.position = SCNVector3(x: 0, y: 0, z: -80)
        torusNode4.rotation = SCNVector4(x: Float(0.0), y: Float(1.0), z: Float(1.0), w: Float(M_PI))
        thisScene.rootNode.addChildNode(torusNode4)
        
        torus.materials = [material]
        
        // ambient light...
        
        let ambientLight = SCNLight()
        ambientLight.type = SCNLightTypeAmbient
        ambientLight.color = UIColor(white: 0.15, alpha: 1.0)
        let ambientLightNode = SCNNode()
        ambientLightNode.light = ambientLight
        
        thisScene.rootNode.addChildNode(ambientLightNode)
        
        // omni light...
        
        let omniLight = SCNLight()
        omniLight.type = SCNLightTypeOmni
        omniLight.color = UIColor(white: 1.0, alpha: 1.0)
        let omniLightNode = SCNNode()
        omniLightNode.light = omniLight
        omniLightNode.position = SCNVector3(x: -5, y: 8, z: 20)
        
        thisScene.rootNode.addChildNode(omniLightNode)
        
        // floor...
        
        let floor = SCNFloor()
        let floorNode = SCNNode(geometry: floor)
        floorNode.position = SCNVector3(x: 0, y: -10, z: -50)
        floor.materials = [floorMaterial]
        
        thisScene.rootNode.addChildNode(floorNode)
    }
}
