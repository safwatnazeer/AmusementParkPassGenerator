//
//  Model.swift
//  AmuesmentParkPassGenerator
//
//  Created by Safwat Shenouda on 22/09/16.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import Foundation


enum RequiredInfo {
    
    case BirthDate
    case FirstName
    case LastName
    case StreetAddress
    case City
    case State
    case ZipCode
}


enum EntrantType {
    
    case ClassicGuest
    case VIPGuest
    case FreeChildGuest
    
    case HourlyEmployeeFoodServices
    case HourlyEmployeeRideServices
    case HourlyEmployeeMaintenance
    case Manager
    
    
    
    var passAccess: PassAccess {
        switch self{
            case .ClassicGuest:
                 return PassAccess(rideAccessType: [.AllRides], areaAccessType: [.AmuesmentAreas], discountFood: .Discount0Food, discountMerchandise: .Discount0Merchandise)
            case .VIPGuest :
                return PassAccess(rideAccessType: [.SkipAllRidesLines,.AllRides], areaAccessType: [.AmuesmentAreas], discountFood: .Discount10Food, discountMerchandise: .Discount20Merchandise)
            case .FreeChildGuest:
                return PassAccess(rideAccessType: [.AllRides], areaAccessType: [.AmuesmentAreas], discountFood: .Discount0Food, discountMerchandise: .Discount0Merchandise)
        
            
        case .HourlyEmployeeFoodServices:
            return PassAccess(rideAccessType: [.AllRides], areaAccessType: [.AmuesmentAreas,.KitchenAreas], discountFood: .Discount15Food, discountMerchandise: .Discount25Merchandise)
        case .HourlyEmployeeRideServices:
            return PassAccess(rideAccessType: [.AllRides], areaAccessType: [.AmuesmentAreas,.RideControlAreas], discountFood: .Discount15Food, discountMerchandise: .Discount25Merchandise)
        case .HourlyEmployeeMaintenance:
            return PassAccess(rideAccessType: [.AllRides], areaAccessType: [.AmuesmentAreas,.MaintenanceAreas,.RideControlAreas,.KitchenAreas], discountFood: .Discount15Food, discountMerchandise: .Discount25Merchandise)
        case .Manager:
            return PassAccess(rideAccessType: [.AllRides], areaAccessType: [.AmuesmentAreas,.MaintenanceAreas,.RideControlAreas,.KitchenAreas,.OfficeAreas], discountFood: .Discount15Food, discountMerchandise: .Discount25Merchandise)

            }
        }

    var requiredInfo:[RequiredInfo] {
        switch self {
        case .ClassicGuest:
            return []
        case .VIPGuest :
            return []
        case .FreeChildGuest:
            return [.BirthDate]
            
            
        case .HourlyEmployeeFoodServices:
            return [.FirstName, .LastName, .StreetAddress, .City , .State, .ZipCode]
        case .HourlyEmployeeRideServices:
            return [.FirstName, .LastName, .StreetAddress, .City , .State, .ZipCode]
       case .HourlyEmployeeMaintenance:
            return [.FirstName, .LastName, .StreetAddress, .City , .State, .ZipCode]
        case .Manager:
            return [.FirstName, .LastName, .StreetAddress, .City , .State, .ZipCode]


        }
    }

}




struct Info {
    var birthDate: NSDate?
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipCode: String?
}



struct Pass {
    var entrantType: EntrantType
    var passAccess: PassAccess
    var addionalInfo: Info
    
}


final class PassGenerator  {
    
    func showRequiredInfo(entrantType: EntrantType) -> [RequiredInfo]{
        // show required info list
        for r in entrantType.requiredInfo { print("Required Info: \(r)") }
        return entrantType.requiredInfo
    }
    
    func validateRequiredInfo (entrantType: EntrantType, info:Info) -> [Error] {
        
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
        if (entrantType == .FreeChildGuest) {
            if let birthDate = info.birthDate {
                // check age <= 5 years else add error age above limit
            }
        }
        
        // show errors
        for e in errors { print("Error found: \(e)") }
        return errors
    }
    
    
    
    func createPass(entrantType: EntrantType, addionalInfo:Info) -> Pass? {
        
        let validateInfoResult = validateRequiredInfo(entrantType, info: addionalInfo)
        guard validateInfoResult.count == 0  else {
            return nil
        }
        
        return Pass(entrantType: entrantType, passAccess: entrantType.passAccess, addionalInfo: addionalInfo)
    }
    
}

class AmuesmentParkEntranceKiosk {
    
    func plugData(){
        
        let e1 = EntrantType.FreeChildGuest
        let g = PassGenerator()
        g.showRequiredInfo(e1)
        let i1 = Info(birthDate: nil, firstName: "Safwat", lastName: "Nazeer", streetAddress: "some street", city: "Cairo", state: "NY", zipCode: "1235GB")
        let _ = g.validateRequiredInfo(e1, info: i1)
        
        
        if let pass = g.createPass(e1, addionalInfo: i1)
        {
           
            let kitchenGate = AreaAccessPoint(accessToCheck: AreaAccessType.KitchenAreas)
            print( kitchenGate.swipe(pass) )
            
            let foodSwiperKFC = FoodDiscountSwiper()
            print(foodSwiperKFC.swipe(pass))
            
           let merchandizeSwiperGAP = MerchandiseDiscountSwiper()
            print(merchandizeSwiperGAP.swipe(pass))
            
        }
        
        let e2 = EntrantType.VIPGuest
        let i2 = Info()
        if let pass2 = g.createPass(e2, addionalInfo: i2) {
            
            let skipLineGateThunderTower = RideAccessPoint(accessToCheck: RideAccessType.SkipAllRidesLines)
           print ( skipLineGateThunderTower.swipe(pass2) )
            
            let foodSwiperMac = FoodDiscountSwiper()
            print(foodSwiperMac.swipe(pass2) )
        }
        
        
     
    }
    
}


protocol Swiper {
    func greetForBirthday(pass: Pass) -> String
    func swipe(pass: Pass) -> (Bool,String)
}
extension Swiper {
    // MARK: default impl for birthday greeting
    func greetForBirthday(pass: Pass) -> String {
        return " and Happy Birthday 😃"
    }
}

protocol AccessGate: Swiper {
    var accessToCheck: AccessPrevilige {get}
    
}

struct AreaAccessPoint: AccessGate {

    var accessToCheck: AccessPrevilige
    
    func swipe(pass: Pass) -> (Bool, String) {
        
        if let accessToCheck = self.accessToCheck as? AreaAccessType {
        
            if pass.passAccess.areaAccessType.contains(accessToCheck) {
                let bdGreeting = greetForBirthday(pass)
                return (true, "Welcome\(bdGreeting)")
            }
        }
        
        return (false,"Sorry, You cant admit here")
    }
}

struct RideAccessPoint: AccessGate {
    
    var accessToCheck: AccessPrevilige
    
    func swipe(pass: Pass) -> (Bool, String) {
        
        if let accessToCheck = self.accessToCheck as? RideAccessType {
            
            if pass.passAccess.rideAccessType.contains(accessToCheck) {
                let bdGreeting = greetForBirthday(pass)
                return (true, "Welcome\(bdGreeting)")
            }
        }
        
        return (false,"Sorry, You cant admit here")
    }
}

struct FoodDiscountSwiper: Swiper {
    
    func swipe(pass: Pass) -> (Bool, String) {
        
        if pass.passAccess.discountFood != DiscountAccessFood.Discount0Food
        {
            let discountPercentage =  pass.passAccess.discountFood.rawValue
            let bdGreeting = greetForBirthday(pass)
            return (true, "Welcome\(bdGreeting), you have \(discountPercentage)% on Food.")
            
        } else {
        return (false, "Sorry, you have no discount on Food.")
        }
    
    }
}

struct MerchandiseDiscountSwiper: Swiper {
        
        func swipe(pass: Pass) -> (Bool, String) {
            
            if pass.passAccess.discountMerchandise != DiscountAccessMerchandise.Discount0Merchandise
            {
                let discountPercentage =  pass.passAccess.discountMerchandise.rawValue
                let bdGreeting = greetForBirthday(pass)
                return (true, "Welcome\(bdGreeting), you have \(discountPercentage)% on Merchandise.")
                
            } else {
                return (false, "Sorry, you have no discount on Merchandise.")
            }
            
        }
        
}



