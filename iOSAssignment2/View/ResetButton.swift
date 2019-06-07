//
//  ResetButton.swift
//  iOSAssignment2
//
//  Created by Carl on 6/5/19.
//  Copyright © 2019 Carl. All rights reserved.
//

import UIKit

class ResetButton : UIButton
{
    //compute 1, reuse for each button
    private static let reddish : CGColor = UIColor(red: 0.851, green: 0.498, blue: 0.502, alpha: 1.0).cgColor
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        layer.borderWidth = 2.0
        layer.cornerRadius = 10.0
        layer.borderColor = ResetButton.reddish
        
        titleLabel?.font = UIFont(name: "Helvetica", size: 24.0)
        setTitleColor(.black, for: .normal)
        setTitle("Reset", for: .normal)
        
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

