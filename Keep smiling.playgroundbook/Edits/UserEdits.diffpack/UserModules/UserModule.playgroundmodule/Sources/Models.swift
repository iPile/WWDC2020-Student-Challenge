
import SwiftUI

//Drawing

public struct Drawing: Identifiable {
    public var id = UUID()
    public var points: [CGPoint] = []
    public var color: Color = Color.black
    public var lineWidth: CGFloat = 12.0
}

struct BrushInfo: Identifiable {
    var id: Int
    var width: CGFloat
}

struct ColorInfo: Identifiable {
    var id: Int
    var color: Color
}


