//
//  BasicElements.swift
//  AmuesmentParkPassGenerator
//
//  Created by Safwat Shenouda on 23/09/16.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import Foundation

protocol AccessPrevilige {
    
}

enum AreaAccessType: AccessPrevilige {
    
    case AmuesmentAreas
    case KitchenAreas
    case RideControlAreas
    case MaintenanceAreas
    case OfficeAreas
    
}

enum RideAccessType: AccessPrevilige {
    case AllRides
    case SkipAllRidesLines
}

enum DiscountAccessFood : Int,AccessPrevilige {
    case Discount0Food = 0
    case Discount10Food = 10
    case Discount15Food = 15
    case Discount25Food = 25
}

enum DiscountAccessMerchandise : Int,AccessPrevilige {
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
    var rideAccessType: [RideAccessType]
    var areaAccessType: [AreaAccessType]
    var discountFood: DiscountAccessFood
    var discountMerchandise: DiscountAccessMerchandise
}

enum RequiredInfo
{
    case BirthDate
    case FirstName
    case LastName
    case StreetAddress
    case City
    case State
    case ZipCode
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
    var entrantType: Entrant
    var passAccess: PassAccess
    var addionalInfo: Info
    
}
