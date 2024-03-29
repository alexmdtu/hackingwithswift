//
//  ViewController.swift
//  Project27
//
//  Created by Alexander Tu on 05.12.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        drawTwin()
    }
    
    func drawTwin() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            // draw T
            ctx.cgContext.move(to: CGPoint(x: 10, y: 210))
            ctx.cgContext.addLine(to: CGPoint(x: 118, y: 210))
            ctx.cgContext.move(to: CGPoint(x: 64, y: 210))
            ctx.cgContext.addLine(to: CGPoint(x: 64, y: 352))
            
            // draw W
            ctx.cgContext.move(to: CGPoint(x: 138, y: 210))
            ctx.cgContext.addLine(to: CGPoint(x: 170, y: 352))
            ctx.cgContext.move(to: CGPoint(x: 170, y: 352))
            ctx.cgContext.addLine(to: CGPoint(x: 192, y: 210))
            ctx.cgContext.move(to: CGPoint(x: 192, y: 210))
            ctx.cgContext.addLine(to: CGPoint(x: 224, y: 352))
            ctx.cgContext.move(to: CGPoint(x: 224, y: 352))
            ctx.cgContext.addLine(to: CGPoint(x: 246, y: 210))
            
            // draw I
            ctx.cgContext.move(to: CGPoint(x: 320, y: 210))
            ctx.cgContext.addLine(to: CGPoint(x: 320, y: 352))
            
            // draw N
            ctx.cgContext.move(to: CGPoint(x: 394, y: 210))
            ctx.cgContext.addLine(to: CGPoint(x: 394, y: 352))
            ctx.cgContext.move(to: CGPoint(x: 394, y: 210))
            ctx.cgContext.addLine(to: CGPoint(x: 448, y: 352))
            ctx.cgContext.move(to: CGPoint(x: 448, y: 352))
            ctx.cgContext.addLine(to: CGPoint(x: 448, y: 210))

            // draw all lines
            ctx.cgContext.setLineWidth(20)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawSlightlySmilingEmoji() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            // draw background circle
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)

            ctx.cgContext.setFillColor(UIColor.systemYellow.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.systemOrange.cgColor)
            ctx.cgContext.setLineWidth(1)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            // draw eyes
            let leftEye = CGRect(x: 150, y: 150, width: 50, height: 100)
            ctx.cgContext.setFillColor(UIColor.brown.cgColor)
            ctx.cgContext.addEllipse(in: leftEye)
            ctx.cgContext.drawPath(using: .fill)
            
            let rightEye = CGRect(x: 320, y: 150, width: 50, height: 100)
            ctx.cgContext.setFillColor(UIColor.brown.cgColor)
            ctx.cgContext.addEllipse(in: rightEye)
            ctx.cgContext.drawPath(using: .fill)
            
            // draw mouth
            let startPoint = CGPoint(x: 150, y: 350)
            let endPoint = CGPoint(x: 370, y: 350)
            let controlPoint = CGPoint(x: 260, y: 420)
            ctx.cgContext.move(to: startPoint)
            ctx.cgContext.addQuadCurve(to: endPoint, control: controlPoint)
            ctx.cgContext.setStrokeColor(UIColor.brown.cgColor)
            ctx.cgContext.setLineWidth(10)
            ctx.cgContext.drawPath(using: .stroke)
        }

        imageView.image = img
    }

    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

           let img = renderer.image { ctx in
               let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)

               ctx.cgContext.setFillColor(UIColor.red.cgColor)
               ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
               ctx.cgContext.setLineWidth(10)

               ctx.cgContext.addRect(rectangle)
               ctx.cgContext.drawPath(using: .fillStroke)
           }

           imageView.image = img
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)

            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        imageView.image = img
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)

            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }

        imageView.image = img
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)

            let rotations = 16
            let amount = Double.pi / Double(rotations)

            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }

            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }

        imageView.image = img
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)

            var first = true
            var length: CGFloat = 256

            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)

                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }

                length *= 0.99
            }

            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }

        imageView.image = img
    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]

            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attrs)

            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)

            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }

        imageView.image = img
    }
    
    @IBAction func redrawTapped(_ sender: UIButton) {
        currentDrawType += 1

        if currentDrawType > 5 {
            currentDrawType = 0
        }

        switch currentDrawType {
        case 0:
            drawSlightlySmilingEmoji()
        case 1:
            drawRectangle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()

        default:
            break
        }
    }
}

