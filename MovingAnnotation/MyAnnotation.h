//
//  MyAnnotation.h
//  MoveAnnotation
//
//  Created by ZeroJianMBP on 16/8/11.
//  Copyright © 2016年 ZeroJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

//大头针类型
typedef NS_ENUM(NSInteger, MyAnnotationType) {
		
		MyAnnotationTypeUser = 0,
		MyAnnotationTypeCar,

};

@interface MyAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) MyAnnotationType type;
@property (nonatomic, assign) double angle;
@property (nonatomic, strong) MKAnnotationView *annotationView;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;



- (instancetype)initWithType:(MyAnnotationType)type
									coordinate:(CLLocationCoordinate2D)coordinate
											angle:(double)angle;

- (MKAnnotationView *)getMyAnnotationView:(MKMapView *)mapView;
@end

