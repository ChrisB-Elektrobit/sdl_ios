//
//  SDLTouchManagerSpec.m
//  SmartDeviceLink-iOS
//
//  Created by Muller, Alexander (A.) on 6/17/16.
//  Copyright © 2016 smartdevicelink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLTouchManager.h"
#import "CGPoint_Util.h"
#import "SDLTouch.h"

QuickSpecBegin(SDLTouchManagerSpec)

describe(@"CGPoint_Util Tests", ^{
    __block CGPoint first;
    __block CGPoint second;
    context(@"For two positive points", ^{
        beforeEach(^{
            first = CGPointMake(100, 200);
            second = CGPointMake(300, 400);
        });
        
        it(@"should properly calculate the average between points", ^{
            CGPoint average = CGPointAverageOfPoints(first, second);
            expect(@(average.x)).to(equal(@200));
            expect(@(average.y)).to(equal(@300));
        });
        it(@"should properly calculate the center between points", ^{
            CGPoint center = CGPointCenterOfPoints(first, second);
            expect(@(center.x)).to(equal(@200));
            expect(@(center.y)).to(equal(@300));
        });
        it(@"should properly calculate the displacement between points", ^{
            CGPoint displacement = CGPointDisplacementOfPoints(first, second);
            expect(@(displacement.x)).to(equal(@(-200)));
            expect(@(displacement.y)).to(equal(@(-200)));
        });
        it(@"should properly calculate the distance between points", ^{
            CGFloat distance = CGPointDistanceBetweenPoints(first, second);
            expect(@(distance)).to(beCloseTo(@282.8427).within(0.0001));
        });
    });
    context(@"For two negative points", ^{
        beforeEach(^{
            first = CGPointMake(-100, -200);
            second = CGPointMake(-300, -400);
        });
        
        it(@"should properly calculate the average between points", ^{
            CGPoint average = CGPointAverageOfPoints(first, second);
            expect(@(average.x)).to(equal(@(-200)));
            expect(@(average.y)).to(equal(@(-300)));
        });
        it(@"should properly calculate the center between points", ^{
            CGPoint center = CGPointCenterOfPoints(first, second);
            expect(@(center.x)).to(equal(@(-200)));
            expect(@(center.y)).to(equal(@(-300)));
        });
        it(@"should properly calculate the displacement between points", ^{
            CGPoint displacement = CGPointDisplacementOfPoints(first, second);
            expect(@(displacement.x)).to(equal(@200));
            expect(@(displacement.y)).to(equal(@200));
        });
        it(@"should properly calculate the distance between points", ^{
            CGFloat distance = CGPointDistanceBetweenPoints(first, second);
            expect(@(distance)).to(beCloseTo(@282.8427).within(0.0001));
        });
    });
    context(@"For one positive and one negative point", ^{
        beforeEach(^{
            first = CGPointMake(100, 200);
            second = CGPointMake(-300, -400);
        });
        
        it(@"should properly calculate the average between points", ^{
            CGPoint average = CGPointAverageOfPoints(first, second);
            expect(@(average.x)).to(equal(@(-100)));
            expect(@(average.y)).to(equal(@(-100)));
        });
        it(@"should properly calculate the center between points", ^{
            CGPoint center = CGPointCenterOfPoints(first, second);
            expect(@(center.x)).to(equal(@(-100)));
            expect(@(center.y)).to(equal(@(-100)));
        });
        it(@"should properly calculate the displacement between points", ^{
            CGPoint displacement = CGPointDisplacementOfPoints(first, second);
            expect(@(displacement.x)).to(equal(@400));
            expect(@(displacement.y)).to(equal(@600));
        });
        it(@"should properly calculate the distance between points", ^{
            CGFloat distance = CGPointDistanceBetweenPoints(first, second);
            expect(@(distance)).to(beCloseTo(@721.1103).within(0.0001));
        });
    });
});

describe(@"SDLTouch Tests", ^{
    context(@"SDLTouchZero", ^{
        __block SDLTouch touch = SDLTouchZero;
        
        it(@"should correctly initialize", ^{
            expect(@(touch.identifier)).to(equal(@(-1)));
            expect(@(CGPointEqualToPoint(touch.location, CGPointZero))).to(beTruthy());
            expect(@(touch.timeStamp)).to(equal(@0));
        });
        
        it(@"should not be a valid SDLTouch", ^{
            expect(@(SDLTouchIsValid(touch))).to(beFalsy());
        });
        
        it(@"should not equal First Finger Identifier", ^{
            expect(@(SDLTouchIsFirstFinger(touch))).to(beFalsy());
        });
        
        it(@"should not equal Second Finger Identifier", ^{
            expect(@(SDLTouchIsSecondFinger(touch))).to(beFalsy());
        });
    });
    
    context(@"For First Finger Identifiers", ^{
        __block unsigned long timeStamp = [[NSDate date] timeIntervalSince1970] * 1000;
        __block SDLTouch touch;
        
        beforeSuite(^{
            touch = SDLTouchMake(0, 100, 200, timeStamp);
        });
        
        it(@"should correctly make a SDLTouch struct", ^{
            expect(@(touch.identifier)).to(equal(@(SDLTouchIdentifierFirstFinger)));
            expect(@(touch.location.x)).to(equal(@100));
            expect(@(touch.location.y)).to(equal(@200));
            expect(@(touch.timeStamp)).to(equal(@(timeStamp)));
        });
        
        it(@"should be a valid SDLTouch", ^{
            expect(@(SDLTouchIsValid(touch))).to(beTruthy());
        });
        
        it(@"should equal First Finger Identifier", ^{
            expect(@(SDLTouchIsFirstFinger(touch))).to(beTruthy());
        });
        
        it(@"should not equal Second Finger Identifier", ^{
            expect(@(SDLTouchIsSecondFinger(touch))).to(beFalsy());
        });
    });
    
    context(@"For Second Finger Identifiers", ^{
        __block unsigned long timeStamp = [[NSDate date] timeIntervalSince1970] * 1000;
        __block SDLTouch touch;
        
        beforeSuite(^{
            touch = SDLTouchMake(1, 100, 200, timeStamp);
        });
        
        it(@"should correctly make a SDLTouch struct", ^{
            expect(@(touch.identifier)).to(equal(@(SDLTouchIdentifierSecondFinger)));
            expect(@(touch.location.x)).to(equal(@100));
            expect(@(touch.location.y)).to(equal(@200));
            expect(@(touch.timeStamp)).to(equal(@(timeStamp)));
        });
        
        it(@"should be a valid SDLTouch", ^{
            expect(@(SDLTouchIsValid(touch))).to(beTruthy());
        });
        
        it(@"should equal First Finger Identifier", ^{
            expect(@(SDLTouchIsFirstFinger(touch))).to(beFalsy());
        });
        
        it(@"should not equal Second Finger Identifier", ^{
            expect(@(SDLTouchIsSecondFinger(touch))).to(beTruthy());
        });
    });
});

QuickSpecEnd