//
//  WKRequestInfoTableViewController.h
//  Trowser
//
//  Created by Tr1Fecta on 18/12/2019.
//  Copyright © 2019 Tr1Fecta. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WKRequestInfoTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray<NSString *> *requestInfoArray;

@property (strong, nonatomic) NSMutableArray<NSHTTPCookie *>* cookiesArray;

@property (nonatomic, strong) NSDictionary *headersDictionary;

-(void)dismissVC;

@end

