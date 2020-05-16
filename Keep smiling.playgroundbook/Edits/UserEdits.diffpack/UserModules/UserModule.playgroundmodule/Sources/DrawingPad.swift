
import SwiftUI

struct DrawingPad: View {
    @Binding var currentDrawing: Drawing 
    @Binding var drawings: [Drawing] 
    @Binding var color: Color 
    @Binding var lineWidth: CGFloat 
    @Binding var frameClicked: Bool 
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                ForEach(self.drawings) { drawing in
                    Path { path in
                        self.add(drawing: drawing, to: &path)
                    }.stroke(drawing.color, lineWidth: drawing.lineWidth)
                }
                Path { path in 
                    self.add(drawing: self.currentDrawing, to: &path)
                }.stroke(self.currentDrawing.color, lineWidth: self.currentDrawing.lineWidth)
            }
            .gesture(
                DragGesture(minimumDistance: 0.1)
                    .onChanged({ (value) in
                        let currentPoint = value.location
                        if self.canPaint(point: currentPoint, proxy: geometry) {
                            self.currentDrawing.color = self.color
                            self.currentDrawing.lineWidth = self.lineWidth
                            self.currentDrawing.points.append(currentPoint)
                        }
                    })
                    .onEnded({ (value) in
                        self.drawings.append(self.currentDrawing)
                        self.currentDrawing = Drawing(color: self.color, lineWidth: self.lineWidth)
                    })
            )
        }
    }
}

extension DrawingPad {
    private func add(drawing: Drawing, to path: inout Path) {
        path.addLines(drawing.points)
    }
    
    private func isPointWithinBounds(point: CGPoint, proxy: GeometryProxy) -> Bool {
        return (point.y >= 0 && point.y < proxy.size.height) && (point.x >= 0 && point.x < proxy.size.width) && !self.frameClicked
    }
    
    private func canPaint(point: CGPoint, proxy: GeometryProxy) -> Bool {
        return isPointWithinBounds(point: point, proxy: proxy) && !self.frameClicked
    }
}

struct DrawingStand: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let middleLegTop = CGPoint(x: rect.midX, y: rect.midY * 0.65)
        let middleLegBottom = CGPoint(x: rect.width / 2, y: rect.maxY)
        
        let leftLegTop = CGPoint(x: rect.midX - 70, y: rect.midY * 0.55)
        let leftLegBottom = CGPoint(x: rect.width / 2 - 140, y: rect.maxY)
        
        let rightLegTop = CGPoint(x: rect.midX + 70, y: rect.midY * 0.55)
        let rightLegBottom = CGPoint(x: rect.width / 2 + 140, y: rect.maxY)
        
        let paperHolderLeft = CGPoint(x: rect.width / 2 - 150, y: rect.maxY * 0.8)
        
        let paperHolderRight = CGPoint(x: rect.width / 2 + 150, y: rect.maxY * 0.8)
        
        path.move(to: middleLegTop)
        path.addLine(to: middleLegBottom)
        
        path.move(to: leftLegTop)
        path.addLine(to: leftLegBottom)
        
        path.move(to: rightLegTop)
        path.addLine(to: rightLegBottom)
        
        path.move(to: paperHolderLeft)
        path.addLine(to: paperHolderRight)
        
        return path
    }
}
