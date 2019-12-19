//
//  HeadersTableViewController.h
//  Trowser
//
//  Created by Tr1Fecta on 19/12/2019.
//  Copyright © 2019 Tr1Fecta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadersTableViewController : UITableViewController

@property (nonatomic, strong) NSDictionary* headersDictionary;

-(void)dismissVC;

@end


