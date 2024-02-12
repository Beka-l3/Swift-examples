//
//  BgGradients+asHexes.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//

import UIKit


extension BgGradients {
    
    var asHexes: [String] {
        switch self {
        
        /// red
        case .eveningShine:             return ["#b92b27", "#1565C0"]
        case .watchingHour:             return ["#c31432", "#240b36"]
        case .flare:                    return ["#f12711", "#f5af19"]
        case .burningOrange:            return ["#FF416C", "#FF4B2B"]
        case .byDesign:                 return ["#009FFF", "#ec2F4B"]
        case .wireTap:                  return ["#8A2387", "#E94057", "#F27121"]
        case .sinCityRed:               return ["#ED213A", "#93291E"]
        case .vanusa:                   return ["#DA4453", "#89216B"]
        case .pureLast:                 return ["#333333", "#dd1818"]
        case .bighead:                  return ["#c94b4b", "#4b134f"]
        case .relaxingRed:              return ["#fffbd5", "#b20a2c"]
        case .alive: 	                return ["#CB356B", "#BD3F32"]
        case .compareNow:               return ["#EF3B36", "#FFFFFF"]
        case .coal:                     return ["#EB5757", "#000000"]
        case .loveAndLiberity:          return ["#200122", "#6f0000"]
        case .ibizaSunset:              return ["#ee0979", "#ff6a00"]
        case .bloodRed:                 return ["#f85032", "#e73827"]
        case .fireWatch:                return ["#cb2d3e", "#ef473a"]
        case .minimalRed:               return ["#F00000", "#DC281E"]
        case .sweetMorning:             return ["#FF5F6D", "#FFC371"]
        case .netflix:                  return ["#8E0E00", "#1F1C18"]
        case .poncho:                   return ["#403A3E", "#BE5869"]
        case .passion:                  return ["#e53935", "#e35d5b"]
        case .instagram:                return ["#833ab4", "#fd1d1d", "#fcb045"]
        case .redMist:                  return ["#000000", "#e74c3c"]
        case .theStrain:                return ["#870000", "#190A05"]
        
        /// orange
        case .tfOrange:                 return ["#f5af4c", "#f15929"]
            
        /// blue
        case .coolBlues:                return ["#2193b0", "#6dd5ed"]
        case .moonlightAsteroid:        return ["#0F2027", "#203A43", "#2C5364"]
        case .coolSky:                  return ["#2980B9", "#6DD5FA", "#2C5364"]
        case .azureLane:                return ["#7F7FD5", "#86A8E7", "#91EAE4"]
        case .blueRespberry:            return ["#00B4DB", "#0083B0"]
        case .eveningNight:             return ["#005AA7", "#FFFDE4"]
        case .digitalWater:             return ["#74ebd5", "#ACB6E5"]
        case .hydrogen:                 return ["#667db6", "#0082c8", "#0082c8", "#667db6"]
        case .telegram:                 return ["#1c92d2", "#f2fcfe"]
        case .scooter:                  return ["#36D1DC", "#5B86E5"]
        case .visionsOfGrandeur:        return ["#000046", "#1CB5E0"]
        case .blueSkies:                return ["#56CCF2", "#2F80ED"]
        case .maldives:                 return ["#B2FEFA", "#0ED2F7"]
        case .cocoaIce:                 return ["#c0c0aa", "#1cefff"]
        case .jodhpur:                  return ["#9CECFB", "#65C7F7", "#0052D4"]
        case .frost:                    return ["#000428", "#004e92"]
        case .deapSeaSpace:             return ["#2C3E50", "#4CA1AF"]
        case .solidVault:               return ["#3a7bd5", "#3a6073"]
        case .brightVault:              return ["#00d2ff", "#928DAB"]
        case .decent:                   return ["#4CA1AF", "#C4E0E5"]
        case .drakSkies:                return ["#4B79A1", "#283E51"]
        case .nightHawk:                return ["#2980b9", "#2c3e50"]
        case .clearSky:                 return ["#005C97", "#363795"]
        case .betweenSkyAndNight:       return ["#2c3e50", "#3498db"]
        case .facebookManager:          return ["#00c6ff", "#0072ff"]
        case .reef:                     return ["#00d2ff", "#3a7bd5"]
        case .aqualicious:              return ["#50C9C3", "#96DEDA"]
        case .steller:                  return ["#7474BF", "#348AC7"]
        case .mantle:                   return ["#24C6DC", "#514A9D"]
        case .boraBora:                 return ["#2BC0E4", "#EAECC6"]
        case .veniceBlue:               return ["#085078", "#85D8CE"]
        case .mirage:                   return ["#16222A", "#3A6073"]
        case .stripe:                   return ["#1FA2FF", "#12D8FA", "#A6FFCB"]
        case .aquaMarine:               return ["#1A2980", "#26D0CE"]
        case .nimvelo:                  return ["#314755", "#26a0da"]
        case .seeBlue:                  return ["#2b5876", "#4e4376"]
        case .sexyBlue:                 return ["#2193b0", "#6dd5ed"]
        case .skyline:                  return ["#1488CC", "#2B32B2"]
        case .blu:                      return ["#00416A", "#E4E5E6"]
            
        /// green
        case .harvey:                   return ["#1f4037", "#99f2c8"]
        case .summerDog:                return ["#a8ff78", "#78ffd6"]
        case .quepal:                   return ["#11998e", "#38ef7d"]
        case .subu:                     return ["#0cebeb", "#20e3b2", "#29ffc6"]
        case .chittyBang:               return ["#007991", "#78ffd6"]
        case .cinnaMint:                return ["#4AC29A", "#BDFFF3"]
        case .pacificDream:             return ["#34e89e", "#0f3443"]
        case .orca:                     return ["#44A08D", "#093637"]
        case .theBlueLagoon:            return ["#43C6AC", "#191654"]
        case .underTheLake:             return ["#093028", "#237A57"]
        case .honeyDew:                 return ["#43C6AC", "#F8FFAE"]
        case .disco:                    return ["#4ECDC4", "#556270"]
        case .vine:                     return ["#00bf8f", "#001510"]
        case .endlessRiver:             return ["#43cea2", "#185a9d"]
        case .betweenClouds:            return ["#73C8A9", "#373B44"]
        case .seeBlizz:                 return ["#1CD8D2", "#93EDC7"]
        case .mojito:                   return ["#1D976C", "#93F9B9"]
        case .seeWeed:                  return ["#4CB8C4", "#3CD3AD"]
        case .greenBeach:               return ["#02AAB0", "#00CDAC"]
        case .windy:                    return ["#acb6e5", "#86fde8"]
            
        /// pink
        case .azurePop:                 return ["#ef32d9", "#89fffd"]
        
        /// purple
        case .purplerBliss:             return ["#360033", "#0b8793"]
        case .shroomHaze:               return ["#5C258D", "#4389A2"]
        
        /// gray
        case .winter:                   return ["#E6DADA", "#274046"]
        case .moor:                     return ["#616161", "#9bc5c3"]
        case .sky:                      return ["#076585", "#ffffff"]
        case .lizard:                   return ["#304352", "#d7d2cc"]
        case .foreverLost:              return ["#5D4157", "#A8CABA"]
                
        }
    }
    
}
