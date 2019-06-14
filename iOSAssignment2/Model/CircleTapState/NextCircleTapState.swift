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
    let circles : [Circle]
    
    let radius : CGFloat
    
    init(circlesIn : [Circle], radiusIn : CGFloat)
    {
        circles = circlesIn
        
        radius = radiusIn
    }
    
    //these "handle" functions only resize the circle that is tapped
    //does not change state here
    //
    func circleTapped(contextIn : CircleTapContext, circleIn : Circle)
    {
        animate(circleIn: circleIn, contextIn: contextIn)
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
        for circle in self.circles
        {
            circle.isUserInteractionEnabled = false
        }
    }
    
    func enableAll()
    {
        for circle in self.circles
        {
            circle.isUserInteractionEnabled = true
        }
    }
}
