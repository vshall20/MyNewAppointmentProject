//
//  Utility.m
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "Utility.h"

@implementation Utility

- (id) init
{
    if (!self) {
        self = [[Utility alloc]init];
    }
    return self;
}

static Utility *util = nil;

+(Utility *)sharedInstance
{
    if (!util) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            util = [[Utility alloc]init];
            [util startConnectionCheck];
        });
    }
    return util;
}

- (void) startConnectionCheck
{
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
        // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        _isNetworkConnectionAvailable = YES;
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        _isNetworkConnectionAvailable = NO;
    };
    
        // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
}



-(NSString *)baseURL
{
    return [NSString stringWithFormat:@"http://14.140.93.226/MylegalNetRemote/MyLegalNetService.svc"];
}

-(NSMutableDictionary *)fetchData:(NSString *)webMethod
{
    if (!_isNetworkConnectionAvailable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please check the network connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else {
        
        NSString *urlPath = [self baseURL];
        
        NSString *urlStringRequest = [NSString stringWithFormat:@"%@%@",urlPath,webMethod];
        
        NSLog(@"final url to connect:=%@",urlStringRequest);
        
        NSString *encodedURL = [urlStringRequest stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"encoded url:=%@",encodedURL);
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        NSHTTPURLResponse* response = [[NSHTTPURLResponse alloc] init];
        NSError* error ;
        NSData *result1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSLog(@"result1:-%@",result1);
        
        if (error) {
            
        }
        
        NSMutableDictionary *jsonObject = [self parseJsonResult:result1];
        NSLog(@"jsonObject:=%@",jsonObject);
        
        NSArray *values=[[NSArray alloc] init];
        values =[jsonObject allValues];
        NSString *tempString=[NSMutableString stringWithFormat:@"%@",[values objectAtIndex:0]];
        NSLog(@"tempstring:=%@",tempString);
        
        NSData *data=[tempString dataUsingEncoding:NSUTF8StringEncoding];
        jsonObject = [self parseJsonResult:data];
        NSLog(@"json parsed Object 2nd:=%@",jsonObject);
        return jsonObject;
    }
    return nil;
}

- (id)parseJsonResult:(NSData *)result
{
    if( ! result)
        return nil;
    NSError *error = nil;
    
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData: result options: NSJSONReadingMutableContainers error: &error];
    
    NSLog(@"dict : %@",dict);
    
    if (error)
    {
        NSLog(@"Error parsing JSON: %@", error);
        return nil;
    }
    return dict;
}


@end
