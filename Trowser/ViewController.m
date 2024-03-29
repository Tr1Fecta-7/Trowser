//
//  ViewController.m
//  Trowser
//
//  Created by Tr1Fecta on 24/08/2019.
//  Copyright © 2019 Tr1Fecta. All rights reserved.
//

#import "ViewController.h"
#import "CookiesTableViewController.h"
#import "WKRequestInfoTableViewController.h"
#import <sys/utsname.h>

@interface ViewController () <UISearchBarDelegate, WKNavigationDelegate>

@end

@implementation ViewController

#pragma mark Setup
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupToolBar];
    [self setupSearchBar];
    [self setupWebView];
    [self setupConstraints];
    
    self.cookiesArray = [NSMutableArray new];
    
    
    
    // Setup the dictionary with all the urls and shortcuts
    self.sEngineDict = @{
        @"!g" : @"https://google.com/search?q=",
        @"!ddg" : @"https://duckduckgo.com/?q=",
        @"!sp" : @"https://www.startpage.com/do/search?q=",
        @"!yt" : @"https://www.youtube.com/results?search_query=",
        @"!bing" : @"https://www.bing.com/search?q=",
        @"!yahoo" : @"https://search.yahoo.com/search?p=",
        @"!wiki" : @"https://en.wikipedia.org/wiki/?search="
    };
    
    
}



#pragma mark Setup

-(void)setupWebView {
    // Incognito Mode
    self.config = [WKWebViewConfiguration new];
    self.config.websiteDataStore = [WKWebsiteDataStore nonPersistentDataStore];
    
    // webView setup
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 714) configuration:self.config];
    self.webView.backgroundColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.96 alpha:1.0];
    
    // Allow going page back/forward
    self.webView.allowsBackForwardNavigationGestures = YES;
    self.webView.navigationDelegate = self;
    
    [self.view addSubview:self.webView];
    
}

-(void)setupSearchBar {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 44, 374, 56)];
    self.searchBar.delegate = self;
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.placeholder = @"URL or Search Query";
    self.searchBar.autocapitalizationType = NO;
    
    
    
    [self.view addSubview:self.searchBar];
}

-(void)setupToolBar {
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 828, 414, 44)];
    
    // barButtons setup
    self.backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton1.png"] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:nil action:@selector(goBack)];
    
    self.spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    self.spaceItem.width = 20;
    
    self.forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forwardButton1.png"] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:nil action:@selector(goForward)];
    
    self.addTabButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    
    NSArray* barButtons = [[NSArray alloc] initWithObjects:self.backButton, self.spaceItem, self.forwardButton, self.spaceItem, self.addTabButton, nil];
    
    [self.toolBar setItems:barButtons];
    
    [self.view addSubview:self.toolBar];
}

-(void)setupConstraints {
    
    // Turn off auto resizing, so we can set our own constraints
    [self.webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.searchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.toolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    // Make a variable out of the things for the NSDictionary
    UISearchBar* searchBar1 = self.searchBar;
    UIToolbar* toolBar1 = self.toolBar;
    WKWebView* webView1 = self.webView;
    
    
    // Make a new NSDictionary with the views of the things
    NSDictionary* views = NSDictionaryOfVariableBindings(webView1, searchBar1, toolBar1);
    
    
    // Setup searchBar Constraints
    NSArray *searchBarHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[searchBar1]-25-|" options:0 metrics:nil views:views];
     // Take a space from left side of the screen by 25 and from right side by 25
    
    // Check in if ([self ifNotchedDevice])
    NSArray *searchBarVerticalConstraints;
    
    // Setup webView Constraints
    NSArray *webViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[webView1]-0-|" options:0 metrics:nil views:views];
    // Don't take space from left/right side of screen
    
    
    NSArray *webViewVerticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-90-[webView1]-0-[toolBar1]-|" options:0 metrics:nil views:views];
    // Push from searchBar by 90 down then webView is anchored to toolBar
    
    
    // Setup toolBar constraints
    NSArray *toolBarHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[toolBar1]-2-|" options:0 metrics:nil views:views];
    // Don't take a space from left side of screen, only from the right side by 2
    
    //Check in if ([self ifNotchedDevice])
    NSArray *toolBarVerticalConstraints;
    
    
    // Check if the user is using a notched device for setting up constraints
    if ([self ifNotchedDevice]) {
        searchBarVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[searchBar1(130)]|" options:0 metrics:nil views:views]; // 130 to 100 for non notched devices
        //Push searchBar down by 130
        
        
        toolBarVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[searchBar1]-0-[toolBar1(50)]-20-|" options:0 metrics:nil views:views]; // -20- to -0- for non notched
        // Push from the searchBar to under the webView by 40, then leave a space of 20
    }
    else {
        searchBarVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[searchBar1(100)]|" options:0 metrics:nil views:views]; // 130 to 100 for non notched devices
        //Push searchBar down by 100
        
        
        toolBarVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[searchBar1]-0-[toolBar1(50)]-0-|" options:0 metrics:nil views:views]; // -20- to -0- for non notched
        // Push from the searchBar to under the webView by 40, then leave a space of 0
    }
    
    
    // Add Constraints to the view
    [self.view addConstraints:searchBarHorizontalConstraints];
    [self.view addConstraints:searchBarVerticalConstraints];
    
    [self.view addConstraints:webViewHorizontalConstraints];
    [self.view addConstraints:webViewVerticalConstraints];
    
    [self.view addConstraints:toolBarHorizontalConstraints];
    [self.view addConstraints:toolBarVerticalConstraints];

}

#pragma mark Shake Phone

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Options"
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
        
        
        UIAlertAction* showAllCookiesAction = [UIAlertAction actionWithTitle:@"Show Request Data"
            style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            
                WKRequestInfoTableViewController *reqInfoTableViewController = [WKRequestInfoTableViewController new];
                reqInfoTableViewController.cookiesArray = [self getAllCookies];
                reqInfoTableViewController.headersDictionary = self.headersDictionary;
                reqInfoTableViewController.requestInfoArray = [[NSMutableArray alloc] initWithObjects:@"Cookies", @"Headers", nil];
                
                UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
                reqInfoTableViewController.navigationItem.backBarButtonItem = backBarButtonItem;
                
            
                UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:reqInfoTableViewController];
                [self presentViewController:navController animated:YES completion:nil];
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
        [alert addAction:showAllCookiesAction];
        [alert addAction:screenshotAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}



#pragma mark SearchBar

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    if (self.customUserAgent != nil) {
        self.webView.customUserAgent = self.customUserAgent;
    }
    [self.searchBar resignFirstResponder];
    
    // Separate searchBar text by space and put them into a NSArray
    NSArray* searchTextWithEngineArray = [searchBar.text componentsSeparatedByString:@" "];
    
    // Get the searchEngine string (!<site>) and get the searchEngineURL from the dictionary
    NSString* searchEngineString = searchTextWithEngineArray[0];
    NSString* searchEngineURL = self.sEngineDict[searchEngineString];
    
    
    
    // Check if the searchEngine is in the dict
    if (searchEngineURL) {
        
        // Remove the searchEngine string from the Array and make a new Array from it
        NSArray* searchTextArray = [searchTextWithEngineArray subarrayWithRange:NSMakeRange(1, searchTextWithEngineArray.count - 1)];
        // Make a NSString from the subArray and join them with spaces
        NSString* searchTextString = [searchTextArray componentsJoinedByString:@" "];
        // Replace all spaces in the searchTextString with +'s to use in the URL
        [searchTextString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        
        // Set the requestURL with the value from dict + the searchTextString and execute the request
        self.requestURL = [NSURL URLWithString:[searchEngineURL stringByAppendingString:searchTextString]];
        [self executeRequest];
        
    }
    else {
        
        self.requestURL = [NSURL URLWithString:searchBar.text];
        if (!self.requestURL) {
            NSLog(@"INVALID LINK");
        }
        else {
            if (!self.requestURL.scheme) {
                
                // If there is no https or http in the url add http://
                self.requestURL = [NSURL URLWithString:[@"http://" stringByAppendingString:searchBar.text]];
            }
            [self executeRequest];
            
        }
    }
}

#pragma mark Other Methods

-(void)takeScreenshot {
    CGRect rect = CGRectMake(0, 100, self.webView.bounds.size.width, self.webView.bounds.size.height); // Size of webView
    UIGraphicsBeginImageContextWithOptions(rect.size, self.view.opaque, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.webView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Save image to Photo Album
    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
}

-(void)executeRequest {
    NSURLRequest* request = [NSURLRequest requestWithURL:self.requestURL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5];
    [self.webView loadRequest:request];
    [self.searchBar setText:self.webView.URL.absoluteString];
}


-(NSMutableArray *)getAllCookies {
    NSMutableArray* cookiesArray = [NSMutableArray new];
    
    WKHTTPCookieStore* cookieStore = self.webView.configuration.websiteDataStore.httpCookieStore;
    [cookieStore getAllCookies:^(NSArray<NSHTTPCookie *> * _Nonnull cookies) {
        
        for (NSHTTPCookie* cookie in cookies) {
            [cookiesArray addObject:cookie];
        }
    }];
    
    return cookiesArray;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    self.headersDictionary = ((NSHTTPURLResponse *)navigationResponse.response).allHeaderFields;
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}


-(void)setCustomUserAgent {
    // Get the clipboard and use the string from clipboard as UserAgent
    UIPasteboard* pasteBoard = [UIPasteboard generalPasteboard];
    self.customUserAgent = pasteBoard.string;
}

-(void)refreshPage {
    [self.webView reload];
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

-(NSString *)getMachineName {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

-(BOOL)ifNotchedDevice {
    NSString* deviceName = [self getMachineName];
    
    return [deviceName isEqualToString:@"iPhone10,3"] || [deviceName isEqualToString:@"iPhone10,6"] // iPhone X
    || [deviceName isEqualToString:@"iPhone11,2"] || [deviceName isEqualToString:@"iPhone11,4"] || [deviceName isEqualToString:@"iPhone11,6"]  // iPhone XS (Max)
    || [deviceName isEqualToString:@"iPhone11,8"]; // iPhone XR

    
    
}

@end
