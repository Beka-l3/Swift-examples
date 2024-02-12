//
//  BgGradients.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//

import UIKit


enum BgGradients: CaseIterable {
    
    /// red
    case eveningShine, watchingHour, flare, burningOrange, byDesign, wireTap, sinCityRed, vanusa, pureLast
    case bighead, relaxingRed, alive, compareNow, coal, loveAndLiberity, ibizaSunset, bloodRed, fireWatch
    case minimalRed, sweetMorning, netflix, poncho, passion, instagram, redMist, theStrain
    
    /// orange
    case tfOrange
    
    /// blue
    case coolBlues, moonlightAsteroid, coolSky, azureLane, blueRespberry, eveningNight, digitalWater
    case hydrogen, telegram, scooter, visionsOfGrandeur, blueSkies, maldives, cocoaIce, jodhpur
    case frost, deapSeaSpace, solidVault, brightVault, decent, drakSkies, nightHawk, clearSky
    case betweenSkyAndNight, facebookManager, reef, aqualicious, steller, mantle, boraBora
    case veniceBlue, mirage, stripe, aquaMarine, nimvelo, seeBlue, sexyBlue, skyline, blu
    
    /// green
    case harvey, summerDog, quepal, subu, chittyBang, cinnaMint, pacificDream, orca, theBlueLagoon
    case underTheLake, honeyDew, disco, vine, endlessRiver, betweenClouds, seeBlizz, mojito
    case seeWeed, greenBeach, windy
    
    /// pink
    case azurePop
    
    /// purple
    case  purplerBliss, shroomHaze
    
    /// gray
    case winter, moor, sky, lizard, foreverLost
}


extension BgGradients {
        
    var asColors: [UIColor] {
        asHexes.enumerated().map { UIColor(hex: $1) ?? ($0 % 2 == 0 ? .gray : .black) }
    }

}


extension BgGradients {
    
    var asLayer: CAGradientLayer {
        getGradient(with: asColors)
    }
    
    private func getGradient(using hexes: [String]) -> CAGradientLayer {
        let colors = hexes.map { (UIColor(hex: $0) ?? .clear) }
        return getGradient(with: colors)
    }
    
    private func getGradient(with colors: [UIColor]) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.type = .axial
        layer.colors = colors.map { $0.cgColor }
        layer.zPosition = 0
        layer.startPoint = .init(x: 0, y: 0)
        layer.endPoint = .init(x: 1, y: 0)
        return layer
    }
}

