//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Efrén Reyes Torres on 8/5/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "BusStopDetailViewController.h"
#import "CustomAnnotation.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate>
@property NSArray *busStops;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        CLLocationCoordinate2D coordinate;
        CustomAnnotation *pointAnnotation;
        NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.busStops = resp[@"row"];
        NSDictionary *busStopDesc;

        for (int i = 0; i < self.busStops.count; i++) {
            pointAnnotation = [[CustomAnnotation alloc]init];
            busStopDesc = [self.busStops objectAtIndex:i];
            pointAnnotation.title = busStopDesc[@"cta_stop_name"];
            pointAnnotation.subtitle = [NSString stringWithFormat:@"Route(s): %@", busStopDesc[@"routes"]];
            NSString *intermodal = [NSString stringWithFormat: @"%@", busStopDesc[@"inter_modal"]];
            if (![intermodal isEqual:@"(null)"]) {
                if ([intermodal isEqualToString:@"Metra"]) {
                    pointAnnotation.image = [UIImage imageNamed:@"metra"];
                } else if ([intermodal isEqualToString:@"Pace"]) {
                    pointAnnotation.image = [UIImage imageNamed:@"pace"];
                }
            }

            coordinate.latitude = [busStopDesc[@"latitude"] doubleValue];
            coordinate.longitude = [busStopDesc[@"longitude"] doubleValue];
            if (coordinate.longitude > 0){
                coordinate.longitude = coordinate.longitude *-1;
            }
            pointAnnotation.coordinate = coordinate;
            pointAnnotation.busStopInfo = busStopDesc;
            [self.mapView addAnnotation:pointAnnotation];
        }
        //          Autosize the map to show all the pins in it, if you want to include the user location replace the first line with these two
        //            MKMapPoint annotationPoint = MKMapPointForCoordinate(mapView.userLocation.coordinate);
        //            MKMapRect zoomRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);

        MKMapRect zoomRect = MKMapRectNull;
        for (id <MKAnnotation> annotation in self.mapView.annotations)
        {
            MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.5, 0.5);
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
        [self.mapView setVisibleMapRect:zoomRect animated:YES];
    }];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[CustomAnnotation class]]) {
        CustomAnnotation *myAnnotation = (CustomAnnotation *)annotation;
        MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
        pin.canShowCallout = YES;
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        if ([myAnnotation image] != nil) {
            pin.image = [myAnnotation image];
        }
        return pin;
    } else {
        return nil;
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    CLLocationCoordinate2D centerCoordinate = view.annotation.coordinate;
    MKCoordinateSpan coordinateSpan;
    coordinateSpan.latitudeDelta = 0.01;
    coordinateSpan.longitudeDelta = 0.01;
    MKCoordinateRegion region;
    region.center = centerCoordinate;
    region.span = coordinateSpan;

    [self.mapView setRegion:region animated:NO];
    [self performSegueWithIdentifier:@"busStopDetailSegue" sender:view];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"busStopDetailSegue"]) {
        BusStopDetailViewController *bdvc = (BusStopDetailViewController *)segue.destinationViewController;
        MKAnnotationView *view = (MKAnnotationView *) sender;
        CustomAnnotation *ca = (CustomAnnotation *)view.annotation;
        bdvc.busStopDesc = ca.busStopInfo;
    }
}

@end
