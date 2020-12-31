//
//  MainVC.m
//  ISSLocation
//
//  Created by Hoan Tran on 12/27/20.
//

#import "MainVC.h"
#import <MapKit/MapKit.h>
#import "ISSLocationFetchService.h"
#import "ISSLocation.h"
#import "ISSLocation-Swift.h"

static NSString *issReuseIdentifier = @"ISS_PIN";

@interface MainVC () <MKMapViewDelegate>
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) MKPointAnnotation *issAnnotation;
@property (nonatomic, strong) ISSLocationFetchService *issLocationService;
@property (nonatomic, strong) UILabel *lastUpdateLabel;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ISS Location";
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bluepego.ISSLocation"];
    
    [self createMapView];
    [self createLastUpdateLabel];
    [self addISSNotation];
    [self setupLocationUpdate];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.mapView.frame = self.view.bounds;
    self.lastUpdateLabel.frame = CGRectMake(0, 50, self.view.frame.size.width, self.lastUpdateLabel.font.lineHeight);
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:issReuseIdentifier];
    if (annotationView) {
        annotationView.annotation = annotation;
    } else {
        annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:issReuseIdentifier];
        annotationView.canShowCallout = YES;
    }
    
    annotationView.image = [UIImage imageNamed:@"iss.png"];
    return annotationView;
}

#pragma mark - Helpers

- (void)createLastUpdateLabel {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"last update";
    [self.view addSubview:label];
    
    self.lastUpdateLabel = label;
}

- (void)createMapView {
    MKMapView *mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
    CLLocation *location = [[CLLocation alloc]initWithLatitude:0 longitude:0];
    MKCoordinateSpan span = MKCoordinateSpanMake(180, 360);
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
    [self.mapView setRegion:region animated:YES];
    
    self.mapView.mapType = MKMapTypeSatellite;
}

- (void)addISSNotation {
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(21.282778, -157.829444);
    
    /// ISS Annotation
    self.issAnnotation = [[MKPointAnnotation alloc]initWithCoordinate:center];
    self.issAnnotation.title = @"ISS";
    
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:self.issAnnotation reuseIdentifier:issReuseIdentifier];
    UIImage *image = [UIImage imageNamed:@"iss.png"];
    annotationView.image = image;
    [self.mapView addAnnotation:annotationView.annotation];
}

- (void)setupLocationUpdate {
    self.issLocationService = [[ISSLocationFetchService alloc]init];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                                      target:self
                                                    selector:@selector(fetchISSLocation:)
                                                    userInfo:nil
                                                     repeats:YES];
    [timer fire];
}

- (void)fetchISSLocation:(NSTimer *)timer {
    [self.issLocationService fetchISSLocation:^(ISSLocation * _Nonnull location) {
        NSLog(@"[%@] [%f, %f]", location.dateString, location.latitude, location.longitude);
        [self setCenter:location];
        [self transmitLocation:location];
    } failure:^(NSString * _Nonnull errorMessage) {
        NSLog(@"%@", errorMessage);
    }];
}

- (void)transmitLocation:(ISSLocation *)location {
    ISSPosition *position = [[ISSPosition alloc]init];
    position.timestamp = location.timestamp;
    position.latitude = location.latitude;
    position.longitude = location.longitude;
    if (position) {
        [self.userDefaults setObject:[position jsonEncode] forKey:@"POSITION"];
    }
    
    [WidgetKitHelper reloadLocationWidget];
}

- (void)setCenter:(ISSLocation *)location {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.lastUpdateLabel.text = [NSString stringWithFormat:@"%@", location.dateString];
        
        [self.mapView setCenterCoordinate:location.coordinate animated:YES];
        self.issAnnotation.coordinate = location.coordinate;
        self.issAnnotation.title = location.coordinateString;
    });
}

@end
