import SwiftUI

struct DrawingControls: View {
    @EnvironmentObject var configuration: Configuration
    
    @Binding var color: Color
    @Binding var lineWidth: CGFloat 
    @Binding var drawings: [Drawing]
    @Binding var frameClicked: Bool 
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 350, height: 40)
                .padding(40)
                .shadow(color: .black, radius: 2, x: -0.5, y: 1)
            ZStack {
                ColorPicker(color: $color, frameClicked: $frameClicked)
                    .offset(x: -150)
                Brush(color: $color, 
                      lineWidth: $lineWidth,
                      frameClicked: $frameClicked)
                    .offset(x: -75)
                Text("🧽")
                    .font(Font.system(size: 60))
                    .onTapGesture {
                        if !self.frameClicked {
                            self.drawings.removeLast()
                        }
                }
                Text("🗑")
                    .font(Font.system(size: 60))
                    .offset(x: 75)
                    .onTapGesture {
                        if !self.frameClicked {
                            self.showAlert.toggle()
                        }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Are you sure you want to throw away this masterpiece?"), 
                          primaryButton: .default(Text("Yes")) { self.drawings.removeAll() },
                          secondaryButton: .cancel())
                }
                Text("🖼")
                    .font(Font.system(size: 60))
                    .offset(x: 150)
                    .onTapGesture {
                        if (!self.drawings.isEmpty) {
                            self.frameClicked = true
                        }
                }
            }.offset(y: -15)
        }
    }
}


struct Brush: View {
    @State private var shown: Bool = false
    @Binding var color: Color
    @Binding var lineWidth: CGFloat
    @Binding var frameClicked: Bool
    
    var brushes: [BrushInfo] = [BrushInfo(id: 1, width: 4.0),
                                BrushInfo(id: 2, width: 8.0),
                                BrushInfo(id: 3, width: 12.0),
                                BrushInfo(id: 4, width: 16.0),
                                BrushInfo(id: 5, width: 20.0),
                                BrushInfo(id: 6, width: 24.0)]
    
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .shadow(radius: 3)
                VStack(spacing: 1) {
                    ForEach(brushes.reversed()) { brush in
                        BrushWidthBubble(color: self.color)
                            .frame(width: brush.width * 1.5, height: self.shown ? brush.width * 1.5 : 0)
                            .padding(brush.width * 0.3)
                            .animation(.springEffect)
                            .onTapGesture {
                                withAnimation(.springEffect) {
                                    self.lineWidth = brush.width
                                    self.shown = false
                                }
                        }
                    }.frame(width: 40, height: shown ? 40 : 0)
                }
            }
            .offset(y: shown ? -150 : 0)
            .frame(width: shown ? 40 : 0, height: shown ? 200 : 0)
            Text("🖌")
                .font(Font.system(size: 60))
                .onTapGesture {
                    withAnimation(.springEffect) {
                        if !self.frameClicked {
                            self.shown.toggle()
                        }
                    }
            }
        }
    }
}

struct ColorPicker: View {
    @State private var shown: Bool = false
    @Binding var color: Color
    @Binding var frameClicked: Bool
    
    var colors: [ColorInfo] = [ColorInfo(id: 1, color: .black),
                               ColorInfo(id: 2, color: .blue),
                               ColorInfo(id: 3, color: .purple),
                               ColorInfo(id: 4, color: .green),
                               ColorInfo(id: 5, color: .pink),
                               ColorInfo(id: 6, color: .red),
                               ColorInfo(id: 7, color: .orange),
                               ColorInfo(id: 8, color: .yellow),
                               ColorInfo(id: 9, color: .gray)]
    
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .shadow(radius: 3)
                VStack(spacing: 1) {
                    ForEach(colors) { colorInfo in
                        ColorBubble(color: colorInfo.color)
                            .animation(.springEffect)
                            .onTapGesture {
                                withAnimation(.springEffect) {
                                    self.color = colorInfo.color
                                    self.shown = false
                                }
                        }
                    }
                    .frame(width: 40, height: shown ? 40 : 0)
                }
            }
            .offset(y: shown ? -210 : 0)
            .frame(width: 40, height: shown ? 320 : 0)
            Text("🎨")
                .font(Font.system(size: 60))
                .onTapGesture {
                    withAnimation(.springEffect) {
                        if !self.frameClicked {
                            self.shown.toggle()
                        }
                    }
            }
        }
    }
}


struct BrushWidthBubble: View {
    let color: Color
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
        }
    }
}

struct ColorBubble: View {
    let color: Color
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .padding(5)
        }
    }
}
