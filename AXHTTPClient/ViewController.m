//
//  ViewController.m
//  AXHTTPClient
//
//  Created by devedbox on 16/8/19.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "ViewController.h"
#import "AXHTTPClient.h"
#import "NSError+AXHTTPClient.h"
#import <JYObjectModule/JYObjectModule.h>
#import <JYObjectModule/RLMObject+KeyValue.h>
#import "AXResponseObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"HTTP status: %@", AXHTTPStatusWithStatusCode(404));
    
    NSLog(@"URL Response status: %@", AXURLResponseStatusWithStatusCode(4001));
    
    NSDictionary *product = @{};
    NSDictionary *orderInfo = @{@"product":product, @"images":@[@{@"url":@"www.baidu.com"}], @"comments":@[@{@"content":@"测试", @"images":@[@{@"url":@"www.jiangtour.com"}]}]};
    JYPostObject *order = [JYPostObject objectWithKeyValue:orderInfo];
    
    NSLog(@"object: %@", order);
    
    NSLog(@"URLString: %@", AXHTTPClientRequestURLString(@"general/verifycode", @[@{@"userId":@"17017417041929"}, @{@"phone":@"15680002585"}, @{@"keywords":@"中国"}]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
