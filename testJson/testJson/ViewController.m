//
//  ViewController.m
//  testJson
//
//  Created by 佐筱猪 on 13-11-5.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}
- (void)appendUTF8Body:(NSMutableData *)body dataString:(NSString *)dataString
{
    [body appendData:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
}

-(NSMutableData *)test :(NSMutableDictionary *)dataDictionary{
    NSMutableData *body = [NSMutableData data];    
    for (id key in dataDictionary)
    {
        NSObject *dataParam = [dataDictionary valueForKey:key];        
        
            [self appendUTF8Body:body dataString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"file\"\r\n", key]];
            [self appendUTF8Body:body dataString:@"Content-Type: content/unknown\r\nContent-Transfer-Encoding: binary\r\n\r\n"];
            [body appendData:[(NSString *)dataParam dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    return body;
}

- (IBAction)textAction:(id)sender {
//    NSURL *url=[NSURL URLWithString:@"http://192.168.1.135:8080/luntan/login"];
////    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
////    NSLog(@"%@",request);
//    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
//    [request setURL:url];
//    [request setHTTPMethod:@"post"];
////    NSString *post=[NSString stringWithFormat:@"json={'name':'admin','password':'111111','sex':'男','email':''}"];
//    NSString *post=@"username=admin&password=111111";
//    NSMutableData *dataa=
////    [[NSMutableData alloc]init];
//    [NSMutableData dataWithData:[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
//    [request setHTTPBody:dataa];
//    NSLog(@"%@",dataa);
//    [request setTimeoutInterval:60];
//    NSURLResponse *response;
//    NSLog(@"%@",request);
//    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
////    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
////        if (error) {
////            NSLog(@"Httperror:%@%d", error.localizedDescription,error.code);
////        }else{
////            NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
////            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
////            NSLog(@"HttpResponseCode:%d", responseCode);
////            NSLog(@"HttpResponseBody %@", responseString);
////        }
////    }]; 
////    
//    NSString *result=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"result:%@",result);
//    NSLog(@"response:%@",response );
    
    
    
    
    
    UIImage *image = [UIImage imageNamed:@"test.png"]; //图片名
    NSData *imageData = UIImageJPEGRepresentation(image,0.5);//压缩比例
    NSLog(@"字节数:%i",[imageData length]);
    // post url
    NSString *urlString = @"http://192.168.1.135:8080/petInfo/UploadServlet";
    //服务器地址
    // setting up the request object now
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    //
    NSString *boundary = [NSString stringWithFormat:@"1473780983146649988"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data;boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    //data
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//--------------用户名
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"用户名" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

//--------------图片
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition:form-data; name=\"userfile\"; filename=\"2.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]]; //上传上去的图片名字
//    [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"body --%@",[[NSString alloc]initWithData:body encoding:NSUTF8StringEncoding]);
    NSLog(@"--------------------------------------");
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//--------------
    [request setHTTPBody:body];
//    NSLog(@"1-body:%@",body);
    NSLog(@"2-request:%@",request);
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"3-测试输出：%@",returnString);
}
@end
