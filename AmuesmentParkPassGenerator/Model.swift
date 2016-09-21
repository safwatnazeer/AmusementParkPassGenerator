//
//  Model.swift
//  AmuesmentParkPassGenerator
//
//  Created by Safwat Shenouda on 22/09/16.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import Foundation

enum EntrantType {
    
    case ClassicGuest
    case VIPGuest
    case FreeChildGuest
    case HourlyEmployeeFoodServices
    case HourlyEmployeeRideServices
    case HourlyEmployeeMaintenance
    case Manager
    
}

enum AreaAccessType {
    
    case AmuesmentAreas
    case KitchenAreas
    case RideControlAreas
    case MaintenanceAreas
    case OfficeAreas
    
}

enum RideAbility {
    case AllRides
    case SkipAllRidesLines
}

enum DiscountAccessFood : Int {
    case Discount0Food = 0
    case Discount10Food = 10
    case Discount15Food = 15
    case Discount25Food = 25
}

enum DiscountAccessMerchandise : Int {
    case Discount0Merchandise = 0
    case Discount10Merchandise = 10
    case Discount25Merchandise = 25
}

struct PersonalInformation {
    
    let firstName: String
    let lastName: String
    let streetAddress: String
    let city: String
    let state:String
    let zipCode: String
    
    
    
}


struct PassAccess {
    
    let enterantType: EntrantType
    let rideAbility: RideAbility
    let areaAccessType: AreaAccessType
    let discountFood: DiscountAccessFood
    let discountMerchandise: DiscountAccessMerchandise
}

protocol Entrant {
    var personalInfoRequired: Bool { get set}
    var personalInfo: PersonalInformation? {get set}
}

extension Entrant {
    
}


class Pass : Entrant {
 
    var personalInfoRequired: Bool
    var personalInfo: PersonalInformation?
    var birthDate: NSDate?
    let passAccess: PassAccess
    
    init() {
        
    }
}






























