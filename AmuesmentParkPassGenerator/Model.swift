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
                 return PassAccess(rideAbility: [.AllRides], areaAccessType: [.AmuesmentAreas], discountFood: .Discount0Food, discountMerchandise: .Discount0Merchandise)
            case .VIPGuest :
                return PassAccess(rideAbility: [.SkipAllRidesLines,.AllRides], areaAccessType: [.AmuesmentAreas], discountFood: .Discount10Food, discountMerchandise: .Discount20Merchandise)
            case .FreeChildGuest:
                return PassAccess(rideAbility: [.AllRides], areaAccessType: [.AmuesmentAreas], discountFood: .Discount0Food, discountMerchandise: .Discount0Merchandise)
        
            
        case .HourlyEmployeeFoodServices:
            return PassAccess(rideAbility: [.AllRides], areaAccessType: [.AmuesmentAreas,.KitchenAreas], discountFood: .Discount15Food, discountMerchandise: .Discount25Merchandise)
        case .HourlyEmployeeRideServices:
            return PassAccess(rideAbility: [.AllRides], areaAccessType: [.AmuesmentAreas,.RideControlAreas], discountFood: .Discount15Food, discountMerchandise: .Discount25Merchandise)
        case .HourlyEmployeeMaintenance:
            return PassAccess(rideAbility: [.AllRides], areaAccessType: [.AmuesmentAreas,.MaintenanceAreas,.RideControlAreas,.KitchenAreas], discountFood: .Discount15Food, discountMerchandise: .Discount25Merchandise)
        case .Manager:
            return PassAccess(rideAbility: [.AllRides], areaAccessType: [.AmuesmentAreas,.MaintenanceAreas,.RideControlAreas,.KitchenAreas,.OfficeAreas], discountFood: .Discount15Food, discountMerchandise: .Discount25Merchandise)

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



class Pass {
    
    var entrantType: EntrantType
    var passAccess: PassAccess
    var addionalInfo: Info
    
    
    init(entrantType: EntrantType, passAccess: PassAccess,addionalInfo:Info ) {
        self.entrantType = entrantType
        self.passAccess = passAccess
        self.addionalInfo = addionalInfo
    }
    
}


class PassGenerator  {
    
    func showRequiredInfo(entrantType: EntrantType) -> [RequiredInfo]{
        // show required info list
        print (entrantType.requiredInfo)
        return entrantType.requiredInfo
    }
    
    func validateRequiredInfo (entrantType: EntrantType, info:Info) -> Error {
        
        let requiredInfo = entrantType.requiredInfo
        
        if requiredInfo.contains(.BirthDate) && info.birthDate == nil {return Error.BirthDateMissing}
        if requiredInfo.contains(.FirstName) && info.firstName == nil {return Error.FirstNameMissing}
        if requiredInfo.contains(.LastName) && info.lastName == nil {return Error.LastNameMissing}
        if requiredInfo.contains(.StreetAddress) && info.streetAddress == nil {return Error.StreetAddressMissing}
        if requiredInfo.contains(.City) && info.city == nil {return Error.CityMissing}
        if requiredInfo.contains(.State) && info.state == nil {return Error.StateMissing}
        if requiredInfo.contains(.ZipCode) && info.zipCode == nil {return Error.ZipCodeMissing}
        
        
        return .NoError
    }
    
    
}


























