import SwiftUI

struct Intro: View {
    @EnvironmentObject var configuration: Configuration
    
    @State var firstTextFieldOpacity: Double = 0.0
    @State var secondTextFieldOpacity: Double = 0.0
    @State var thirdTextFieldOpacity: Double = 0.0
    
    func increaseOpacity() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            withAnimation(.easeIn(duration: 2)) {
                self.firstTextFieldOpacity = 1.0
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
            withAnimation(.easeIn(duration: 2)) {
                self.secondTextFieldOpacity = 1.0
                self.configuration.setGrayScale(to: 0.9)
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
            withAnimation(.easeIn(duration: 2)) {
                self.thirdTextFieldOpacity = 1.0
            }
        })
    }
    
    public var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                Text("In challenging times such as these we have to watch over each other and to stay positive.")
                    .font(.title)
                    .fontWeight(.semibold)
                    .shadow(radius: 10)
                    .padding(80)
                    .opacity(firstTextFieldOpacity)
                    .onAppear() {
                        self.increaseOpacity()
                }
                Spacer()
                Text("But before we are able to help those surrounding us, we have to make sure we are in the best shape ourselves.")
                    .font(.title)
                    .fontWeight(.semibold)
                    .shadow(radius: 10)
                    .padding(80)
                    .opacity(secondTextFieldOpacity)
                Spacer()
                HStack() {
                    Text("Here's how we can achieve that.")
                        .font(.title)
                        .fontWeight(.semibold)
                        .shadow(radius: 10)
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.title)
                        .padding(16)
                    Spacer()
                }.onTapGesture {
                    withAnimation(.easeIn(duration: 1)) {
                        self.configuration.changeSection(to: .kitchen)
                    }
                }
                .opacity(thirdTextFieldOpacity)
                .padding(80)
                Spacer()
            }
        }
    }
}
