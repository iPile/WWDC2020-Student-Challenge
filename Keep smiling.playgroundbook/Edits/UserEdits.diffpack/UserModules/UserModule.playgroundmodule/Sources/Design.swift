// Code inside modules can be shared between pages and other source files.
import SwiftUI

// Colors
extension Color {
    public static let stem = Color(red: 128/255, green: 189/255, blue: 158/255)
    public static let springGreen = Color(red: 137/255, green: 218/255, blue: 89/255)
    public static let petal = Color(red: 249/255, green: 136/255, blue: 102/255)
    public static let walnut = Color(red: 93/255, green: 67/255, blue: 44/255)
    public static let skin = Color(red: 255/255, green: 194/255, blue: 38/255)
    public static let shirt = Color(red: 0/255, green: 142/255, blue: 204/255)
    public static let darkWood = Color(red: 117/255, green: 95/255, blue: 68/255)
    public static let lightWood = Color(red: 236/255, green: 213/255, blue: 167/255)
    
    public static func backgroundGradient() -> RadialGradient {
        return RadialGradient(gradient: Gradient(colors: [.petal, .stem]), center: .topLeading, startRadius: 2, endRadius: 500)
    }
    
    public static func groundGradient() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.gray, .black]), startPoint: .top, endPoint: .bottom)
    }
    
    public static func tableGradient() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.yellow, .walnut]), startPoint: .topLeading, endPoint: .bottom)
    }
    
    public static func plateGradient() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .topTrailing, endPoint: .bottomLeading)
    }
}

//Animations 

extension Animation {
    public static var springEffect: Animation {
        Animation.spring(dampingFraction: 0.7)
            .speed(1.2)
    }
}

//Shared Background
public struct BackgroundView: View {
    @EnvironmentObject var configuration: Configuration
    
    public init(){}
    
    public var body: some View {
        ZStack {
            Color.backgroundGradient()
            .grayscale(configuration.grayScale)
        }
    }
}

// Styles
struct SimpleButton: ButtonStyle {
    var backgroundColor: Color = .white
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(10)
            .font(Font.system(size: 25))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 2).foregroundColor(Color.springGreen))
            .foregroundColor(Color.black)
            .background(backgroundColor)
            .cornerRadius(16)
        .shadow(radius: 3)
    }
}
