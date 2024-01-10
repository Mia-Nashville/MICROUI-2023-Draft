//
//  SoilCondition.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI

enum CasingType: String, CaseIterable {
    case A
    case B
    case C
    case D
    
    var casingtype: String {
        switch self {
        case .A:
            return "4.5 inch "
        case .B:
            return "5.5 inch"
        case .C:
            return "7.0 inch"
        case .D:
            return "9 5/8 inch"
        }
    }
}

enum CasingStickup: String, CaseIterable {
    case typeA
    case typeB
    case typeC
    case typeD
    case typeE
    case typeF
    
    var casingstick: String {
        switch self {
        case .typeA:
            return "O ft"
        case .typeB:
            return "1 ft"
        case .typeC:
            return "2 ft"
        case .typeD:
            return "3 ft"
        case .typeE:
            return "4 ft"
        case .typeF:
            return "5 ft"
        }
    }
}

enum PileSpecs: String, CaseIterable {
    case fulllength
    case freebar
    case bondtension
    case freefulllength
    case casedtension
    case fulllengthcased
    
    var casings: String {
        switch self {
        case .fulllength:
            return "Full Length Cased"
        case .freebar:
            return "Cased Free-Bar Bond"
        case .bondtension:
            return "Cased Free-Bar Bond-Tension Bar"
        case .freefulllength:
            return "Cased Free-Full Length Bar"
        case .casedtension:
            return "Full Length Cased-Tension Bar"
        case .fulllengthcased:
            return "Full Length Cased-Full Length Bar"
        }
    }
}

enum SoilCondition: String, CaseIterable {
    case na
    case fill
    case overburden
    case clay
    case silt
    case organic
    case obstruction
    case seam
    case sandyclay
    case sand
    case brokenrocks
    case partiallyweatheredrock
    case void
    case competentrock
    
    var soilarray: String {
        switch self {
        case .na:
            return "N/A"
        case .fill:
            return "Fill"
        case .overburden:
            return "Overburden"
        case .clay:
            return "Clay"
        case .silt:
            return "Silt"
        case .organic:
            return "Organic"
        case .obstruction:
            return "Obstruction"
        case .seam:
            return "Seam"
        case .sandyclay:
            return "Sandy Clay"
        case .sand:
            return "Sand"
        case .brokenrocks:
            return "Broken Rocks"
        case .partiallyweatheredrock:
            return "PWR"
        case .void:
            return "Void"
        case .competentrock:
            return "Competent Rock"
        }
    }
}


enum PileTypeArray: String, CaseIterable {
    case typeA
    case typeB
    case typeC
    case typeD
    
    var pileType: String {
        switch self {
        case .typeA:
            return " Type A"
        case .typeB:
            return " Type B"
        case .typeC:
            return " Type C"
        case .typeD:
            return " Type D"
        }
    }
}

var pileTypes: PileTypeArray = .typeA

enum rigArray: String, CaseIterable {
    case drillrigA
    case drillrigB
    case drillrigC
    case drillrigD
    case drillrigE
    
    var rigcollection: String {
        switch self {
        case .drillrigA:
            return " MC-28"
        case .drillrigB:
            return " Klemm 702"
        case .drillrigC:
            return " Klemm 806"
        case .drillrigD:
            return " MC-24"
        case .drillrigE:
            return " MC-8"
            
        }
    }
}

var rigTypes: rigArray = .drillrigA

enum BondZoneLength: String, CaseIterable {
    case typeA
    case typeB
    case typeC
    case typeD
    

    var bondzones: String {
        switch self {
        case .typeA:
            return "10 ft"
        case .typeB:
            return "15 ft"
        case .typeC:
            return "20 ft"
        case .typeD:
            return "25 ft"
        }
}
}




