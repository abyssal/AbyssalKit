import Foundation
import UIKit
import SwiftUI

enum Direction {
    case back
    case nearest
    case forward
}

struct DateFormats {
    static var longDate = "EEEE, MMM d, yyyy"
    static var time = "h:mm aa"
}

extension Date {
    public func asLongDateString() -> String {
        return self.string(inFormat: DateFormats.longDate)
    }
    
    public func asTimeString() -> String {
        return self.string(inFormat: DateFormats.time)
    }
    
    public func string(inFormat in0: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = in0
        return dateFormatter.string(from: self)
    }
    
    public func getWeekday(_ direction: Direction) -> Date {
        var tempDate = self
        if Calendar.current.isDateInWeekend(tempDate) {
            if direction == .nearest {
                let forward = self.getWeekday(.forward)
                let back = self.getWeekday(.back)
                if (self.distance(to: forward) > self.distance(to: back)) {
                    return back
                }
                return forward
            }
            
            while Calendar.current.isDateInWeekend(tempDate) {
                switch direction {
                case .back:
                    tempDate = tempDate.advanced(by: -86400)
                case .forward:
                    tempDate = tempDate.advanced(by: 86400)
                default:
                    tempDate = tempDate.advanced(by: 86400)
                }
            }
        } else {
            return self
        }
        return tempDate
    }
}

extension String {
    public func date(inFormat in0: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = in0
        return dateFormatter.date(from: self)
    }
    
    public func asPcsDate() -> Date? {
        let components = self.components(separatedBy: "/")
        return Calendar.current.date(from: DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: Int(components[2]), month: Int(components[1]), day: Int(components[0])))
    }
    
    public func randomUIColor() -> UIColor {
        var total: Int = 0
        for u in self.unicodeScalars {
            total += Int(UInt32(u))
        }
        srand48(total * 200)
        let r = CGFloat(drand48())
        srand48(total)
        let g = CGFloat(drand48())
        srand48(total / 200)
        let b = CGFloat(drand48())
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    public func randomColor() -> Color {
        return Color(self.randomUIColor()).opacity(1)
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return nil
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
    public final func toHSBComponents() -> (h: CGFloat, s: CGFloat, b: CGFloat) {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        getHue(&h, saturation: &s, brightness: &b, alpha: nil)
        
        return (h: h, s: s, b: b)
    }
    
    public final var hueComponent: CGFloat {
        return toHSBComponents().h
    }
    
    public final var saturationComponent: CGFloat {
        return toHSBComponents().s
    }
    
    public final var brightnessComponent: CGFloat {
        return toHSBComponents().b
    }
}
