//
//  BusStopDetailViewController.m
//  GetOnThatBus
//
//  Created by Efrén Reyes Torres on 8/5/14.
//  Copyright (c) 2014 Efrén Reyes Torres. All rights reserved.
//

#import "BusStopDetailViewController.h"

@interface BusStopDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *routesLabel;
@property (strong, nonatomic) IBOutlet UILabel *intermodalLabel;

@end

@implementation BusStopDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [NSString stringWithFormat: @"%@", self.busStopDesc[@"cta_stop_name"]];
    self.addressLabel.text = [NSString stringWithFormat: @"%@", self.busStopDesc[@"cta_stop_name"]];
    self.routesLabel.text = [NSString stringWithFormat: @"%@", self.busStopDesc[@"routes"]];
    NSString *intermodal = [NSString stringWithFormat: @"%@", self.busStopDesc[@"inter_modal"]];
    if (![intermodal isEqual:@"(null)"]) {
        if ([intermodal isEqualToString:@"Metra"]) {
            intermodal = @"Metra commuter rail line";
        } else if ([intermodal isEqualToString:@"Pace"]) {
            intermodal = @"Pace bus system";
        }
    } else {
        intermodal = @"";
    }
    self.intermodalLabel.text = intermodal;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
