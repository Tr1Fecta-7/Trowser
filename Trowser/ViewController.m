//
//  ViewController.m
//  Trowser
//
//  Created by Tr1Fecta on 24/08/2019.
//  Copyright © 2019 Tr1Fecta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UISearchBarDelegate, WKNavigationDelegate>

@end

@implementation ViewController

#pragma mark Setup
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // searchBar setup
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 44, 374, 56)];
    self.searchBar.delegate = self;
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.placeholder = @"URL or Search Query";
    self.searchBar.autocapitalizationType = NO;
    
    
    // toolBar setup
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 828, 414, 44)];
    self.toolBar.hidden = NO;
    
    
    // barButtons setup
    self.backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton.png"] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:nil action:@selector(goBack)];

    self.spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    self.spaceItem.width = 50;
    
    
    self.forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forwardButton.png"] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:nil action:@selector(goForward)];
    
    NSArray* barButtons = [[NSArray alloc] initWithObjects:self.backButton, self.spaceItem, self.forwardButton, nil];
    
    [self.toolBar setItems:barButtons];
    
    
    
    // Incognito Mode
    self.config = [WKWebViewConfiguration new];
    self.config.websiteDataStore = [WKWebsiteDataStore nonPersistentDataStore];
    
    
    // webView setup
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 100, 414, 714) configuration:self.config];
    self.webView.backgroundColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.96 alpha:1.0];
    // Allow going page back/forward
    self.webView.allowsBackForwardNavigationGestures = YES;
    self.webView.navigationDelegate = self;

    
    // add to view
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.webView];
}


#pragma mark SearchBar

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    if (self.customUserAgent != nil) {
        self.webView.customUserAgent = self.customUserAgent; 
    }

    [self.searchBar resignFirstResponder];
    NSURL* url = [NSURL URLWithString:searchBar.text];
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5];
    [self.webView loadRequest:request];
    [self.searchBar setText:self.webView.URL.absoluteString];

}


#pragma mark Shake Phone

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        
        UIAlertController* alert = [UIAlertController
        alertControllerWithTitle:@"Options"
        message:nil
        preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
            style:UIAlertActionStyleDefault
            handler:^(UIAlertAction * action) {
            }];
        
        UIAlertAction* customUserAgentAction = [UIAlertAction actionWithTitle:@"Set UserAgent"
            style:UIAlertActionStyleDefault
            handler:^(UIAlertAction * action) {
                [self setCustomUserAgent];
            }];
        
        
        UIAlertAction* screenshotAction = [UIAlertAction actionWithTitle:@"Screenshot"
            style:UIAlertActionStyleDefault
            handler:^(UIAlertAction * action) {
                [self takeScreenshot];
        }];
        
        UIAlertAction* refreshAction = [UIAlertAction actionWithTitle:@"Refresh"
            style:UIAlertActionStyleDefault
            handler:^(UIAlertAction * action) {
                [self refreshPage];
            }];
        
        
        [alert addAction:cancelAction];
        [alert addAction:refreshAction];
        [alert addAction:customUserAgentAction];
        [alert addAction:screenshotAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}



#pragma mark takeScreenshot
-(void)takeScreenshot {
    CGRect rect = CGRectMake(0, 100, 414, 762); // Size of webView
    UIGraphicsBeginImageContextWithOptions(rect.size, self.view.opaque, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.webView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Save image to Photo Album
    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
}


#pragma mark Other Methods

-(void)refreshPage {
    [self.webView reload];
}

-(void)setCustomUserAgent {
    UIPasteboard* pasteBoard = [UIPasteboard generalPasteboard];
    self.customUserAgent = pasteBoard.string;
}

-(void)pageBack {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
}

-(void)pageForward {
    if (self.webView.canGoForward) {
        [self.webView goForward];
    }
    
}

@end
