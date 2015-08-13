//
//  HotelsMapVC.m
//  Hotels
//
//  Created by Hari Prasad on 8/12/15.
//  Copyright (c) 2015 HARI PRASAD. All rights reserved.
//

#import <Mapkit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "HotelsMapVC.h"
#import "Hotel.h"
#import "HotelStore.h"
#import "HotelAnnotationView.h"

@interface HotelAnnotation : NSObject <MKAnnotation>

@property (nonatomic, strong) Hotel *hotel;
@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@end

@implementation HotelAnnotation

- (NSString *)title
{
    return self.hotel.name;
}

- (NSString *)subtitle
{
    return self.hotel.address;
}

@end

@interface HotelsMapVC ()<MKMapViewDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D currentLocationCoordinate;
@property (nonatomic, assign) BOOL foundLocation;
@property (nonatomic, strong) NSArray *hotelsArray;

@end

@implementation HotelsMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self askForCurrentLocation];
    [self fetchHotels];
}

#pragma mark - Private methods

- (void)askForCurrentLocation {
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    [self showActivityIndicator];
}

-(void)fetchHotels{
    __block typeof(self) weakself = self;
    [[HotelStore sharedStore] getHotels:^(NSArray *hotels) {
        weakself.hotelsArray = [hotels mutableCopy];
        [weakself updateMap];
    }];
}

-(void)updateMap
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.hotelsArray enumerateObjectsUsingBlock: ^(Hotel *hotel, NSUInteger idx, BOOL *stop) {
        HotelAnnotation *annotation = [HotelAnnotation new];
        annotation.coordinate = CLLocationCoordinate2DMake([hotel.latitude doubleValue], [hotel.longitude doubleValue]);
        annotation.hotel = hotel;
        [self.mapView addAnnotation:annotation];
    }];
    
    if(!self.foundLocation){
        [self setMapRegionToFirstHotelCoordinates];
    }
    
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(self.currentLocationCoordinate, 10000, 10000)];
}

//Set map region to first Hotel coordinate if you dont use location services
-(void)setMapRegionToFirstHotelCoordinates
{
    Hotel *hotel = [self.hotelsArray firstObject];
    self.currentLocationCoordinate = CLLocationCoordinate2DMake([hotel.latitude doubleValue], [hotel.longitude doubleValue]);
}

#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (self.foundLocation) {
        return;
    }
    self.foundLocation = YES;
    [manager stopUpdatingLocation];
    
    CLLocation *location = [locations lastObject];
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler: ^(NSArray *placemarks, NSError *error) {
        [self hideActivityIndicator];
        if (!error) {
            CLPlacemark *placemark = [placemarks lastObject];
            self.currentLocationCoordinate = placemark.location.coordinate;
        }else
        {
            [self setMapRegionToFirstHotelCoordinates];
        }
        [self updateMap];
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.locationManager stopUpdatingLocation];
    [self hideActivityIndicator];
}

#pragma mark - MKMapViewDelegate Methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation> )annotation
{
    if (annotation == mapView.userLocation) {
        return nil;
    }
    HotelAnnotationView *annotationView = [[HotelAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:HotelReusableMapAnnotationViewIdentifier];
    return annotationView;
}

@end
