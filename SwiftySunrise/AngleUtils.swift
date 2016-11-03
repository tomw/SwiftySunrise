//
//  SwiftySunrise.swift
//
//  Copyright (c) 2016 Tom Weightman
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

func sin(degrees: Double) -> Double {
    return __sinpi(degrees/180.0)
}

func cos(degrees: Double) -> Double {
    return __cospi(degrees/180.0)
}

func tan(degrees: Double) -> Double {
    return __tanpi(degrees/180.0)
}

func atan(degrees: Double) -> Double {
    return atan(degrees) * (180.0 / M_PI)
}

func acos(degrees: Double) -> Double {
    return acos(degrees) * (180.0 / M_PI)
}

func asin(degrees: Double) -> Double {
    return asin(degrees) * (180.0 / M_PI)
}
