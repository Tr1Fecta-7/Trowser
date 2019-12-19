//
//  CookiesTableViewController.h
//  Trowser
//
//  Created by Tr1Fecta on 27/10/2019.
//  Copyright © 2019 Tr1Fecta. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CookiesTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray<NSHTTPCookie *>* cookiesArray;

-(void)dismissVC;

@end


