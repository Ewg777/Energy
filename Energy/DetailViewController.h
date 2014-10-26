//
//  DetailViewController.h
//  Energy
//
//  Created by Admin on 27/10/14.
//  Copyright (c) 2014 Ewg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

