//
//  CirclesViewController.swift
//  iOSAssignment2
//
//  Created by Carl on 6/4/19.
//  Copyright © 2019 Carl. All rights reserved.
//

import UIKit

class CirclesViewController: UIViewController
{
    var circles : [Circle] = [Circle]()
    
    var resetButton : ResetButton?
    
    //use state pattern to manage tap states
    //
    var circleTaps : CircleTapContext?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //-----
        
        //get either width or height, whichever is smaller
        let smallerSide : CGFloat = (view.bounds.width < view.bounds.height ? view.bounds.width : view.bounds.height)
        
        //set some layout guides at .25 and .75 of width and height values
        let leftHorizontalGuide : CGFloat = view.center.x - smallerSide / 4
        let rightHorizontalGuide : CGFloat = view.center.x + smallerSide / 4
        let topVerticalGuide : CGFloat = view.center.y - smallerSide / 4
        let bottomVerticalGuide : CGFloat = view.center.y + smallerSide / 4
        
        //the initial radius
        let radius : CGFloat = smallerSide / 4 - (0.11 * smallerSide)
        
        //create the four circles, centered at the layout guides built
        circles.append(Circle(center: CGPoint(x: leftHorizontalGuide, y: topVerticalGuide), radius: radius, number: "1"))
        circles.append(Circle(center: CGPoint(x: rightHorizontalGuide, y: topVerticalGuide), radius: radius, number: "2"))
        circles.append(Circle(center: CGPoint(x: leftHorizontalGuide, y: bottomVerticalGuide), radius: radius, number: "3"))
        circles.append(Circle(center: CGPoint(x: rightHorizontalGuide, y: bottomVerticalGuide), radius: radius, number: "4"))
        
        //create reset button, will be resize with layout constraints
        resetButton = ResetButton(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0))
        
        //-----
        
        //add tap gestures to circles and reset button
        //
        for circle in circles
        {
            //let circleTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.circleTapped(sender:)))
            //circle.addGestureRecognizer(circleTap)
            circle.addTarget(self, action: #selector(self.circleTapped(circleIn:)), for: .touchUpInside)
        }
        
        let resetTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.resetTapped))
        resetButton!.addGestureRecognizer(resetTap)
        
        //-----
        
        //create the circles tap state
        circleTaps = CircleTapContext(circlesIn: circles, resetButtonIn: resetButton!, radiusIn: radius)
        
        //-----
        
        //add circles and reset button to be rendered
        for circle in circles
        {
            view.addSubview(circle)
        }
        
        view.addSubview(resetButton!)
        
        //-----
        
        //layout reset button
        //
        resetButton!.translatesAutoresizingMaskIntoConstraints = false
        
        //use layout guides safe for all, including iPhone X
        //let guides : UILayoutGuide = view.safeAreaLayoutGuide
        let guides : UIView = view
        
        //if going to inset this view controller inside another view controller,
        //consider resetButton!.superview! instead of view for constraints
        //
        NSLayoutConstraint.activate(
            [
                resetButton!.bottomAnchor.constraint(equalTo: guides.bottomAnchor, constant: -60.0),
                resetButton!.topAnchor.constraint(equalTo: guides.bottomAnchor, constant: -95.0),
                resetButton!.rightAnchor.constraint(equalTo: guides.rightAnchor, constant: -110.0),
                resetButton!.leftAnchor.constraint(equalTo: guides.leftAnchor, constant: 110.0)
            ]
        )
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //functions associated to taps on circles and reset button
    //@objc to work with selectors
    //
    @objc func resetTapped()
    {
        circleTaps!.setToFirstCircleTap()
    }
    
    @objc func circleTapped(circleIn : Circle)
    {
        circleTaps!.circleTapped(circleIn: circleIn)
    }
}
