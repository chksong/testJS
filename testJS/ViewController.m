//
//  ViewController.m
//  testJS
//
//  Created by chksong on 16/11/16.
//  Copyright © 2016年 chksong company. All rights reserved.
//

#import "ViewController.h"
@import JavaScriptCore ;

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *consoleTextView;

@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (strong ,nonatomic) JSContext  *context ;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    NSString *scripPath = [[NSBundle mainBundle] pathForResource:@"hello" ofType:@"js"];
//    NSString *scripString = [NSString stringWithContentsOfFile:scripPath encoding:NSUTF8StringEncoding error:nil] ;
    
//    
    
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

@end
