//
//  ViewController.m
//  AddressBookToJson
//
//  Created by WangShuChao on 2017/2/10.
//  Copyright © 2017年 真的网络科技公司. All rights reserved.
//

#import "ViewController.h"
#import <AddressBook/AddressBook.h>


@interface AddressBookPeople : NSObject

@property(nonatomic, copy)NSString *firstName;
@property(nonatomic, copy)NSString *lastName;
@property(nonatomic, copy)NSString *nickName;
@property(nonatomic, copy)NSString *firstNamePhoneic;
@property(nonatomic, copy)NSString *phone;
@end

@implementation AddressBookPeople



@end




@interface ViewController (){

    ABAddressBookRef *_addressBookRef;
}

- (IBAction)addressBookToJsonAction:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - methods

/*  获取系统通讯录 */
-(NSArray *)acquisitionSystemAddressBook{
    //权限注册
    BOOL flag = [self permissionRegister];
    if (flag == YES) {
        //通讯录联系人详细信息
        NSArray *addressBookModelArray = [self AddressBookContactDetails];
        if (addressBookModelArray == nil || addressBookModelArray.count == 0) {
            return nil;
        }else{
            return addressBookModelArray;
        }
    }else{
        return nil;
    }
}

/*  权限注册 */
-(BOOL)permissionRegister{

    //这个变量用于记录授权是否成功，即用户是否允许我们访问通讯录
    BOOL __block tip = NO;
    //声明一个通讯簿的引用
    ABAddressBookRef addBook =nil;
    //因为在IOS6.0之后和之前的权限申请方式有所差别，这里做个判断
    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
        //创建通讯簿的引用
        addBook=ABAddressBookCreateWithOptions(NULL, NULL);
        //创建一个出事信号量为0的信号
        dispatch_semaphore_t sema=dispatch_semaphore_create(0);
        //申请访问权限
        ABAddressBookRequestAccessWithCompletion(addBook, ^(bool greanted, CFErrorRef error)        {
            //greanted为YES是表示用户允许，否则为不允许
            if (!greanted) {
                tip = YES;
            }
            //发送一次信号
            dispatch_semaphore_signal(sema);
        });
        //等待信号触发
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }else{
        //IOS6之前
        addBook =ABAddressBookCreate();
    }
    
    _addressBookRef = &addBook;
   
    return tip;
}

/*  通讯录联系人详细信息 */
-(NSArray *)AddressBookContactDetails{
    
    ABAddressBookRef addBook = &_addressBookRef;
    
    NSMutableArray *tempStore = [NSMutableArray array];
    

    //获取所有联系人的数组
    CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addBook);
    //获取联系人总数
    CFIndex number = ABAddressBookGetPersonCount(addBook);
    //进行遍历
    for (NSInteger i=0; i<number; i++) {
        
        @autoreleasepool {
            AddressBookPeople *addPeople = [[AddressBookPeople alloc]init];
            
            //获取联系人对象的引用
            ABRecordRef  people = CFArrayGetValueAtIndex(allLinkPeople, i);
            //获取当前联系人名字
            NSString*firstName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
            //获取当前联系人姓氏
            NSString*lastName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonLastNameProperty));
            //获取当前联系人的昵称
            NSString*nickName=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonNicknameProperty));
            //获取当前联系人的名字拼音
            NSString*firstNamePhoneic=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonFirstNamePhoneticProperty));
            
            //获取当前联系人的电话 数组
            NSMutableArray * phoneArr = [[NSMutableArray alloc]init];
            ABMultiValueRef phones= ABRecordCopyValue(people, kABPersonPhoneProperty);
            for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++) {
                [phoneArr addObject:(__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j))];
            }
            addPeople.firstName = firstName;
            addPeople.lastName = lastName;
            addPeople.nickName = nickName;
            addPeople.firstNamePhoneic = firstNamePhoneic;
            /*  我这里的需求就是要第一个电话 */
            addPeople.phone = [phoneArr firstObject];
            
            [tempStore addObject:addPeople];
        }
    }
    
    CFRelease(addBook);
    
    NSArray *addressBookModelArray = [NSArray arrayWithArray:tempStore];
    
    return addressBookModelArray;
}

/*  将通信录信息转成json */
-(NSString *)arrayToJson:(NSArray *)array{

    return nil;
}

#pragma mark - action
- (IBAction)addressBookToJsonAction:(id)sender {
    //获取通讯录
    NSArray *addressBookModelArray = [self acquisitionSystemAddressBook];
    //转成json
    [self arrayToJson:addressBookModelArray];
}




@end
