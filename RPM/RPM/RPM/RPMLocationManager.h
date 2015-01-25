//
//  RPMLocationManager.h
//  RPM
//
//  Created by Jordan Zucker on 1/24/15.
//  Copyright (c) 2015 Jordan Zucker. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface RPMLocationManager : CLLocationManager

+ (instancetype)sharedLocationManager;

@end
