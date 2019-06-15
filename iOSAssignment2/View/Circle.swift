//
//  Circle.swift
//  iOSAssignment2
//
//  Created by Carl on 6/4/19.
//  Copyright © 2019 Carl. All rights reserved.
//

import UIKit

class Circle : UIButton
{
    var label : UILabel
    
    var radius : CGFloat
    
    //initialize circle based on center point and radius
    //
    init(center : CGPoint, radius : CGFloat, number : String)
    {
        let frame : CGRect = CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
        
        self.radius = radius
        
        label = UILabel()
        //label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
        
        super.init(frame: frame)
        
        //label.frame.origin.x = (bounds.width / 2) - (label.frame.width / 2)
        
        backgroundColor = .clear
        
        addSubview(label)
        
        configureLabel(number: number)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    //some label configuration shared in init methods
    private func configureLabel(number : String)
    {
        label.contentMode = .center
        
        //does not animate well
        //
        //add layout constraints to the number label
        //based on parent's layout
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                label.topAnchor.constraint(equalTo: topAnchor),
                label.bottomAnchor.constraint(equalTo: topAnchor, constant: 50.0),
                label.leftAnchor.constraint(equalTo: leftAnchor),
                label.rightAnchor.constraint(equalTo: rightAnchor)
            ]
        )
        
        //-----
        
        label.backgroundColor = .clear
        label.text = number
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 48.0)
    }
    
    //draws the circle, assumes a square container
    override func draw(_ rect: CGRect)
    {
        super.draw(rect)
        
        //get graphics context
        if let context = UIGraphicsGetCurrentContext()
        {
            //set graphics state for circle
            //
            let strokeWidth : CGFloat = 2.0
            
            context.setStrokeColor(red: 0.263, green: 0.494, blue: 0.765, alpha: 1.0)
            context.setLineWidth(strokeWidth)
            
            //create circle
            let ellipseRect : CGRect = CGRect(x: rect.origin.x + strokeWidth / 2, y: rect.origin.y + strokeWidth / 2, width: rect.size.width - strokeWidth, height: rect.size.width - strokeWidth)
            
            //draw the built circle
            context.strokeEllipse(in: ellipseRect)
            
            /*
             //another way to draw circle
             let ourPoint : CGPoint  = convert(center, from: superview)
             context.addArc(center: ourPoint, radius: rect.size.width / 2 - strokeWidth / 2, startAngle: 0.0, endAngle: CGFloat.pi * 2, clockwise: false)
             context.strokePath()
             */
        }
        else
        {
            print("FAILED TO GET CGCONTEXT")
        }
    }
    
    //update radius
    func setRadius(radiusIn : CGFloat)
    {
        radius = radiusIn
        frame = CGRect(x: center.x - radiusIn, y: center.y - radiusIn, width: radiusIn * 2, height: radiusIn * 2)
        
        label.frame.origin.x = (bounds.width / 2) - (label.frame.width / 2)
        label.frame.origin.y = 0
        
        setNeedsDisplay()
    }
    
    func getRadius() -> CGFloat
    {
        return radius
    }
}
