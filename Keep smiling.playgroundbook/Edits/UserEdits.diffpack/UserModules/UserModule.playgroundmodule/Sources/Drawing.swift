import SwiftUI

struct DrawingScreen: View {
    @EnvironmentObject var configuration: Configuration
    
    @State var currentDrawing: Drawing = Drawing()
    @State var drawings: [Drawing] = []
    @State var color: Color = .black
    @State var lineWidth: CGFloat = 12.0
    @State var canEdit: Bool = false
    @State var frameClicked: Bool = false
    @State var textFieldOpacity: Double = 0.0
    
    @State var presentedText: String = "Keep your imagination flowing by expressing it in creative ways. Not only does it keep you entertained but it's also a great exercise for your brain."
    
    private func finalizeScreen() {
        self.configuration.finalizeDrawing(drawings: self.drawings)
        withAnimation(.easeIn(duration: 2)) {
            self.configuration.decreaseGrayScale(by: 0.2)
            self.configuration.changeSection(to: .bikeRide)
        }
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                HStack {
                    Text(self.presentedText)
                        .font(.title)
                        .fontWeight(.semibold)
                        .shadow(radius: 10)
                        .padding(80)
                        .opacity(self.textFieldOpacity)
                        .onAppear() {
                            self.presentInitialMessages()
                    }
                    if (self.frameClicked) {
                        VStack(spacing: 20) {
                            Button(action: {
                                self.finalizeScreen()
                            }) {
                                Text("Finalize")
                                    .font(Font.system(size: 25))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                            .buttonStyle(SimpleButton(backgroundColor: .springGreen))
                            Button(action: {
                                self.frameClicked = false
                                self.changeToThirdTitle(delay: 0)
                            }) {
                                Text("Make adjustments")
                                    .font(Font.system(size: 25))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                            .buttonStyle(SimpleButton())
                        }.onAppear() {
                            self.presentFinalizingMessage()
                        }
                        .padding(80)
                    }
                }
                Spacer()
            }
            DrawingStand()
                .stroke(Color.lightWood, lineWidth: 24)
            VStack {
                Spacer()
                Spacer()
                DrawingPad(currentDrawing: $currentDrawing,
                           drawings: $drawings,
                           color: $color,
                           lineWidth: $lineWidth,
                           frameClicked: $frameClicked)
                    .frame(width: 280, height: 400)
                    .background(Color(white: 0.95))
                Spacer()
            }
            DrawingControls(color: $color,
                            lineWidth: $lineWidth,
                            drawings: $drawings, 
                            frameClicked: $frameClicked)
                .offset(y: 370)
        }.grayscale(configuration.grayScale)
    }
}


extension DrawingScreen {
    private func presentInitialMessages() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            withAnimation(.easeIn(duration: 1)) {
                self.configuration.decreaseGrayScale(by: 0.1)
                self.textFieldOpacity = 1.0
            }
            self.changeToSecondTitle()
        })
    }
    
    private func changeToSecondTitle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.textFieldOpacity = 0
            }
            self.presentedText = "Grab the brush, pick a color and start drawing. If you make a mistake, you can use the sponge to wipe off that last tap. If you want to start over just throw the sheet in to the trash can."
            self.canEdit = true
            withAnimation(.easeIn(duration: 1)) {
                self.textFieldOpacity = 1.0
            }
            self.changeToThirdTitle(delay: 20)
        })
    }
    
    private func changeToThirdTitle(delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.textFieldOpacity = 0
            }
            self.presentedText = "When you think your masterpiece is complete, frame it and hang it on the wall."
            withAnimation(.easeIn(duration: 1)) {
                self.textFieldOpacity = 1.0
            }
        })
    }
    
    private func presentFinalizingMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.textFieldOpacity = 0
            }
            self.presentedText = "Looks great! Any last touches?"
            withAnimation(.easeIn(duration: 1)) {
                self.textFieldOpacity = 1.0
            }
        })
    }
}
