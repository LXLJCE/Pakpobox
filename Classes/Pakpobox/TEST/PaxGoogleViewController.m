//
//  PaxGoogleViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/3.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxGoogleViewController.h"


@interface PaxGoogleViewController ()<GMSAutocompleteViewControllerDelegate>

@end

@implementation PaxGoogleViewController{
    GMSPlacesClient *_placesClient;
    GMSPlacePicker *_placePicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _placesClient = [GMSPlacesClient sharedClient];
}


// Present the autocomplete view controller when the button is pressed.
- (IBAction)onLaunchClicked:(id)sender {
    GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:nil];
    _placePicker = [[GMSPlacePicker alloc] initWithConfig:config];
        
    [_placePicker pickPlaceWithCallback:^(GMSPlace *place, NSError *error) {
        if (error != nil) {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            return;
        }
        
        if (place != nil) {
            NSLog(@"Place name %@", place.name);
            NSLog(@"Place address %@", place.formattedAddress);
            NSLog(@"Place attributions %@", place.attributions.string);
        } else {
            NSLog(@"No place selected");
        }
    }];
}
@end
