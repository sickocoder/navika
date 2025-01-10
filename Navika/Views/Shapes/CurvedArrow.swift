//
//  CurvedArrow.swift
//  Navika
//
//  Created by A255085 on 08/09/24.
//
import SwiftUI

struct CurvedArrow: Shape {
  var from: CGPoint
  var to: CGPoint
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    // Midpoint to control the curve (below both points for a downward curve)
    let midPoint = CGPoint(x: (from.x + to.x) - (from.x + to.x) * 0.8 , y: max(from.y, to.y) + 10)
    
    // Draw the curve
    path.move(to: from)
    path.addQuadCurve(to: to, control: midPoint)
    
    // Add arrowhead at the destination point
    let arrowAngle: CGFloat = .pi / 5
    let arrowLength: CGFloat = 10
    
    let angle: CGFloat = 0
    
    let arrowPoint1 = CGPoint(x: to.x - arrowLength * cos(angle - arrowAngle),
                              y: to.y - arrowLength * sin(angle - arrowAngle))
    let arrowPoint2 = CGPoint(x: to.x - arrowLength * cos(angle + arrowAngle),
                              y: to.y - arrowLength * sin(angle + arrowAngle))
    
    path.move(to: to)
    path.addLine(to: arrowPoint1)
    path.move(to: to)
    path.addLine(to: arrowPoint2)
    
    return path
  }
}
