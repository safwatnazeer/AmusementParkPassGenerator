//
//  BasicElements.swift
//  AmuesmentParkPassGenerator
//
//  Created by Safwat Shenouda on 23/09/16.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import Foundation


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
    case Discount20Merchandise = 20
    case Discount25Merchandise = 25
}

enum Error {
    case NoError
    case FreeChildGuestAgeAboveLimit
    case FreeChildAgeMissing
    case PersonalDataNotProvided
    case BirthDateMissing
    case FirstNameMissing
    case LastNameMissing
    case StreetAddressMissing
    case CityMissing
    case StateMissing
    case ZipCodeMissing
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
    var rideAbility: [RideAbility]
    var areaAccessType: [AreaAccessType]
    var discountFood: DiscountAccessFood
    var discountMerchandise: DiscountAccessMerchandise
}
