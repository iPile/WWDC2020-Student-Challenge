import SwiftUI

struct Lamp: View {
    init() {}
    
    var body: some View {
        ZStack {
            Cable()
                .stroke(Color.black, lineWidth: 1)
            Text("💡")
                .rotationEffect(Angle(degrees: 180))
                .font(Font.system(size: 40))
            .offset(y: -140)
        }.shadow(radius: 3)
    }
}

struct Cable: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let celling = CGPoint(x: rect.midX, y: rect.minY)
        let lamp = CGPoint(x: rect.midX, y: rect.midY * 0.7)
        
        path.move(to: celling)
        path.addLine(to: lamp)
        
        return path
    }
}

struct Table: View {
    @EnvironmentObject var configuration: Configuration
    
    init(){}
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.darkWood)
                .frame(width: 12, height: 100)
                .offset(x: -60, y: 50)
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.darkWood)
                .frame(width: 12, height: 100)
                .offset(x: 60, y: 50)
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.darkWood)
                .frame(width: 200, height: 10)
        }.grayscale(configuration.grayScale)
    }
}

struct RefrigeratorDoor: View {
    @Binding var isOpen: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: isOpen ? 50 : 100, height: 160)
                .offset(x: isOpen ? 70 : 0)
        }.frame(width: 80, height: 80, alignment: .bottom)    
    }
}

struct Refrigerator: View {
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 100, height: 100)
            }
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                        .frame(width: 100, height: 160)
                        .offset(y: -5)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray)
                        .brightness(0.3)
                        .frame(width: 80, height: 140)
                        .offset(y: -5)
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 80, height: 2)
                        .offset(y: -35)
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 80, height: 2)
                        .offset(y: 8)
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 80, height: 2)
                    .offset(y: 55)
            }
        }.frame(width: 160, height: 200, alignment: .bottom)    
    }
}
