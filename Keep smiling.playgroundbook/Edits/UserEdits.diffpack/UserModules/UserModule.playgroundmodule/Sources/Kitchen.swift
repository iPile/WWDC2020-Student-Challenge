import SwiftUI

public struct Kitchen: View {
    @EnvironmentObject var configuration: Configuration
    
    @State var currentFace: String = "😕"
    @State var isFridgeOpen: Bool = false
    
    @State var firstTextFieldOpacity: Double = 0.0
    @State var presentedText: String = "Remember to make the right food choices to feel great and to keep your immune system on point."
    
    @State var chickenClicked: Bool = false
    @State var saladClicked: Bool = false
    @State var riceClicked: Bool = false
    @State var juiceClicked: Bool = false
    
    @State var chickenEaten: Bool = false
    @State var saladEaten: Bool = false
    @State var riceEaten: Bool = false
    @State var juiceEaten: Bool = false
    
    @State var healthyChoices: Int = 0
    @State var foodsEaten: Int = 0
    
    @State var canTurnPage: Bool = false
    
    public var body: some View {
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
                            .padding(80)
                            .opacity(self.firstTextFieldOpacity)
                            .onAppear() {
                                self.increaseOpacity()
                        }
                        if (self.canTurnPage) {
                            Image(systemName: "chevron.right.circle.fill")
                                .font(Font.system(size: 60))
                                .padding(.trailing, 80)
                        }
                    }.onTapGesture {
                        if (self.canTurnPage) {
                            withAnimation(.easeIn(duration: 1)) {
                                self.configuration.changeSection(to: .drawing)
                            }
                        }
                    }
                    Spacer()
                }
                Lamp()
                VStack {
                    Spacer()
                    HStack() {
                        Spacer()
                        self.refrigerator
                        Spacer()
                        ZStack {
                            You(face: self.currentFace)
                        }
                        Spacer()
                        ZStack {
                            Text("🕚")
                                .font(Font.system(size: 70))
                                .offset(y: -200)
                            Table()
                                .shadow(radius: 3)
                                .offset(y: -5)
                            self.topOfTable
                                .shadow(radius: 3)
                                .offset(x: -50, y: -10)
                        }
                        Spacer()
                    }
                    .offset(y: 20)
                    HStack {
                        Color.groundGradient()
                            .grayscale(self.configuration.grayScale)
                    }
                    .frame(width: geo.size.width, height: 90, alignment: .bottom)
                }
            }
        }.grayscale(self.configuration.grayScale)
    }
}

// Mesages 

extension Kitchen {
    private func increaseOpacity() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            withAnimation(.easeIn(duration: 1)) {
                self.firstTextFieldOpacity = 1.0
            }
            self.changeToSecondTitle()
        })
        
    }
    
    private func changeToSecondTitle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.firstTextFieldOpacity = 0
            }
            self.presentedText = "Go ahead and open up the fridge and grab something to eat."
            withAnimation(.easeIn(duration: 1)) {
                self.firstTextFieldOpacity = 1.0
            }
        })
    }
    
    private func presentBeerMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.firstTextFieldOpacity = 0
            }
            self.presentedText = "I don't think that's a good idea, it's 11:00 a.m."
            withAnimation(.easeIn(duration: 1)) {
                self.firstTextFieldOpacity = 1.0
            }
        })
    }
    
    private func presentHotdogMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.firstTextFieldOpacity = 0
            }
            self.presentedText = "You need to burn some calories first to earn that hot dog, grab something healthier."
            withAnimation(.easeIn(duration: 1)) {
                self.firstTextFieldOpacity = 1.0
            }
        })
    }
    
    private func presentPositiveMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.firstTextFieldOpacity = 0
            }
            self.presentedText = "Great choice! But you're starving and you feel that this won't be enough."
            withAnimation(.easeIn(duration: 1)) {
                self.firstTextFieldOpacity = 1.0
            }
        })
    }
    
    private func presentDigInMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.firstTextFieldOpacity = 0
            }
            self.presentedText = "That looks good! Dig in."
            withAnimation(.easeIn(duration: 1)) {
                self.firstTextFieldOpacity = 1.0
            }
        })
    }
    
    private func presentEnoughMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.firstTextFieldOpacity = 0
            }
            self.presentedText = "That looks enough, time to eat!"
            withAnimation(.easeIn(duration: 1)) {
                self.firstTextFieldOpacity = 1.0
            }
        })
    }
    
    private func presentEndingMessages() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.firstTextFieldOpacity = 0
            }
            self.presentedText = "De-li-cious."
            withAnimation(.easeIn(duration: 1)) {
                self.currentFace = "😌"
                self.isFridgeOpen = false
                self.firstTextFieldOpacity = 1.0
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            withAnimation(.easeIn(duration: 0.5)) {
                self.firstTextFieldOpacity = 0
            }
            self.canTurnPage = true
            self.presentedText = "Now that the hunger's gone, let's concentrate on things how you can keep your mind active and your body in shape."
            withAnimation(.easeIn(duration: 1)) {
                self.firstTextFieldOpacity = 1.0
            }
        })
    }
}


// topOfTable 

extension Kitchen {
    private func decreaseGrayscale() {
        self.configuration.decreaseGrayScale(by: 0.1)
    }
    
    private func eatFood() {
        self.decreaseGrayscale()
        self.foodsEaten += 1
    }
    
    var topOfTable: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12) 
                .frame(width: 60, height: 5)
            HStack(spacing: 2) {
                if (self.chickenClicked && !self.chickenEaten) {
                    Text("🍗")
                        .font(Font.system(size: 30))
                        .onTapGesture {
                            if self.foodsEaten < 2 {
                                withAnimation(.easeOut(duration: 1)) {
                                    self.eatFood()
                                    self.chickenEaten.toggle()
                                }
                            } else if self.foodsEaten == 2 {
                                self.eatFood()                            
                                self.chickenEaten.toggle()
                                self.presentEndingMessages()
                            }
                    }
                }
                if (self.saladClicked && !self.saladEaten) {
                    Text("🥗")                      
                        .font(Font.system(size: 30))
                        .onTapGesture {
                            if self.foodsEaten < 2 {
                                withAnimation(.easeOut(duration: 1)) {
                                    self.eatFood()                     
                                    self.saladEaten.toggle()
                                }
                            } else if self.foodsEaten == 2 {
                                self.eatFood()                            
                                self.saladEaten.toggle()
                                self.presentEndingMessages()
                            }
                    }
                }
                if (self.riceClicked && !self.riceEaten) {
                    Text("🍚")
                        .font(Font.system(size: 25))
                        .onTapGesture {
                            if self.foodsEaten < 2 {
                                withAnimation(.easeOut(duration: 1)) {
                                    self.eatFood()
                                    self.riceEaten.toggle()
                                }
                            } else if self.foodsEaten == 2 {
                                self.eatFood()                            
                                self.riceEaten.toggle()
                                self.presentEndingMessages()
                            }
                    }
                }
                if (self.juiceClicked && !self.juiceEaten) {
                    Text("🧃")
                        .font(Font.system(size: 30))
                        .onTapGesture {
                            if self.foodsEaten < 2 {
                                withAnimation(.easeOut(duration: 1)) {
                                    self.eatFood()
                                    self.juiceEaten.toggle()
                                }
                            } else if self.foodsEaten == 2 {
                                self.eatFood()                            
                                self.juiceEaten.toggle()
                                self.presentEndingMessages()
                            }
                    }
                }
            }.offset(x: 20, y: -12)
        }
    }
}

// Refrigerator
extension Kitchen {
    var refrigerator: some View {
        ZStack {
            Refrigerator()
                .shadow(radius: 2)
            HStack {
                if (!self.chickenClicked) {
                    Text("🍗")
                        .font(Font.system(size: 30))
                        .onTapGesture {
                            if self.healthyChoices < 2 {
                                self.presentPositiveMessage()
                                self.healthyChoices += 1
                                withAnimation(.easeIn(duration: 1)) {
                                    self.chickenClicked.toggle()
                                }
                            } else if self.healthyChoices == 2 {
                                self.presentDigInMessage()
                                self.healthyChoices += 1
                                withAnimation(.easeIn(duration: 1)) {
                                    self.chickenClicked.toggle()
                                }
                            } else {
                                self.presentEnoughMessage()
                            }
                    }
                }
                Text("🌭")                               
                    .font(Font.system(size: 30))
                    .onTapGesture {
                        self.presentHotdogMessage()
                }
            }.offset(y: -30)
            HStack {
                if (!self.riceClicked) {
                    Text("🍚")
                        .font(Font.system(size: 25))
                        .onTapGesture {
                            if self.healthyChoices < 2 {
                                self.presentPositiveMessage()
                                self.healthyChoices += 1        
                                withAnimation(.easeIn(duration: 1)) {
                                    self.riceClicked.toggle()
                                }
                            } else if self.healthyChoices == 2 {
                                self.presentDigInMessage()
                                self.healthyChoices += 1
                                withAnimation(.easeIn(duration: 1)) {
                                    self.riceClicked.toggle()
                                }
                            } else {
                                self.presentEnoughMessage()
                            }
                    }
                }
                if (!self.saladClicked) {
                    Text("🥗")                               
                        .font(Font.system(size: 30))                  
                        .onTapGesture {
                            if self.healthyChoices < 2 {
                                self.presentPositiveMessage()
                                self.healthyChoices += 1
                                withAnimation(.easeIn(duration: 1)) {
                                    self.saladClicked.toggle()
                                }                    
                            } else if self.healthyChoices == 2 {
                                self.presentDigInMessage()
                                self.healthyChoices += 1
                                withAnimation(.easeIn(duration: 1)) {
                                    self.saladClicked.toggle()
                                }
                            } else {
                                self.presentEnoughMessage()
                            }
                    }
                }
            }.offset(y: 15)
            HStack {
                if (!self.juiceClicked) {
                    Text("🧃")
                        .font(Font.system(size: 30))
                        .onTapGesture {
                            if self.healthyChoices < 2 {
                                self.presentPositiveMessage()
                                self.healthyChoices += 1
                                withAnimation(.easeIn(duration: 1)) {
                                    self.juiceClicked.toggle()
                                }                 
                            } else if self.healthyChoices == 2 {
                                self.presentDigInMessage()
                                self.healthyChoices += 1
                                withAnimation(.easeIn(duration: 1)) {
                                    self.juiceClicked.toggle()
                                }
                            } else {
                                self.presentEnoughMessage()
                            }
                    }
                }
                Text("🍺")                               
                    .font(Font.system(size: 30))
                    .onTapGesture {
                        self.presentBeerMessage()
                }
            }.offset(y: 60)
            RefrigeratorDoor(isOpen: $isFridgeOpen)
                .shadow(radius: 2)
                .offset(y: 55)
                .onTapGesture {
                    if self.foodsEaten < 3 {
                        withAnimation(Animation.spring()){
                            self.isFridgeOpen.toggle()
                        }
                    }
            }
        }
    }
}
