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
    func circle1Tapped(contextIn : CircleTapContext)
    func circle2Tapped(contextIn : CircleTapContext)
    func circle3Tapped(contextIn : CircleTapContext)
    func circle4Tapped(contextIn : CircleTapContext)
}

