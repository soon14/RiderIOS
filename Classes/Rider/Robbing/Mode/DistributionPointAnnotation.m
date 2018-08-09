//
//  DistributionPointAnnotation.m
//  RiderDemo
//
//  Created by mac on 2018/1/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "DistributionPointAnnotation.h"
#import "UIImage+Rotate.h"

@implementation DistributionPointAnnotation
@synthesize index;
@synthesize cxStr;
@synthesize buildDate;
@synthesize area;

@synthesize type = _type;
@synthesize degree = _degree;

- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview
{
    BMKAnnotationView* view = nil;
    switch (_type) {
        case 0:
        {
         
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
           
            if (view == nil) {
                view = [[BMKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"start_node"];
                view.canShowCallout = NO;
                view.image = [UIImage imageNamed:@"qu"];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
            }
            view.canShowCallout = NO;
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
           
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"end_node"];
                view.image = [UIImage imageNamed:@"song"];
                view.canShowCallout = NO;
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
            }
             view.canShowCallout = NO;
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"bus_node"];
                view.image = [UIImage imageNamed:@"icon_bus.png"];
            }
             view.userInteractionEnabled = NO;
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageNamed:@"icon_rail.png"];
            }
            view.userInteractionEnabled = NO;
        }
            break;
        case 4:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
           
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"route_node"];
            } else {
                [view setNeedsDisplay];
            }
            
//            UIImage* image = [UIImage imageNamed:@"icon_direction.png"];
             UIImage* image = [UIImage imageNamed:@""];
            view.image = [image imageRotatedByDegrees:_degree];
             view.userInteractionEnabled = NO;
        }
            break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
           
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"waypoint_node"];
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageNamed:@"icon_waypoint.png"];
            view.image = [image imageRotatedByDegrees:_degree];
             view.userInteractionEnabled = NO;
        }
            break;
            
        case 6:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"stairs_node"];
            
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"stairs_node"];
            }
            view.image = [UIImage imageNamed:@"icon_stairs.png"];
            view.userInteractionEnabled = NO;
        }
            break;
        default:
            break;
    }
    if (view) {
        view.annotation = self;
        view.canShowCallout = NO;
    }
    return view;
}

@end
