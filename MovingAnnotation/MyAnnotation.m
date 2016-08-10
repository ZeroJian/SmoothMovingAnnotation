//
//  BKMyAnnotation.m
//	  MoveAnnotation
//
//  Created by ZeroJianMBP on 16/8/11.
//  Copyright © 2016年 ZeroJian. All rights reserved.
//

#import "MyAnnotation.h"
#import "UIImage+Image.h"
#import "LocationManager.h"



@implementation MyAnnotation
{
		NSMutableArray *locations;
		NSArray *moveArray;
		BOOL movingOver;
		NSInteger currentIndex;
		UIImage *annnationImage;
}

- (instancetype)initWithType:(MyAnnotationType)type
									coordinate:(CLLocationCoordinate2D)coordinate
											 angle:(double)angle {
  
		if (self == [super init]) {
    
				_type = type;
				_coordinate = coordinate;
				_angle = angle;
				if (type == MyAnnotationTypeCar) {
						[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifiedCurrentLocationUpdated:) name:kdidUpdateLocation object:nil];
						locations = [[NSMutableArray alloc] initWithCapacity:20];
						movingOver = YES;
				}
		}
		return self;
}

- (MKAnnotationView *)getMyAnnotationView:(MKMapView *)mapView {
  
		MKAnnotationView *annotationView = nil;
  
		switch (self.type) {
				case MyAnnotationTypeUser:
				{
						annotationView = [self setupWithView:mapView identifier:@"UserAnnotation"];
		
				}
      break;
				case MyAnnotationTypeCar:
				{
						annotationView = [self setupWithView:mapView identifier:@"CayAnnotation"];
						annnationImage = [UIImage imageNamed:@"Annotation_Car"];;
						annotationView.image = [annnationImage zj_imageRotatedByAngle:self.angle];
						self.annotationView = annotationView;
						
				}
				break;
				}
		return annotationView;
}


#pragma mark setupAnnotationView
- (MKAnnotationView *)identifierWith:(MKMapView *)mapView identifier:(NSString *)identifier
{
		return (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
}

- (MKAnnotationView *)setupWithView:(MKMapView *)mapView
												 identifier:(NSString *)identifer
{
		MKAnnotationView *myView = [self identifierWith:mapView
																				 identifier:identifer];
		if (myView == nil) {
				myView = [[MKAnnotationView alloc] initWithAnnotation:self
																							reuseIdentifier:identifer];
		}
		myView.draggable = NO;
		myView.canShowCallout = NO;
		return myView;
}

#pragma mark Notification
- (void)onNotifiedCurrentLocationUpdated:(NSNotification *)notification
{
		if (notification.object) {
				CLLocation *location = notification.object;
				[locations addObject:location];
				
				if (locations.count >= 5 && movingOver == YES) {
						moveArray = [NSArray arrayWithArray:locations];
						[locations removeAllObjects];
						NSLog(@"----- moveArrayCount: %ld",moveArray.count);
						NSLog(@"------beging moving -----");
						currentIndex = 0;
						movingOver = NO;
						[self startMoving];
				}
		}
}

- (void)startMoving
{
		NSInteger index = currentIndex % moveArray.count;
		NSLog(@"----- currentIndex : %ld",index);
		CLLocation *newLocation = moveArray[index];

		self.annotationView.image = [annnationImage zj_imageRotatedByAngle:newLocation.course];
		
		CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
		double distance = [newLocation distanceFromLocation:currentLocation];
		double speed = newLocation.speed;
		
		CLLocationCoordinate2D newCoordinate = newLocation.coordinate;
		
		[UIView animateWithDuration:distance/speed animations:^{
				self.coordinate = newCoordinate;
				currentIndex ++;
		} completion:^(BOOL finished) {
				if (currentIndex == moveArray.count - 1) {
						movingOver = YES;
						moveArray = nil;
				} else {
						[self startMoving];
				}
		}];
}


@end


