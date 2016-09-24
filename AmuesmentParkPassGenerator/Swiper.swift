//
//  Swiper.swift
//  AmuesmentParkPassGenerator
//
//  Created by Safwat Shenouda on 24/09/16.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import Foundation

protocol Swiper {
    var locationName : String {get}
    func greetForBirthday(pass: Pass) -> String
    func swipe(pass: Pass) -> (Bool,String)
}
extension Swiper {
    // MARK: default impl for birthday greeting
    
    func greetForBirthday(pass: Pass) -> String {
        
        
        if let entrantBirthDate = pass.addionalInfo.birthDate {
        
            let cal = NSCalendar.currentCalendar()
            let entrateBirthDateComp = cal.components([.Day,.Month], fromDate: entrantBirthDate )
            let todayDateComp = cal.components([.Day,.Month], fromDate: NSDate())
            
            if entrateBirthDateComp.day == todayDateComp.day && entrateBirthDateComp.month == todayDateComp.month {
                return " and Happy Birthday 😃"
            }
        }
        
            return ""
        
    }
}

protocol AccessGate: Swiper {
    var accessToCheck: AccessPrevilige {get}
    
}

struct AreaAccessPoint: AccessGate {
    
    var accessToCheck: AccessPrevilige
    let locationName: String
    
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
    let locationName: String
    
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
    let locationName: String
    func swipe(pass: Pass) -> (Bool, String) {
        
        if pass.passAccess.discountFood != DiscountAccessFood.Discount0Food
        {
            let discountPercentage =  pass.passAccess.discountFood.rawValue
            let bdGreeting = greetForBirthday(pass)
            return (true, "Welcome\(bdGreeting), you have \(discountPercentage)% discount on Food.")
            
        } else {
            return (false, "Sorry, you have no discount on Food.")
        }
        
    }
}

struct MerchandiseDiscountSwiper: Swiper {
    
    let locationName: String
    func swipe(pass: Pass) -> (Bool, String) {
        
        if pass.passAccess.discountMerchandise != DiscountAccessMerchandise.Discount0Merchandise
        {
            let discountPercentage =  pass.passAccess.discountMerchandise.rawValue
            let bdGreeting = greetForBirthday(pass)
            return (true, "Welcome\(bdGreeting), you have \(discountPercentage)% discount on Merchandise.")
            
        } else {
            return (false, "Sorry, you have no discount on Merchandise.")
        }
        
    }
    
}
