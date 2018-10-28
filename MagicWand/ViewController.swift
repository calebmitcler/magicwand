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
    
    //ui display accelerometer
    @IBOutlet weak var xPosition: UILabel!
    @IBOutlet weak var yPosition: UILabel!
    @IBOutlet weak var zPosition: UILabel!
    
    //ui display gyroscope
    @IBOutlet weak var gyroX: UILabel!
    @IBOutlet weak var gyroY: UILabel!
    @IBOutlet weak var gyroZ: UILabel!
    
    //ui display attitude rotation
    @IBOutlet weak var quaternionX: UILabel!
    @IBOutlet weak var quaternionY: UILabel!
    @IBOutlet weak var quaternionZ: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var starttime = 0.0
        var endtime = 0.0
        
        //array that a holds epoch time
        //idea is take times[times.count] - times[0] = total time the phone was accelerating
        var times: [Double] = []
        
        //array that holds all of the accelerometer values
        //going to take average of this array
        //so if the average is 1.0 and the total time
        //that has elapsed is 1.0 seconds the phone has moved 9.8 meters
        var accelerometerMeasurements: [Double] = []
        
        //accelerometer
        motionManager.accelerometerUpdateInterval = 0.01
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!){(data, error) in
            if let myData = data{
                
                //display accelermoter data in ui
                self.xPosition.text = String(myData.acceleration.x)
                self.yPosition.text = String(myData.acceleration.y)
                self.zPosition.text = String(myData.acceleration.z)
                
                //epoch time, double that represents the number of milliseconds that have
                //passed since january 1st 1970
                let timeInterval = NSDate().timeIntervalSince1970
                
                //get the absolute value of accelerometer data
                let absAccelData = abs(myData.acceleration.x)
                //start if phone is accelerating above a given threshhold, this value will probably change
                if(absAccelData > 0.04){
                    //add times to array
                    times.append(timeInterval)
                    //add accelerometer data to array
                    accelerometerMeasurements.append(myData.acceleration.x)
                    
                }else{
                    //if below the threshhold, clear the arrays
                    for i in 0...times.count{
                        //times and accelerometer data are appended
                        //at the same time
                       // times.remove(at: i)
                       // accelerometerMeasurements.remove(at: i)
                    }
                }
                
            }
            
        }
        
        
        
    
        //gyroscrope
        motionManager.gyroUpdateInterval = 0.1
        motionManager.startGyroUpdates(to: OperationQueue.current!){(data, error) in
            if let gyroData = data{
                //update gyroscope ui
                self.gyroX.text = String(gyroData.rotationRate.x)
                self.gyroY.text = String(gyroData.rotationRate.y)
                self.gyroZ.text = String(gyroData.rotationRate.z)
            }
            
        }
        
        //attitude
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!){(data, error) in
            if let positionData = data{
                //update attitude ui
                self.quaternionX.text = String(positionData.attitude.quaternion.x)
                self.quaternionY.text = String(positionData.attitude.quaternion.y)
                self.quaternionZ.text = String(positionData.attitude.quaternion.z)
                
                
            }
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


