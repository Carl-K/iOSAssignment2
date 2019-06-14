//
//  CircleTapContext.swift
//  iOSAssignment2
//
//  Created by Carl on 6/5/19.
//  Copyright © 2019 Carl. All rights reserved.
//

import UIKit

/*
 the context class for the circles state pattern
 holds onto all possible states and current states
 the initial state resizes all circles upon tap
 and the current state will update to the next state
 where tapping a circle only resizes that circle,
 
 Using the state pattern because the initial state behavior
 happens only once in the beginning, gets rid of using
 if-statements to check which state we are in each time
 a tap occurs (code smell)
 */
class CircleTapContext
{
    let circles : [Circle]
    
    var current : CircleTapState
    
    let firstCircleTap : FirstCircleTapState
    let nextCircleTap : NextCircleTapState
    
    //consider making the reset feature abstract/protocol,
    //so reseting isn't forced to only be ResetButton,
    //
    let resetButton : ResetButton
    
    let radius : CGFloat
    
    init(circlesIn : [Circle], resetButtonIn : ResetButton, radiusIn : CGFloat)
    {
        circles = circlesIn
        
        //setup states
        //
        firstCircleTap = FirstCircleTapState(circlesIn: circles, radiusIn: radiusIn)
        nextCircleTap = NextCircleTapState(circlesIn: circles, radiusIn: radiusIn)
        
        resetButton = resetButtonIn
        
        //set initial start to first tap state
        //
        current = firstCircleTap
        
        radius = radiusIn
        
        //disable reset button on initial state
        //
        resetButton.isUserInteractionEnabled = false
        resetButton.isHidden = true
    }
    
    //delegate function behavior to current state, either initial tap or after initial tap
    //pass in context to update state when appropriate
    //the "request" functions in a context class that calls a state's "handle" function
    //
    func circleTapped(circleIn : Circle)
    {
        current.circleTapped(contextIn: self, circleIn: circleIn)
    }
    
    //when going back to initial state (after reset button press)
    //
    func setToFirstCircleTap()
    {
        disableAll()
        
        //animate all circles back to the initial radius
        //
        UIView.animate(withDuration: 0.3, animations:
            {
                () -> Void in
                
                for circle in self.circles
                {
                    circle.setRadius(radiusIn: self.radius)
                }
        })
        { (b) in
            
            //update current state to first tap state
            self.current = self.firstCircleTap
            
            //re-enable circles interactions once finished animating
            self.enableAll()
        }
        
        //disable reset button
        self.resetButton.isUserInteractionEnabled = false
        self.resetButton.isHidden = true
    }
    
    //called when a tap happens on the initial tap state
    //
    func setToNextCircleTap()
    {
        //enable reset button
        //
        resetButton.isUserInteractionEnabled = true
        resetButton.isHidden = false
        
        //update current state to after the initial press
        //
        current = nextCircleTap
    }
    
    //enable or disable circles' interaction (to avoid conflict when animating circle resizes)
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
