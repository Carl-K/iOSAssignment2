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
    let circles : [Circle]
    
    let radius : CGFloat
    
    init(circlesIn : [Circle], radiusIn : CGFloat)
    {
        circles = circlesIn
        
        radius = radiusIn
    }
    
    //the "handle" functions that shrink the tapped circle and grows the others
    //disables interactions while resizing to avoid issues when tapping mid-animation
    //enables them again when done
    //all switch the context's state to the "next" state
    //
    func circleTapped(contextIn : CircleTapContext, circleIn : Circle)
    {
        animate(shrinkingCircle: circleIn, contextIn: contextIn)
    }
    
    //shrinks the circle tapped, grows the rest
    //updates context's state to the next state
    //
    private func animate(shrinkingCircle : Circle, contextIn : CircleTapContext)
    {
        //disable circles' interaction before animations
        disableAll()
        
        UIView.animate(withDuration: 0.3, animations:
            {
                () -> Void in
                
                //resize all circles
                for circle in self.circles
                {
                    if circle === shrinkingCircle
                    {
                        circle.setRadius(radiusIn: self.radius * 0.6)
                    }
                    else
                    {
                        circle.setRadius(radiusIn: self.radius * 1.4)
                    }
                }
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

