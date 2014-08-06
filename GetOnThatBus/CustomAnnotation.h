//
//  CustomAnnotation.h
//  GetOnThatBus
//
//  Created by Efrén Reyes Torres on 8/5/14.
//  Copyright (c) 2014 Efrén Reyes Torres. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface CustomAnnotation : MKPointAnnotation
@property NSDictionary *busStopInfo;
@property UIImage *image;

@end
