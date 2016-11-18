//
//  ViewController.m
//  testJS
//
//  Created by chksong on 16/11/16.
//  Copyright © 2016年 chksong company. All rights reserved.
//

#import "ViewController.h"
@import JavaScriptCore ;

@interface ViewController () <UITextFieldDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *consoleTextView;

@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (strong ,nonatomic) JSContext  *context ;
@property (nonatomic,strong) UIWebView* meWebView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    NSString *scripPath = [[NSBundle mainBundle] pathForResource:@"hello" ofType:@"js"];
//    NSString *scripString = [NSString stringWithContentsOfFile:scripPath encoding:NSUTF8StringEncoding error:nil] ;
    
//    
    /*
    NSURL *url = [NSURL URLWithString:@"http://goipc.cn/hello.js"]  ;
    
    NSString *scripString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil] ;
    //2
    self.context = [[JSContext alloc] init ];
    [self.context evaluateScript:scripString];
    
    __weak ViewController *weakSelf = self ;
    self.context[@"print"] = ^(NSString *text) {
        NSLog(@"------parm=%@" ,text);
       // text = [NSString stringWithFormat:@"%@\n" ,text] ;
        [weakSelf.consoleTextView setText:text];
    } ;
    
    
    JSValue *function = self.context[@"startGame"] ;
    [function callWithArguments:@[]];
    */
    
    if (self.meWebView == nil)
    {
        self.meWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.height )];
                          
                          }
    
    
    self.meWebView.delegate=self;
    self.meWebView.scalesPageToFit=YES;
    self.meWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    [self.view addSubview:self.meWebView];

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"www/testJQ" ofType:@"html"];
    NSString *dataContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.meWebView loadHTMLString:dataContent baseURL:[NSURL URLWithString:filePath]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    NSString *inputString = textField.text ;
    [inputString lowercaseString];
    
    
    if ([inputString isEqualToString:@"clear" ])  {
        [self.consoleTextView setText:@""] ;
    }
    
    
    
    return YES ;
}


- (void)webViewDidStartLoad:(UIWebView*)theWebView
{
    NSLog(@"Resetting plugins due to page load.");
//    CDVViewController* vc = (CDVViewController*)self.enginePlugin.viewController;
//    
//    [vc.commandQueue resetRequestId];
//    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:CDVPluginResetNotification object:self.enginePlugin.webView]];
}

/**
 Called when the webview finishes loading.  This stops the activity view.
 */
- (void)webViewDidFinishLoad:(UIWebView*)theWebView
{
    NSLog(@"Finished load of: %@", theWebView.request.URL);
//    CDVViewController* vc = (CDVViewController*)self.enginePlugin.viewController;
    
    // It's safe to release the lock even if this is just a sub-frame that's finished loading.
   // [CDVUserAgentUtil releaseLock:vc.userAgentLockToken];
    
    /*
     * Hide the Top Activity THROBBER in the Battery Bar
     */
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
//    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:CDVPageDidLoadNotification object:self.enginePlugin.webView]];
}

- (void)webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error
{
 //   CDVViewController* vc = (CDVViewController*)self.enginePlugin.viewController;
    
  //  [CDVUserAgentUtil releaseLock:vc.userAgentLockToken];
    
    NSString* message = [NSString stringWithFormat:@"Failed to load webpage with error: %@", [error localizedDescription]];
    NSLog(@"%@", message);
    
//    NSURL* errorUrl = vc.errorURL;
//    if (errorUrl) {
//        errorUrl = [NSURL URLWithString:[NSString stringWithFormat:@"?error=%@", [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] relativeToURL:errorUrl];
//        NSLog(@"%@", [errorUrl absoluteString]);
//        [theWebView loadRequest:[NSURLRequest requestWithURL:errorUrl]];
//    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL* url = [request URL];
    NSLog(@"url=%@" , url) ;
    
    
    return YES;
}
@end
