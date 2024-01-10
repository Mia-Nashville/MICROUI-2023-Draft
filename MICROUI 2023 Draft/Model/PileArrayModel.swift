//
//  PileArrayModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation

struct PileArrayModel: Identifiable, Hashable {
    var id = UUID()
    var pileType : Array<String>
    var rigName: Array<String>
    var casingType: Array<String>
    var bondZoneLength: Array<String>
    var reinforcement: Array<String>
    var soilmame: Array<String>
    var pileSpec: Array<String>
    var casingStickup: Array<String>
}
    /// Every time an enum conforms to the CaseIterable protocol, a static property allCases is made. allCases - array containing all enum cases, so we can operate on them as we would be doing on the elements of any array.
///
///

var pileArrayCollections = PileArrayModel(pileType: ["Type A", "Type B", "Type C", "Type D"], rigName:   ["MC-28", "CasaGrande C-7", "Klemm 806", "MC-24"], casingType:   ["5.5 inch", "7.0 inch", "9 5/8 inch Casing"], bondZoneLength: ["10 ft", "15 ft", "20 ft", "25 ft"], reinforcement:  ["N/A", "#6 GR. 75", "#7 GR. 75", "#8 GR. 75", "#9 GR. 75", "#10 GR. 75", "#11 GR. 75", "11 GR. 75", "14 GR. 75", "18 GR. 75", "20 GR. 75", "#24 GR. 75", "28 GR. 75", "1-1/4 GR. 150", "1-3/8 GR. 150", "1-3/4 GR. 150", "2- 1/4 GR. 150", "2- 1/2 GR. 150", "3 inch GR. 150"], soilmame:   ["N/A", "Fill", "Overburden", "Clay", "Silt", "Organic", "Obstruction", "Seam", "Sandy-Clay", "Sand", "Broken Rocks", "Partially Weathered Rock", "Void", "Competent Rock"], pileSpec:  ["Full Length Cased", "Cased Free-Bar Bond", "Cased Free-Bar Bond-Tension Bar", "Cased Free-Full Length Bar", "Full Length Cased-Tension Bar", "Full Length Cased-Full Length Bar"], casingStickup: ["0 ft", "1 ft", "2 ft", "3 ft", "4 ft", "5 ft"])
// PileArrayModel(pileType: ["Type A", "Type B", "Type C", "Type D"])
