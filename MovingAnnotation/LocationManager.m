//
//  LocationManager.m
//  MoveAnnotation
//
//  Created by ZeroJianMBP on 16/8/11.
//  Copyright © 2016年 ZeroJian. All rights reserved.
//

#import "LocationManager.h"

NSString * const kdidUpdateLocation = @"didUpdateLocation";


@interface LocationManager ()<CLLocationManagerDelegate>


@end

@implementation LocationManager


+ (instancetype)shareManager
{
		static LocationManager *manager = nil;
		static dispatch_once_t onceToken;
		dispatch_once(&onceToken, ^{
				manager = [[LocationManager alloc] init];
		});
		return manager;
}

- (instancetype)init
{
		if (self == [super init]) {
				
				_locationService = [[CLLocationManager alloc] init];
				_locationService.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
				_locationService.distanceFilter = kCLDistanceFilterNone;
				_locationService.delegate = self;
				[_locationService requestWhenInUseAuthorization];
				
		}
		return self;
}

+ (instancetype)singleInstance
{
		return [self shareManager];
}

+ (void)startLocation
{
		LocationManager *shareMag = [self shareManager];
		[shareMag.locationService startUpdatingLocation];
		
		NSLog(@"----- startLocation -----");
}

+ (void)stopLocation
{
		LocationManager *shareMag = [self shareManager];
		[shareMag.locationService stopUpdatingLocation];
}

+ (CLLocation *)currentUserLocation
{
		LocationManager *shareMag = [self shareManager];
		return shareMag.locationService.location;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
		CLLocation *location = locations.firstObject;
		[[NSNotificationCenter defaultCenter] postNotificationName:kdidUpdateLocation object:location];
}



@end
