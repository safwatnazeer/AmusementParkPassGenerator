//
//  Model.swift
//  AmuesmentParkPassGenerator
//
//  Created by Safwat Shenouda on 22/09/16.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import Foundation

protocol Entrant {
    var passAccess: PassAccess {get}
    var requiredInfo : [RequiredInfo] {get}
}

enum Guest : Entrant {
        case ClassicGuest
        case VIPGuest
        case FreeChildGuest
    
    var passAccess: PassAccess {
        switch self {
        case .ClassicGuest:
            return PassAccess(rideAccessType: [.AllRides], areaAccessType: [.AmuesmentAreas], discountFood: .Discount0Food, discountMerchandise: .Discount0Merchandise)
        case .VIPGuest :
            return PassAccess(rideAccessType: [.SkipAllRidesLines,.AllRides], areaAccessType: [.AmuesmentAreas], discountFood: .Discount10Food, discountMerchandise: .Discount20Merchandise)
        case .FreeChildGuest:
            return PassAccess(rideAccessType: [.AllRides], areaAccessType: [.AmuesmentAreas], discountFood: .Discount0Food, discountMerchandise: .Discount0Merchandise)
        }
    }
    
    var requiredInfo: [RequiredInfo] {
        switch self {
        case .ClassicGuest:
            return []
        case .VIPGuest:
            return[]
        case .FreeChildGuest:
            return[RequiredInfo.BirthDate]
        }
    }

}

enum Employee: Entrant {
    case HourlyEmployeeFoodServices
    case HourlyEmployeeRideServices
    case HourlyEmployeeMaintenance
    case Manager
    
    var passAccess: PassAccess {
        switch self {
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
    
    var requiredInfo: [RequiredInfo] {
        switch self{
            case .HourlyEmployeeFoodServices,.HourlyEmployeeRideServices,.HourlyEmployeeMaintenance,.Manager:
                return [.FirstName, .LastName, .StreetAddress, .City , .State, .ZipCode]
        }

    }

}








