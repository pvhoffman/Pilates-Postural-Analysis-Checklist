//
//  PACViewAnalysisViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/11/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACViewAnalysisViewController.h"
#import "PACGlobal.h"

@interface PACViewAnalysisViewController ()

@end

@implementation PACViewAnalysisViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];

    CGRect frame = self.view.frame;
    
    self.navigationItem.title = @"Analysis";


    UIWebView* webview = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    webview.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:webview];

    NSString* fileName = pac_create_html_analysis();

    if(fileName && [fileName length]){
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:fileName]]];
    }
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}
@end
