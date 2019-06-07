//
//  FirstCircleTapState.swift
//  iOSAssignment2
//
//  Created by Carl on 6/5/19.
//  Copyright © 2019 Carl. All rights reserved.
//

import UIKit

//state that represents the first tap
//tapping a circle will shrink it and grow the others
//
class FirstCircleTapState : CircleTapState
{
    let circle1 : Circle
    let circle2 : Circle
    let circle3 : Circle
    let circle4 : Circle
    
    let radius : CGFloat
    
    init(circle1In : Circle, circle2In : Circle, circle3In : Circle, circle4In : Circle, radiusIn : CGFloat)
    {
        circle1 = circle1In
        circle2 = circle2In
        circle3 = circle3In
        circle4 = circle4In
        
        radius = radiusIn
    }
    
    //the "handle" functions that shrink the tapped circle and grows the others
    //disables interactions while resizing to avoid issues when tapping mid-animation
    //enables them again when done
    //all switch the context's state to the "next" state
    //
    func circle1Tapped(contextIn : CircleTapContext)
    {
        animate(shrinkingCircle: circle1, growingCircle1: circle2, growingCircle2: circle3, growingCircle3: circle4, contextIn: contextIn)
    }
    
    func circle2Tapped(contextIn : CircleTapContext)
    {
        animate(shrinkingCircle: circle2, growingCircle1: circle1, growingCircle2: circle3, growingCircle3: circle4, contextIn: contextIn)
    }
    
    func circle3Tapped(contextIn : CircleTapContext)
    {
        animate(shrinkingCircle: circle3, growingCircle1: circle1, growingCircle2: circle2, growingCircle3: circle4, contextIn: contextIn)
    }
    
    func circle4Tapped(contextIn : CircleTapContext)
    {
        animate(shrinkingCircle: circle4, growingCircle1: circle1, growingCircle2: circle2, growingCircle3: circle3, contextIn: contextIn)
    }
    
    //shrinks the circle tapped, grows the rest
    //updates context's state to the next state
    //
    private func animate(shrinkingCircle : Circle, growingCircle1 : Circle, growingCircle2 : Circle, growingCircle3 : Circle, contextIn : CircleTapContext)
    {
        //disable circles' interaction before animations
        disableAll()
        
        UIView.animate(withDuration: 0.3, animations:
            {
                () -> Void in
                
                //resize all circles
                shrinkingCircle.setRadius(radiusIn: self.radius * 0.6)
                growingCircle1.setRadius(radiusIn: self.radius * 1.4)
                growingCircle2.setRadius(radiusIn: self.radius * 1.4)
                growingCircle3.setRadius(radiusIn: self.radius * 1.4)
        })
        { (b) in
            
            //change context to next state
            contextIn.setToNextCircleTap()
            
            //re-enables interactions after animations complete
            self.enableAll()
        }
    }
    
    //enables and disables the circles
    //
    func disableAll()
    {
        circle1.isUserInteractionEnabled = false
        circle2.isUserInteractionEnabled = false
        circle3.isUserInteractionEnabled = false
        circle4.isUserInteractionEnabled = false
    }
    
    func enableAll()
    {
        circle1.isUserInteractionEnabled = true
        circle2.isUserInteractionEnabled = true
        circle3.isUserInteractionEnabled = true
        circle4.isUserInteractionEnabled = true
    }
}

