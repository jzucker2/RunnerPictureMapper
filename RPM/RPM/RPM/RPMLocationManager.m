//
//  RPMLocationManager.m
//  RPM
//
//  Created by Jordan Zucker on 1/24/15.
//  Copyright (c) 2015 Jordan Zucker. All rights reserved.
//

#import "RPMLocationManager.h"

@interface RPMLocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation RPMLocationManager

+ (instancetype)sharedLocationManager
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (!(self = [super init]))
        return nil;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate        = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter  = kCLDistanceFilterNone;
    self.locationManager.activityType    = CLActivityTypeOther;
    
    [self _start];
//    if (self.authorizedWhenInUse ||
//        self.authorizedAlways) {
//        [self _start];
//    }
    
    return self;
}

- (void)_start {
    // Visit Monitoring
    [self.locationManager startMonitoringVisits];
    
    // SLC
    [self.locationManager startMonitoringSignificantLocationChanges];
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark Properties

- (CLLocation *)location {
    return self.locationManager.location;
}

#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    switch (error.code) {
        case kCLErrorLocationUnknown:
            NSLog(@"[LOC] Unknown Location Error: %@", error);
            break;
        case kCLErrorDenied:
            NSLog(@"[LOC] Denied: %@", error);
            break;
        case kCLErrorNetwork:
            NSLog(@"[LOC] Network Failed: %@", error);
            break;
        case kCLErrorHeadingFailure:
            NSLog(@"[LOC] Heading Failed: %@", error);
            break;
        default:
            NSLog(@"[LOC] Failed: %@", error);
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (kCLAuthorizationStatusAuthorizedAlways != status) {
        [self.locationManager stopMonitoringVisits];
        [self.locationManager stopMonitoringSignificantLocationChanges];
        return;
    }
    
    // authorized
    [self _start];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"locations is %@", locations);
}

- (void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit
{
    NSLog(@"visit is %@", visit);
}

@end
