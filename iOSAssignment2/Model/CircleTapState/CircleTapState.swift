//
//  CircleTapState.swift
//  iOSAssignment2
//
//  Created by Carl on 6/5/19.
//  Copyright © 2019 Carl. All rights reserved.
//

import Foundation

//abstract state interface
//declares the state's "handle" functions
//
protocol CircleTapState
{
    func circleTapped(contextIn : CircleTapContext, circleIn : Circle)
}

