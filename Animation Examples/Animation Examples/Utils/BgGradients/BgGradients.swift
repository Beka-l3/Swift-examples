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
    case tfOrange, citrusPeal, orangeFun, lightOrange, darkKnight, masterCard, soundCloud, kyoto
    case sunrise, mango, blooker20, dawn
    
    /// yellow
    case anwar, alihossein, sulphur, sagePersuasion, snapchat, freshTurbocent, siriusTamed
    case frozen, rea, vasily
    
    /// blue
    case coolBlues, moonlightAsteroid, coolSky, azureLane, blueRespberry, eveningNight, digitalWater
    case hydrogen, telegram, scooter, visionsOfGrandeur, blueSkies, maldives, cocoaIce, jodhpur
    case frost, deapSeaSpace, solidVault, brightVault, decent, drakSkies, nightHawk, clearSky
    case betweenSkyAndNight, facebookManager, reef, aqualicious, steller, mantle, boraBora
    case veniceBlue, mirage, stripe, aquaMarine, nimvelo, seeBlue, sexyBlue, skyline, blu, horizon
    case royal
    
    /// green
    case harvey, summerDog, quepal, subu, chittyBang, cinnaMint, pacificDream, orca, theBlueLagoon
    case underTheLake, honeyDew, disco, vine, endlessRiver, betweenClouds, seeBlizz, mojito
    case seeWeed, greenBeach, windy, terminal, behongo, moss, greenToDark
    
    /// pink
    case azurePop, candy, sublimeLight, cosmicFusion, dusk, yoda, neuromancer, shifter
    case pinkFlavour, argon, blackRose, flicker, cherryblossom, dimigo
    
    /// purple
    case purplerBliss, shroomHaze, twitch, friday, deepPurple, amin, keyMeh, magic, kyooTah
    case ultraViolet, slightOceanView, moonPurple, lawrencium, delicate, relay, venice
    case canYouFeelTheLoveTonight, radar, amethyst, dirtyFog, kashmir, purpleParadise
    
    /// gray
    case winter, moor, sky, lizard, foreverLost, petrol, fiftyShadesOfGray
    case gradeGray, sandToBlue, zinc, selenium, deepSpace, portrait, hersheys
    case serveQuick, ash, titanium, midnightCity, mystic, steelGray, copper
}


extension BgGradients {
        
    var asColors: [UIColor] {
        asHexes.enumerated().map { UIColor(hex: $1) ?? ($0 % 2 == 0 ? .gray : .black) }
    }
    
    var textColor: UIColor {
        isGradientBright() ? .black : .white
    }
    
    private func isGradientBright() -> Bool {
        let totalBrightness = asColors.reduce(0) { $0 + (isColorBright($1) ? 1 : 0) }
        return totalBrightness > asColors.count / 2
    }
    
    private func isColorBright(_ color: UIColor) -> Bool {
        guard let components = color.cgColor.components, components.count >= 3 else {
            return false
        }
        
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        
        let brightness = ((red * 299) + (green * 587) + (blue * 114)) / 1000
        
        return brightness > 0.5
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

