//
//  ViewController.m
//  GET_UUID
//
//  Created by yachaocn on 15/12/25.
//  Copyright © 2015年 NavchinaMacBook. All rights reserved.
//

#import "ViewController.h"
#import "KeychainItemWrapper.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *uuid;
@property (weak, nonatomic) IBOutlet UIButton *save;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //从Keychain中取出deviceCode(设备的唯一标示码)
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithAccount:@"Identfier" service:@"AppName" accessGroup:nil];
    NSString *string = [keychainItem objectForKey: (__bridge id)kSecAttrGeneric];
    if([string isEqualToString:@""] || !string){
//        如果不存在就创建uuid，并存处在keychain中
        CFUUIDRef uuidRef = CFUUIDCreate
        (kCFAllocatorDefault);
        string =  (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        //保存数据
        [keychainItem setObject:string forKey:(__bridge id)kSecAttrGeneric];
    }
   
//    从keychain中读取uuid
    KeychainItemWrapper *keychainItemm = [[KeychainItemWrapper alloc] initWithAccount:@"Identfier" service:@"AppName" accessGroup:nil];
   NSString *deviceCode = [keychainItemm objectForKey: (__bridge id)kSecAttrGeneric];
    self.uuid.text = deviceCode;
    

}
//保存按钮点击后复制到粘贴板
- (IBAction)saveLabelText:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.uuid.text];
    if (pasteboard.string != nil) {
//        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"提示" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];

        UIAlertController  *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"复制成功！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
