//
//  ViewController.m
//  MovingAnnotation
//
//  Created by ZeroJianMBP on 16/8/11.
//  Copyright © 2016年 ZeroJian. All rights reserved.
//

#import "ViewController.h"
#import "LocationManager.h"
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface ViewController ()<MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, assign) BOOL hasAnnotation;
@end

@implementation ViewController
- (IBAction)showLocation:(UIBarButtonItem *)sender {
		
		CLLocation *currentLocation = [LocationManager currentUserLocation];
		[self.mapView setCenterCoordinate:currentLocation.coordinate animated:YES];
		MKCoordinateSpan span = {0.04,0.04};
		MKCoordinateRegion region = {currentLocation.coordinate,span};
		[self.mapView setRegion:region animated:YES];
		if (!self.hasAnnotation) {
				[self addAnnotation];
		}
}

- (void)viewDidLoad {
		[super viewDidLoad];
		[LocationManager startLocation];
		self.mapView = [[MKMapView alloc] init];
		self.mapView.frame = self.view.bounds;
		self.view = self.mapView;
		self.mapView.delegate = self;
}

- (void)addAnnotation
{
		
		CLLocation *currentLocation = [LocationManager currentUserLocation];
		if (currentLocation != nil) {
				self.hasAnnotation = YES;
				MyAnnotation *item = [[MyAnnotation alloc] initWithType:(MyAnnotationTypeCar)
																										 coordinate:currentLocation.coordinate
																													angle:currentLocation.course];
				[self.mapView addAnnotation:item];
		}
		
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
		if ([annotation isKindOfClass:[MyAnnotation class]]) {
				return [(MyAnnotation *)annotation getMyAnnotationView:mapView];
		}
		return nil;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
