//
// Created by Tim Shull on 9/18/16.
// Copyright (c) 2016 Tim Shull. All rights reserved.
//

import Cocoa


class DieView: NSView {

    var intValue: Int? = 1 {
        didSet {
            needsDisplay = true
        }
    }

    var pressed: Bool = false {
        didSet {
            needsDisplay = true
        }
    }

    func randomize() {
        intValue = Int(arc4random_uniform(5) + 1)
    }

    override var intrinsicContentSize: NSSize {
        return NSSize(width: 20, height: 20)
    }

    override func draw(_ dirtyRect:NSRect) {
        let backgroundColor = NSColor.lightGray
        backgroundColor.set()
        NSBezierPath.fill(bounds)
        drawDieWithSize(size: bounds.size)
    }

    func metricsForSize(size:CGSize) -> (edgeLength:CGFloat, dieFrame:CGRect) {
        let edgeLength = min(size.width, size.height)
        let padding = edgeLength / 10.0
        let drawingBounds = CGRect(x: 0, y: 0, width: edgeLength, height: edgeLength)
        var dieFrame = drawingBounds.insetBy(dx: padding, dy: padding)
        if pressed {
            dieFrame = dieFrame.offsetBy(dx: 0, dy: -edgeLength / 40)
        }
        return (edgeLength, dieFrame)
    }

    func drawDieWithSize(size:CGSize) {
        if let intValue = intValue {
            let (edgeLength, dieFrame) = metricsForSize(size: size)
            let cornerRadius: CGFloat = edgeLength / 5.0
            let dotRadius = edgeLength / 12.0
            let dotFrame = dieFrame.insetBy(dx: dotRadius * 2.5, dy: dotRadius * 2.5)

            NSGraphicsContext.saveGraphicsState()

            let shadow = NSShadow()
            shadow.shadowOffset = NSSize(width: 0, height: -1)
            shadow.shadowBlurRadius = edgeLength / 20
            shadow.set()

            NSColor.white.set()
            NSBezierPath(roundedRect: dieFrame, xRadius: cornerRadius, yRadius: cornerRadius).fill()

            NSGraphicsContext.restoreGraphicsState()

            NSColor.black.set()

            func drawDot(x u:CGFloat, y v:CGFloat) {
                let dotOrigin = CGPoint(x: dotFrame.minX + dotFrame.width * u,
                        y: dotFrame.minY + dotFrame.height * v)
                let dotRect = CGRect(origin: dotOrigin, size: CGSize.zero)
                .insetBy(dx: -dotRadius, dy: -dotRadius)
                NSBezierPath(ovalIn: dotRect).fill()
            }

            if (1 ... 6).index(of: intValue) != nil {
                // Draw Dots
                if [1, 3, 5].index(of: intValue) != nil {
                    drawDot(x: 0.5, y: 0.5) // center dot
                }
                if (2 ... 6).index(of: intValue) != nil {
                    drawDot(x: 1, y: 0) // upper left
                    drawDot(x: 0, y: 1) // lower right
                }
                if (4 ... 6).index(of: intValue) != nil {
                    drawDot(x: 1, y: 1) // upper right
                    drawDot(x: 0, y: 0) // lower left
                }
                if intValue == 6 {
                    drawDot(x: 0.5, y: 0) // mid left/right
                    drawDot(x: 0.5, y: 1)
                }
            }
        }
    }

    // MARK: - Mouse Events

    override func mouseDown(with event:NSEvent) {
        Swift.print("mouseDown")
        let dieFrame = metricsForSize(size: bounds.size).dieFrame
        let pointInView = convert(event.locationInWindow, from: nil)
        pressed = dieFrame.contains(pointInView)
    }

    override func mouseDragged(with event:NSEvent) {
        Swift.print("mouseDragged location: \(event.locationInWindow)")
    }

    override func mouseUp(with event:NSEvent) {
        Swift.print("mouseUp clickCount: \(event.clickCount)")
        if event.clickCount == 2 && pressed {
            randomize()
        }
        pressed = false
    }

}





