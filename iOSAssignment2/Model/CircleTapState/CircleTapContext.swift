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
    let circle1 : Circle
    let circle2 : Circle
    let circle3 : Circle
    let circle4 : Circle
    
    var current : CircleTapState
    
    let firstCircleTap : FirstCircleTapState
    let nextCircleTap : NextCircleTapState
    
    //consider making the reset feature abstract/protocol,
    //so reseting isn't forced to only be ResetButton,
    //
    let resetButton : ResetButton
    
    let radius : CGFloat
    
    init(circle1In : Circle, circle2In : Circle, circle3In : Circle, circle4In : Circle, resetButtonIn : ResetButton, radiusIn : CGFloat)
    {
        circle1 = circle1In
        circle2 = circle2In
        circle3 = circle3In
        circle4 = circle4In
        
        //setup states
        //
        firstCircleTap = FirstCircleTapState(circle1In: circle1, circle2In: circle2, circle3In: circle3, circle4In: circle4, radiusIn: radiusIn)
        nextCircleTap = NextCircleTapState(circle1In: circle1, circle2In: circle2, circle3In: circle3, circle4In: circle4, radiusIn: radiusIn)
        
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
    func circle1Tapped()
    {
        current.circle1Tapped(contextIn: self)
    }
    
    func circle2Tapped()
    {
        current.circle2Tapped(contextIn: self)
    }
    
    func circle3Tapped()
    {
        current.circle3Tapped(contextIn: self)
    }
    
    func circle4Tapped()
    {
        current.circle4Tapped(contextIn: self)
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
                
                self.circle1.setRadius(radiusIn: self.radius)
                self.circle2.setRadius(radiusIn: self.radius)
                self.circle3.setRadius(radiusIn: self.radius)
                self.circle4.setRadius(radiusIn: self.radius)
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

