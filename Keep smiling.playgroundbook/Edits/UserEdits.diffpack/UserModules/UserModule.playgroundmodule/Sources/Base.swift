import SwiftUI

public class Configuration: ObservableObject {
    @Published var grayScale = 0.0
    @Published var section: Section = .intro 
    @Published var createdDrawing: [Drawing] = []
    
    public init() { }
}

extension Configuration {
    public func changeSection(to section: Section) {
        self.section = section
    }
    
    public func setGrayScale(to scale: Double) {
        self.grayScale = scale
    }
    
    public func decreaseGrayScale(by amount: Double) {
        self.grayScale -= amount
    }
    
    public func finalizeDrawing(drawings: [Drawing]) {
        self.createdDrawing = drawings
    }
    
    public func restart() {
        self.grayScale = 0.0
        self.createdDrawing = []
        self.section = .intro
    }
}

public enum Section {
    case intro
    case kitchen
    case drawing
    case bikeRide
    case livingRoom
}

public struct BaseView: View {
    @EnvironmentObject var configuration: Configuration 
    
    public init(){}
    
    public var body: some View {
        ZStack {
            if (configuration.section == .intro) { Intro() } 
            if (configuration.section == .kitchen) { Kitchen() }
            if (configuration.section == .drawing) { DrawingScreen() }
            if (configuration.section == .bikeRide) { BikeRide() }
            if (configuration.section == .livingRoom) { LivingRoom() }
        }
    }
}
