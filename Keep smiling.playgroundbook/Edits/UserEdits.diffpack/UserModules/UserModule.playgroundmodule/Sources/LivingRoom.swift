
import SwiftUI

struct LivingRoom: View {
    @EnvironmentObject var configuration: Configuration
    
    @State var faceOpacity: Double = 1.0
    @State var textFieldOpacity: Double = 0.0
    
    @State var presentedText: String = "Looks great, doesn't it? Nice job."
    @State var currentFace: String = "🥵"
    
    @State var finishedRide: Bool = false
    @State var canRestart: Bool = false
    
    @State var bikerOffset: CGFloat = 700
    
    private func finishRide() {
        withAnimation(.easeIn(duration: 2)) {
            self.bikerOffset = -400
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            withAnimation(.easeIn(duration: 1)) {
                self.finishedRide = true
                self.textFieldOpacity = 1
                self.presentedText = "Alriiiight champ, look at you!"
            }
        })
        self.changeToSecondTitle()
    }
    
    private func changeToSecondTitle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.textFieldOpacity = 0
                self.faceOpacity = 0
            }
            self.currentFace = "🤴"
            self.presentedText = "👏👏👏"
            withAnimation(.easeIn(duration: 0.5)) {
                self.textFieldOpacity = 1.0
                self.faceOpacity = 1
            }
        })
        self.changeToThirdTitle()
    }
    
    private func changeToThirdTitle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.textFieldOpacity = 0
                self.faceOpacity = 0
            }
            withAnimation(.easeIn(duration: 2)) {
                self.configuration.decreaseGrayScale(by: 0.3)
            }
            self.currentFace = "😁"
            self.presentedText = "Look at you! That's all it takes to make you feel great, it even looks like the world looks a lot more colorful. And you've got this cool painting now!"
            withAnimation(.easeIn(duration: 0.5)) {
                self.textFieldOpacity = 1.0
                self.faceOpacity = 1
            }
        })
        self.changeToFourthTitle()
    }
    
    private func changeToFourthTitle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 18, execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.textFieldOpacity = 0
            }
            self.presentedText = "Now that you're in your best shape, make time to take care of the people around you. And remember: \"The brightest of times follow the darkest ones.\""
            withAnimation(.easeIn(duration: 0.5)) {
                self.textFieldOpacity = 1.0
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 22, execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.canRestart = true
            }
        })
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                BackgroundView()
                VStack {
                    Spacer()
                    VStack {
                        Text(self.presentedText)
                            .font(.title)
                            .fontWeight(.semibold)
                            .shadow(radius: 10)
                            .opacity(self.textFieldOpacity)
                        if self.canRestart {
                            Image(systemName: "arrow.uturn.left")
                                .font(Font.system(size: 60))
                                .padding(40)
                                .padding(.trailing, 80)
                                .onTapGesture() {
                                    self.configuration.restart()
                            }
                        }
                    }
                .offset(y: 50)
                    .padding(50)
                    .padding(.leading, 320)
                    Spacer()
                }
                Lamp()
                VStack() {
                    Spacer()
                    HStack {
                        ZStack {
                            Color.white
                                .overlay(Rectangle().stroke(lineWidth: 14).foregroundColor(Color.lightWood))
                                .shadow(radius: 1)
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
                            if !self.finishedRide {
                                ZStack {
                                    Text("🚴‍♂️")
                                        .font(Font.system(size: 180))
                                        .offset(x: self.bikerOffset)
                                        .onAppear() {
                                            self.finishRide()
                                    }
                                }
                            }
                        }
                        Spacer()
                        if self.finishedRide {
                            ZStack {
                                You(face: self.currentFace,
                                    faceOpacity: self.faceOpacity)
                            }.offset(y: -170)
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
