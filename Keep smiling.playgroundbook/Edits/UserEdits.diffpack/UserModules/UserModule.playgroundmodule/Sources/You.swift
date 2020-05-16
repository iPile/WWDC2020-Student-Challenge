
import SwiftUI

struct You: View {
    @EnvironmentObject var configuration: Configuration
    
    var face: String 
    var faceOpacity: Double = 1.0
    
    init(face: String,
         faceOpacity: Double = 1.0) {
        self.face = face
        self.faceOpacity = faceOpacity
    }
    
    private var arm: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(.skin)
                .frame(width: 15, height: 90)
            shoulder
                .offset(y: -40)
        }
    }
    
    private var neck: some View {
        RoundedRectangle(cornerRadius: 16)
            .foregroundColor(.skin)
            .frame(width: 15, height: 30)
    }
    
    private var shoulder: some View {
        RoundedRectangle(cornerRadius: 12)
            .trim(from: 0.5, to: 1)
            .fill(Color.white)
            .frame(width: 20, height: 30)
    }
    private var leg: some View {
        RoundedRectangle(cornerRadius: 8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 0.2).foregroundColor(.black))
            .foregroundColor(.shirt)      
            .frame(width: 20, height: 120)
    }
    
    public var body: some View {
        HStack {
            ZStack {
                arm
                    .offset(x: -25, y: 5)
                
                arm
                    .offset(x: 25, y: 5)
                
                leg
                    .offset(x: 10, y: 80)
                
                leg
                    .offset(x: -10, y: 80)
                
                RoundedRectangle(cornerRadius: 20)
                    .trim(from: 0.5, to: 1)
                    .fill(Color.white)
                    .frame(width: 50, height: 180)
                    .offset(y: 35)
                
                neck
                    .offset(y: -65)
                
                Text(face)
                    .font(Font.system(size: 50))
                    .offset(y: -82)
                    .opacity(faceOpacity)
            }
        }
        .shadow(radius: 3)
            
    .grayscale(configuration.grayScale)
        .frame(width: 30, height: 90, alignment: .bottom)      
    }
}
