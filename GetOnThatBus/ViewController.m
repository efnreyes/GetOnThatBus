//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Efrén Reyes Torres on 8/5/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate>
@property NSArray *busStops;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
//@property MKPointAnnotation *pointAnnotation;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        CLLocationCoordinate2D coordinate;
        MKPointAnnotation *pointAnnotation;
        NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.busStops = resp[@"row"];
        NSDictionary *busStopDesc;
//        NSDictionary *busStopLoc;
//        NSDictionary *busStopDesc = [self.busStops objectAtIndex:0];
//        NSDictionary *busStopLoc = busStopDesc[@"location"];
//        NSLog(@"Bus stops: %@", busStopLoc);

        for (int i = 0; i < self.busStops.count; i++) {
            pointAnnotation = [[MKPointAnnotation alloc]init];

            busStopDesc = [self.busStops objectAtIndex:i];
//            busStopLoc = busStopDesc[@"location"];
            coordinate.latitude = [busStopDesc[@"latitude"] doubleValue];
            coordinate.longitude = [busStopDesc[@"longitude"] doubleValue];
            if (coordinate.longitude > 0){
                coordinate.longitude = coordinate.longitude *-1;
            }
            pointAnnotation.coordinate = coordinate;
            [self.mapView addAnnotation:pointAnnotation];
        }
    }];
}


@end
