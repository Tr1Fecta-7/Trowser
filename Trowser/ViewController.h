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

// Dictionary
@property NSDictionary* sEngineDict;

// UserAgent Properties
@property NSString* customUserAgent;
@property BOOL useCustomUserAgent;

// URL
@property NSURL* requestURL;

// Toolbar Buttons
@property UIBarButtonItem* backButton;
@property UIBarButtonItem* spaceItem;
@property UIBarButtonItem* forwardButton;
@property UIBarButtonItem* addTabButton;

// Cookie Array

@property (strong, nonatomic) NSMutableArray<NSHTTPCookie *>* cookiesArray;

@property (strong, nonatomic) NSDictionary* headersDictionary;

//METHODS

-(void)takeScreenshot;

-(void)refreshPage;

-(void)executeRequest;

-(NSMutableArray *)getAllCookies;

-(void)setCustomUserAgent;

-(void)pageBack;

-(void)pageForward;

-(NSString *)getMachineName;

-(BOOL)ifNotchedDevice;

// SETUP
-(void)setupSearchBar;

-(void)setupToolBar;

-(void)setupWebView;

-(void)setupConstraints;

@end
