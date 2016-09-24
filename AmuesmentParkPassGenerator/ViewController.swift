//
//  ViewController.swift
//  AmuesmentParkPassGenerator
//
//  Created by Safwat Shenouda on 22/09/16.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import UIKit
import AVFoundation

// Make sounds global vars
var dingSound: SystemSoundID = 0     // Access granted sound
var buzzSound: SystemSoundID = 1     // Access Denied  sound

class ViewController: UIViewController {
    
    
    let p = ParkSystem()                // create Park Conrol System instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSounds ()
        
        plugData() // Initlize and test data
        
    }
    
    
    func loadSounds() {
        var pathToSoundFile = NSBundle.mainBundle().pathForResource("ding", ofType: "wav")
        var soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &dingSound)
        
        pathToSoundFile = NSBundle.mainBundle().pathForResource("buzz", ofType: "wav")
        soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &buzzSound)
        
        
        
    }

    func playSound(sound:SystemSoundID) {
        AudioServicesPlaySystemSound(sound)
        
    }
    
    // Intializer to plug values
    //
    func plugData(){
        
        // Helper function to create date
        func createDateFromString(dateString: String) -> NSDate {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let date: NSDate = dateFormatter.dateFromString(dateString)!
            return date
        }
        
        // Hepler function to show result of access test for an entrant to all avilable gates
        func testAccess (entrant: Entrant, info: Info)
        {
            // For testing plugged data values
            // Define test turnstile gates, restricted doors and cash registers
            // Rides gates
            let thunderMountainRailRoadGate = RideAccessPoint(accessToCheck: RideAccessType.AllRides, locationName: "Thunder Mountain Rail Ride")
            let fastTrackDumboFlyingElephantGate = RideAccessPoint(accessToCheck: RideAccessType.SkipAllRidesLines, locationName: "Dumbo Ride Fast Track Gate")
            // Access doors
            let adminOfficeDoor = AreaAccessPoint(accessToCheck: AreaAccessType.OfficeAreas, locationName: "Admin Offices")
            let mainControlRoomDoor = AreaAccessPoint(accessToCheck: AreaAccessType.RideControlAreas, locationName: "Main Control Room")
            let staffKitchenDoor = AreaAccessPoint(accessToCheck: AreaAccessType.KitchenAreas,locationName: "Staff Kitchen Entrance" )
            // Cash registers
            let kfcRegister = FoodDiscountSwiper(locationName: "Cash Register KFC")
            let piratesStoreRegister = MerchandiseDiscountSwiper(locationName: "Cash Register Pirates Store")
            
            // Validate data and show if there are errors
            print ("\nValidating data .. entrant type: \(entrant)")
            let errors = p.validateRequiredInfo(entrant, info: info)
            for err in errors { print("Error found: \(err)") }
            
            // create pass and test it on all gates and registers
            if let pass = p.createPass(entrant, addionalInfo: info)
            {
                print("Pass is created .. for entrant type: \(entrant)")
                print("Trying to access:\(thunderMountainRailRoadGate.locationName) <--> Message \(thunderMountainRailRoadGate.swipe(pass))")
                print("Trying to access:\(mainControlRoomDoor.locationName) <--> Message \(mainControlRoomDoor.swipe(pass))")
                print("Trying to access:\(kfcRegister.locationName) <--> Message \(kfcRegister.swipe(pass))")
                print("Trying to access:\(fastTrackDumboFlyingElephantGate.locationName) <--> Message \(fastTrackDumboFlyingElephantGate.swipe(pass))")
                print("Trying to access:\(piratesStoreRegister.locationName) <--> Message \(piratesStoreRegister.swipe(pass))")
                print("Trying to access:\(adminOfficeDoor.locationName) <--> Message \(adminOfficeDoor.swipe(pass))")
                print("Trying to access:\(staffKitchenDoor.locationName) <--> Message \(staffKitchenDoor.swipe(pass))")
            }
            else {
                print("Pass is not created")
            }
            
        }
        
// MARK : Use Cases
// For Reviewer to uncomment use cases. Provided use cases cover all types of enrants and all business rules
// Any use case will be tested against ALL swipers types defined in test access function, so it will show all possible resutls

        
//        // Use Cases
//        // Enterant type: Classic Guest
//        let entrant1 = Guest.ClassicGuest
//        let info1 = Info(birthDate: nil, firstName: "Safwat", lastName: "Shenouda", streetAddress: "some street", city: "Amsterdam", state: "NY", zipCode: "1235GB")
//        testAccess(entrant1, info: info1)
//        
//        // Enterant type: VIP Guest
//        let entrant2 = Guest.VIPGuest
//        let birthDate = createDateFromString("09-24-2016")
//        let info2 = Info(birthDate: birthDate, firstName: "Safwat", lastName: "Shenouda", streetAddress: "some street", city: "Amsterdam", state: "NY", zipCode: "1235GB")
//        testAccess(entrant2, info: info2)
//        
//        // Enterant type: Free Child Guest
//        let entrant3 = Guest.FreeChildGuest
//        let birthDate3 = createDateFromString("09-24-2012")
//        let info3 = Info(birthDate: birthDate3, firstName: "Mark", lastName: nil, streetAddress: nil, city: nil, state: nil, zipCode: nil)
//        testAccess(entrant3, info: info3)
//        
//        // Enterant type: Manager
//        let entrant4 = Employee.Manager
//        let birthDate4 = createDateFromString("09-24-1980")
//        let info4 = Info(birthDate: birthDate4, firstName: "Mark", lastName: "Safwat", streetAddress: "Some street", city: "Amsterdam", state: "NH", zipCode: "1234GB")
//        testAccess(entrant4, info: info4)
//        
//        // Enterant type: Manager -- with missing data
//        let entrant5 = Employee.Manager
//        let birthDate5 = createDateFromString("09-24-1980")
//        let info5 = Info(birthDate: birthDate5, firstName: "Mark", lastName: nil, streetAddress: nil, city: "Amsterdam", state: "NH", zipCode: nil)
//        testAccess(entrant5, info: info5)
//        
//        // Enterant type: Hourly Employee Maintenance
//        let entrant6 = Employee.HourlyEmployeeMaintenance
//        let info6 = Info(birthDate: nil, firstName: "Mark", lastName: "Safwat", streetAddress: "Some street", city: "Amsterdam", state: "NH", zipCode: "1234GB")
//        testAccess(entrant6, info: info6)
//        
//        // Enterant type: Hourly Employee Food Services
//        let entrant7 = Employee.HourlyEmployeeFoodServices
//        let birthDate7 = createDateFromString("09-24-1980")
//        let info7 = Info(birthDate: birthDate7, firstName: "Mark", lastName: "Safwat", streetAddress: "Some street", city: "Amsterdam", state: "NH", zipCode: "1234GB")
//        testAccess(entrant7, info: info7)
//        
        // Enterant type: Hourly Employee Ride Services
        let entrant8 = Employee.HourlyEmployeeRideServices
        let info8 = Info(birthDate: nil, firstName: "Mark", lastName: "Safwat", streetAddress: "Some street", city: "Amsterdam", state: "NH", zipCode: "1234GB")
        testAccess(entrant8, info: info8)
//
//        // Enterant type: Child, with missing birth date
//        let entrant9 = Guest.FreeChildGuest
//        let info9 = Info(birthDate: nil, firstName: "Mark", lastName: "Safwat", streetAddress: "Some street", city: "Amsterdam", state: "NH", zipCode: "1234GB")
//        testAccess(entrant9, info: info9)
        
        
        
    }

}

