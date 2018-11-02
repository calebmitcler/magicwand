 //
 //  BluetoothLights.swift
 //  SwiftHSVColorPickerExample
 //
 //  Created by Caleb Mitcler on 10/16/18.
 //  Copyright © 2018 kspri. All rights reserved.
 //
 
 import Foundation
 
 import CoreBluetooth
 import UIKit
 
 import CoreMotion
 
 class BlueToothLights: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate{
    
    
    
    var lightsPeripheral: CBPeripheral?
    var centralManager: CBCentralManager?
    
    var globalCharacteristic: [CBCharacteristic]?
    
    let motionManager = CMMotionManager()

    
    
    func updateColor( numLights: Int){
        
        for charactericsx in globalCharacteristic!
        {
            
            if charactericsx.uuid.uuidString == "FFE1"{
                let allData: NSData = "<\(numLights)>".data(using: String.Encoding.utf8)! as NSData
                lightsPeripheral?.writeValue(allData as Data, for: charactericsx, type: .withoutResponse)
                print(allData.bytes)
                
            }
        }
        
    }
    
    
    func connect(){
        let centralQueue: DispatchQueue = DispatchQueue(label: "ledStrip", attributes: .concurrent)
        
        centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        var name = peripheral.name;
        
        
        
            
            if(name! == "SH-HC-08"){
                print(name!)
                decodePeripheralState(peripheralState: peripheral.state)
                
                print("found the lights")
                
                lightsPeripheral = peripheral

                print(lightsPeripheral!.identifier.uuidString)
                centralManager?.stopScan()
                
                centralManager?.connect(lightsPeripheral!)
                
                var cbuuid: [CBUUID] = []
                cbuuid.append(CBUUID(string:"289D8C80-FBFD-F688-6DB7-EC7688C56EC5"))
                
            }
            
        
    }
    
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        let lightcbuuid = CBUUID(string:(peripheral.identifier.uuidString))
        print(lightcbuuid)
        
        
        peripheral.delegate = self
        decodePeripheralState(peripheralState: peripheral.state)
        
        print(peripheral)
        
    
        peripheral.discoverServices(nil)
        print(peripheral.services)
        
        
    }//central mnger didConnect
    
    
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print(peripheral.canSendWriteWithoutResponse)
        
        print("diddiscoverservices")
        
        for service in peripheral.services! {
            print(service)
            peripheral.discoverCharacteristics(nil, for: service)
            
            
        }
        print(error)
        
    } // END func peripheral(... didDiscoverServices
    
    
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("characteristic")
        
        
        if let charactericsArr = service.characteristics  as? [CBCharacteristic]
        {
            
            globalCharacteristic   = service.characteristics  as? [CBCharacteristic]
            
            lightsPeripheral = peripheral
            
            
            for charactericsx in charactericsArr
            {
                
                print(charactericsx)
                print(charactericsx.uuid.uuidString)
                
                
                
            }
            
            
            
            
        }
        
        
    }
    
    func peripheral(peripheral: CBPeripheral,
                    didWriteValueForCharacteristic characteristic: CBCharacteristic,
                    error: NSError?)
    {
        if let error = error {
            print("error")
            return
        }
        
        print("succeed")
    }
    
    
    
    
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        switch central.state {
            
        case .unknown:
            print("Bluetooth status is UNKNOWN")
            
        case .resetting:
            print("Bluetooth status is RESETTING")
            
        case .unsupported:
            print("Bluetooth status is UNSUPPORTED")
            
        case .unauthorized:
            print("Bluetooth status is UNAUTHORIZED")
            
        case .poweredOff:
            print("Bluetooth status is POWERED OFF")
            
        case .poweredOn:
            print("Bluetooth status is POWERED ON")
            
            DispatchQueue.main.async { () -> Void in
                //indicators ui of connection
            }
            
            let options: [String: Any] = [CBCentralManagerScanOptionAllowDuplicatesKey:
                NSNumber(value: false)]
            
            centralManager?.scanForPeripherals(withServices: nil, options: options)
            
            
        } // END switch
        
    } // END func centralManagerDidUpdateState
    
    
    
    
    func decodePeripheralState(peripheralState: CBPeripheralState) {
        
        switch peripheralState {
        case .disconnected:
            print("Peripheral state: disconnected")
        case .connected:
            print("Peripheral state: connected")
        case .connecting:
            print("Peripheral state: connecting")
        case .disconnecting:
            print("Peripheral state: disconnecting")
        }
        
    } // END func decodePeripheralState(peripheralState
    
    
    
 }
 

