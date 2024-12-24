//
//  AppView.swift
//  TestProject001
//
//  Created by Mac on 10/04/24.
//

import Foundation
import UIKit

class AppView :UIView {
    // setter/getter cornerRadius for UIButton
    @IBInspectable var cornerRadius: CGFloat {
      set {
        layer.cornerRadius = newValue
      }
      get {
        return layer.cornerRadius
      }
    }

    // setter/getter borderWidth for UIButton
    @IBInspectable var borderWidth: CGFloat {
      set {
        layer.borderWidth = newValue
      }
      get {
        return layer.borderWidth
      }
    }

    // setter/getter borderColor for UIButton
    @IBInspectable var borderColor: UIColor? {
      set {
        guard let uiColor = newValue else { return }
        layer.borderColor = uiColor.cgColor
      }
      get {
        guard let color = layer.borderColor else { return nil }
        return UIColor(cgColor: color)
      }
    }

}
class  AppButton : UIButton{
    // setter/getter borderWidth for UIButton
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    // setter/getter cornerRadius for UIButton
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    // setter/getter borderColor for UIButton
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
}
extension UIView {
//MARK: Gradient Background
    public func applyGradient(){
        clipsToBounds = true
        let gradientLayer = CAGradientLayer() //
        gradientLayer.colors = [UIColor.blue.cgColor,UIColor.yellow.cgColor, UIColor.red.cgColor]
        gradientLayer.locations = [0.0,0.5,1.0]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        gradientLayer.frame = self.frame
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
   // func addGradient(_ colors: [UIColor], locations: [NSNumber], frame: CGRect)->CAGradientLayer {
    func addGradient(_ colors: [UIColor], locations: [NSNumber] ,viewToApply:UIView) -> CAGradientLayer {
          // Create a new gradient layer
          let gradientLayer = CAGradientLayer()
          
          // Set the colors and locations for the gradient layer
          gradientLayer.colors = colors.map{ $0.cgColor }
          gradientLayer.locations = locations

          // Set the start and end points for the gradient layer
          gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
          //gradientLayer.cornerRadius = 7
 
          // Set the frame to the layer
       // gradientLayer.frame = frame
        
        gradientLayer.frame = viewToApply.bounds
        viewToApply.clipsToBounds = true
        viewToApply.layer.insertSublayer(gradientLayer, at: 0)
        
          // Add the gradient layer as a sublayer to the background view
        //  layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
        
       }
    //NW
    func applyViewShadow(viewToApply:UIView){
        viewToApply.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewToApply.layer.shadowColor =  UIColor.gray.cgColor
        viewToApply.layer.shadowOpacity = 0.7
        viewToApply.layer.shadowRadius = 4
    }
    
}
extension UIButton {
    //NW
   public func applybuttonShadow(){
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowColor =  UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4
    }
}

extension UIColor {
    convenience init(hexString: String) {

                let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
                var int = UInt32()
                Scanner(string: hex).scanHexInt32(&int)
                let a, r, g, b: UInt32
                switch hex.count {
                case 3: // RGB (12-bit)
                    (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
                case 6: // RGB (24-bit)
                    (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
                case 8: // ARGB (32-bit)
                    (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
                default:
                    (a, r, g, b) = (0, 0, 0, 0)
                }
                self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
            }

            var toHex: String? {
                return toHex()
            }

            // MARK: - From UIColor to String
            func toHex(alpha: Bool = false) -> String? {
                guard let components = cgColor.components, components.count >= 3 else {
                    return nil
                }

                let r = Float(components[0])
                let g = Float(components[1])
                let b = Float(components[2])
                var a = Float(1.0)

                if components.count >= 4 {
                    a = Float(components[3])
                }

                if alpha {
                    return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
                } else {
                    return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
                }
            }
}

extension UINavigationController {
    public func navBarAppearance(){
        
        //Removing back button text
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationBar.tintColor = UIColor.purple
        navigationBar.backgroundColor = UIColor(hexString: "#E0C1FC" )
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.purple,
            .font: UIFont(name: "Montserrat-SemiBold", size: 20) ?? UIFont.systemFont(ofSize: 20)
            
        ]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.isTranslucent = false
        
        
    }
 /*   public func navigationBarItems(title:String?){
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backBarButtonItem
    }
   */
    
    
}

extension UserDefaults {
    func storeData<T:Codable>(_ object: T, key: String){
        
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.set(data, forKey: key)
        }catch let error{
            print("Error Encoding :\(error)")
        }
    }
    
    func retrieveData<T: Codable>(for key: String) -> T? {
            do {
                guard let data = UserDefaults.standard.data(forKey: key) else {
                    return nil
                    }
                return try JSONDecoder().decode(T.self, from: data)
            } catch let error {
                print("Error decoding: \(error)")
                return nil
            }
        }
}
