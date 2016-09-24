//
//  ParkSystem.swift
//  AmuesmentParkPassGenerator
//
//  Created by Safwat Shenouda on 24/09/16.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import Foundation


struct ParkSystem: ParkControlSystem {
    var freeChildGuestAgeLimit : Double  = 5.0 //childeren under 5 admit for free
}

protocol ParkControlSystem {
    var freeChildGuestAgeLimit : Double {get }
    func showRequiredInfo(entrantType: Entrant) -> [RequiredInfo]
    func validateRequiredInfo (entrantType: Entrant, info:Info) -> [Error]
    func createPass(entrantType: Entrant, addionalInfo:Info) -> Pass?
    func plugData()
    
    
}
extension ParkControlSystem  {
    

    func showRequiredInfo(entrantType: Entrant) -> [RequiredInfo]{
        // show required info list
        for r in entrantType.requiredInfo { print("Required Info: \(r)") }
        return entrantType.requiredInfo
    }
    
    func validateRequiredInfo (entrantType: Entrant, info:Info) -> [Error] {
        
        let requiredInfo = entrantType.requiredInfo
        var errors = [Error]()
        
        if requiredInfo.contains(.BirthDate) && info.birthDate == nil { errors.append(.BirthDateMissing)}
        if requiredInfo.contains(.FirstName) && info.firstName == nil {errors.append(.FirstNameMissing)}
        if requiredInfo.contains(.LastName) && info.lastName == nil {errors.append(.LastNameMissing)}
        if requiredInfo.contains(.StreetAddress) && info.streetAddress == nil {errors.append(.StreetAddressMissing)}
        if requiredInfo.contains(.City) && info.city == nil {errors.append(.CityMissing)}
        if requiredInfo.contains(.State) && info.state == nil {errors.append(.StateMissing)}
        if requiredInfo.contains(.ZipCode) && info.zipCode == nil {errors.append(.ZipCodeMissing)}
        
        // check birthdate for guest child
        if let guestType = entrantType as? Guest {
            if (guestType == .FreeChildGuest) {
                if let birthDate = info.birthDate {
                    // check age <= 5 years else add error age above limit
                    if !checkChildAgeInLimit(birthDate) {errors.append(Error.FreeChildGuestAgeAboveLimit) }
                    
                }
            }
        }
        
        // show errors
        for e in errors { print("Error found: \(e)") }
        return errors
    }
    
    
    
    func createPass(entrantType: Entrant, addionalInfo:Info) -> Pass? {
        
        let validateInfoResult = validateRequiredInfo(entrantType, info: addionalInfo)
        guard validateInfoResult.count == 0  else {
            return nil
        }
        
        return Pass(entrantType: entrantType, passAccess: entrantType.passAccess, addionalInfo: addionalInfo)
    }
    
    // Helper function
    //
    func checkChildAgeInLimit(birthDate: NSDate) -> Bool {
        
        //let cal = NSCalendar.currentCalendar()
        let age = NSDate().timeIntervalSinceDate(birthDate)
        let ageInYears = age/(365*24*60*60)
        print ("Age: \(ageInYears) ")
        if ageInYears <= freeChildGuestAgeLimit { return true } else { return false }
        
    }
    
    // Intializer to plug values 
    //
    func plugData(){
        
        func createDateFromString(dateString: String) -> NSDate {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let date: NSDate = dateFormatter.dateFromString(dateString)!
            return date
        }
        func testAccess (entrant: Entrant, info: Info)
        {
            // define turnstile gates, restricted doors and cash registers
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
            

            print ("Validating data .. entrant type: \(entrant)")
            validateRequiredInfo(entrant, info: info)
            
            if let pass = createPass(entrant, addionalInfo: info)
            {
                print("pass is created .. for entrant type: \(entrant)")
                print("Trying to access:\(thunderMountainRailRoadGate.locationName) <--> Message \(thunderMountainRailRoadGate.swipe(pass))")
                print("Trying to access:\(mainControlRoomDoor.locationName) <--> Message \(mainControlRoomDoor.swipe(pass))")
                print("Trying to access:\(kfcRegister.locationName) <--> Message \(kfcRegister.swipe(pass))")
                print("Trying to access:\(fastTrackDumboFlyingElephantGate.locationName) <--> Message \(fastTrackDumboFlyingElephantGate.swipe(pass))")
                print("Trying to access:\(piratesStoreRegister.locationName) <--> Message \(piratesStoreRegister.swipe(pass))")
                print("Trying to access:\(adminOfficeDoor.locationName) <--> Message \(adminOfficeDoor.swipe(pass))")
                print("Trying to access:\(staffKitchenDoor.locationName) <--> Message \(staffKitchenDoor.swipe(pass))")
            }
            else {
                print("pass is not created")
            }

        }
        
        
        // Use Cases
        // Enterant type: Classic Guest
        let entrant1 = Guest.ClassicGuest
        let info1 = Info(birthDate: nil, firstName: "Safwat", lastName: "Shenouda", streetAddress: "some street", city: "Amsterdam", state: "NY", zipCode: "1235GB")
        testAccess(entrant1, info: info1)
        
        // Enterant type: VIP Guest
        let entrant2 = Guest.VIPGuest
        let birthDate = createDateFromString("09-24-2016")
        let info2 = Info(birthDate: birthDate, firstName: "Safwat", lastName: "Shenouda", streetAddress: "some street", city: "Amsterdam", state: "NY", zipCode: "1235GB")
        testAccess(entrant2, info: info2)
        
        // Enterant type: Free Child Guest
        let entrant3 = Guest.FreeChildGuest
        let birthDate3 = createDateFromString("09-24-2012")
        let info3 = Info(birthDate: birthDate3, firstName: "Mark", lastName: nil, streetAddress: nil, city: nil, state: nil, zipCode: nil)
        testAccess(entrant3, info: info3)
        
        // Enterant type: Manager
        let entrant4 = Employee.Manager
        let birthDate4 = createDateFromString("09-24-2012")
        let info4 = Info(birthDate: birthDate4, firstName: "Mark", lastName: "Safwat", streetAddress: "Some street", city: "Amsterdam", state: "NH", zipCode: "1234GB")
        testAccess(entrant4, info: info4)
        

        
        
    }
    
}
