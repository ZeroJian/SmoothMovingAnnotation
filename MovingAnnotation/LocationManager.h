//
//  LocationManager.h
//  MoveAnnotation
//
//  Created by ZeroJianMBP on 16/8/11.
//  Copyright © 2016年 ZeroJian. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

extern NSString * const kdidUpdateLocation;


@interface LocationManager : NSObject

@property (nonatomic, strong) CLLocationManager *locationService;

+ (instancetype)singleInstance;

+ (void)startLocation;

+ (void)stopLocation;

+ (CLLocation *)currentUserLocation;


@end
