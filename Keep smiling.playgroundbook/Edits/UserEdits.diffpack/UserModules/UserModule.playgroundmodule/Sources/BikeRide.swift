import SwiftUI

struct BikeRide: View {
    @EnvironmentObject var configuration: Configuration
    
    @State var textFieldOpacity: Double = 0.0
    @State var presentedText: String = "Looks great, doesn't it? Nice job."
    @State var currentFace: String = "😋"
    
    @State var selectedBike = false
    @State var isBikeClickable = false
    
    private func increaseOpacity() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            withAnimation(.easeIn(duration: 1)) {
                self.textFieldOpacity = 1.0
            }
            self.changeToSecondTitle() 
        })
    }
    
    private func changeToSecondTitle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.textFieldOpacity = 0
            }
            self.presentedText = "Now it's time for some exercise to keep your body in shape."
            withAnimation(.easeIn(duration: 1)) {
                self.textFieldOpacity = 1.0
            }
            self.changeToThirdTitle()
        })
    }
    
    private func changeToThirdTitle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.textFieldOpacity = 0
            }
            self.isBikeClickable = true
            self.presentedText = "Wipe off the dust off of your bike, hop on and go for a ride!"
            withAnimation(.easeIn(duration: 1)) {
                self.textFieldOpacity = 1.0
            }
        })
    }
    
    private func startRide() {
        self.selectedBike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            withAnimation(.easeIn(duration: 2)) {
                self.configuration.changeSection(to: .livingRoom)
            }
        })
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                BackgroundView()
                VStack {
                    Spacer()
                    HStack {
                        Text(self.presentedText)
                                .font(.title)
                                .fontWeight(.semibold)
                                .shadow(radius: 10)
                                .padding(50)
                                .padding(.trailing, 250)
                                .opacity(self.textFieldOpacity)
                                .onAppear() {
                                    self.increaseOpacity()
                            }
                    }
                    Spacer()
                }
                Lamp()
                VStack() {
                    Spacer()
                    HStack {
                        Spacer()
                        Spacer()
                        Spacer()
                        ZStack {
                            Color.white
                                .overlay(Rectangle().stroke(lineWidth: 14).foregroundColor(Color.lightWood))
                                .shadow(radius: 1.5)
                                .offset(x: 20, y: 40)
                            FramedDrawing(drawings: self.configuration.createdDrawing)
                        }
                        .frame(width: 180, height: 260)
                        .offset(x: 100)
                        Spacer()
                    }
                    Spacer()
                }
                VStack {
                    Spacer()
                    HStack() {
                        Spacer()
                        HStack {
                            ZStack {
                                Text(self.selectedBike ? "🚴‍♂️" : "🚲")
                                        .font(Font.system(size: 180))
                                        .offset(x: self.selectedBike ? -400 : 0)
                                        .onTapGesture {
                                            withAnimation(.easeIn(duration: 2)) {
                                                self.startRide()
                                            }
                                }
                            }
                        }
                        Spacer()
                        if (!self.selectedBike) {
                            ZStack {
                                You(face: self.currentFace)
                            }
                        }
                        Spacer()
                        Spacer()
                    }
                    .offset(y: 125)
                    HStack {
                        Color.groundGradient()
                            .grayscale(self.configuration.grayScale)
                    }
                    .frame(width: geo.size.width, height: 90)
                }
            }
        }.grayscale(self.configuration.grayScale)
    }
}

struct FramedDrawing: View {
    var drawings: [Drawing] = []
    
    var body: some View {
        ZStack {
            ForEach(self.drawings) { drawing in
                Path { path in
                    self.add(drawing: drawing, to: &path)
                }
                .stroke(drawing.color, lineWidth: drawing.lineWidth)
            }.scaleEffect(0.5)
        }
    }
    
    private func add(drawing: Drawing, to path: inout Path) {
        path.addLines(drawing.points)
    }
}
