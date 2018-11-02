//
//  ViewController.swift
//  SwiftMaster
//
//  Created by Caleb Mitcler on 10/24/18.
//  Copyright © 2018 Caleb Mitcler. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var motionManager = CMMotionManager()
    
    var btl:BlueToothLights!
    
    
    var currentNumber = 0 //represents the number of lights on the led strip should be on
    var average = 0.0 //average measures array defined below, represents average velocity
    var times: [Double] = []//record epoch times velocity != 0
    var measures: [Int] = []//measured values
    var sum = 0.0//sum array to find average
    
    //ui display accelerometer
    @IBOutlet weak var xPosition: UILabel!
    @IBOutlet weak var yPosition: UILabel!
    @IBOutlet weak var zPosition: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //uncomment to connect to bluetooth led strip
        // btl = BlueToothLights()
        //  btl.connect()
        
        
        //testing button function
       // abra((Any).self)
        
    }
   

    
    
    @IBAction func abra(_ sender: Any) {
        
        var accelerometerMeasurements: [Double] = []
        
        //accelerometer
        motionManager.accelerometerUpdateInterval = 0.01
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!){(data, error) in
            if let myData = data{
                
                //display accelermoter data in ui
                let xMove = myData.acceleration.x
                self.xPosition.text = String(xMove)
                self.yPosition.text = String(myData.acceleration.y)
                self.zPosition.text = String(myData.acceleration.z)
                
                

                let timeInterval = NSDate().timeIntervalSince1970
                
                //let absXMoveScaled = Int(xMove*100)
                
                //testing position accuracy
                //average velocity/(startTime-endTime) should give distance
                if(xMove>0){
                print(xMove)
                print("time:",timeInterval)
                }
                
                
                

            }//end if
            
        }//end update
        
    }//end function
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


