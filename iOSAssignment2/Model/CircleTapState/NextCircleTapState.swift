//
//  NextCircleTapState.swift
//  iOSAssignment2
//
//  Created by Carl on 6/5/19.
//  Copyright © 2019 Carl. All rights reserved.
//

import UIKit

//the state that is transitioned to after the initial state
//tapping a circle will only resize that circle
//this state does not alter the context,
//but tapping the reset button sets the context back to the initial state
//
class NextCircleTapState : CircleTapState
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
    
    //these "handle" functions only resize the circle that is tapped
    //does not change state here
    //
    func circle1Tapped(contextIn : CircleTapContext)
    {
        animate(circleIn: circle1, contextIn: contextIn)
    }
    
    func circle2Tapped(contextIn : CircleTapContext)
    {
        animate(circleIn: circle2, contextIn: contextIn)
    }
    
    func circle3Tapped(contextIn : CircleTapContext)
    {
        animate(circleIn: circle3, contextIn: contextIn)
    }
    
    func circle4Tapped(contextIn : CircleTapContext)
    {
        animate(circleIn: circle4, contextIn: contextIn)
    }
    
    //resizes the circle tapped, makes it either bigger or smaller
    //context not used
    //
    private func animate(circleIn : Circle, contextIn: CircleTapContext)
    {
        //disable circle's interaction before animations
        disableAll()
        
        var newRadius : CGFloat
        
        //determine whether to shrink or grow circle
        if (circleIn.getRadius() < radius)
        {
            newRadius = radius * 1.4
        }
        else
        {
            newRadius = radius * 0.6
        }
        
        //resize circle
        UIView.animate(withDuration: 0.3, animations:
            {
                () -> Void in
                
                circleIn.setRadius(radiusIn: newRadius)
        })
        { (b) in
            
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
