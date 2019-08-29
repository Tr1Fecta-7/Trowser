//
//  ViewController.h
//  Trowser
//
//  Created by Tr1Fecta on 24/08/2019.
//  Copyright © 2019 Tr1Fecta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ViewController : UIViewController


//PROPERTIES
@property (strong, nonatomic) IBOutlet UISearchBar* searchBar;
@property (strong, nonatomic) UIToolbar* toolBar;
@property (strong, nonatomic) WKWebView* webView;
@property WKWebViewConfiguration* config;

// UserAgent Properties
@property NSString* customUserAgent;
@property BOOL useCustomUserAgent;

// Toolbar Buttons
@property UIBarButtonItem* backButton;
@property UIBarButtonItem* spaceItem;
@property UIBarButtonItem* forwardButton;


//METHODS

-(void)takeScreenshot;

-(void)refreshPage;

-(void)setCustomUserAgent;

-(void)pageBack;

-(void)pageForward;


@end
