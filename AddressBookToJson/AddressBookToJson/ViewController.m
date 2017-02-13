//
//  ViewController.m
//  AddressBookToJson
//
//  Created by WangShuChao on 2017/2/10.
//  Copyright © 2017年 真的网络科技公司. All rights reserved.
//




#import "ViewController.h"

#define KCurrentDevice [UIDevice currentDevice].systemVersion

#if  __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0 
#import <Contacts/Contacts.h>
#else
#import <AddressBook/AddressBook.h>
#endif




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

#if  __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    CNContactStore *_addressBook;
#else
    ABAddressBookRef addressBookRef;
#endif
    
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

    
#if  __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    // 1.获取授权状态
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    // 2.判断授权状态,如果不是已经授权,则直接返回
    if (status != CNAuthorizationStatusAuthorized){
        return NO;
    }else{
        return YES;
    }
    
#else
    //这个变量用于记录授权是否成功，即用户是否允许我们访问通讯录
    BOOL __block tip = NO;
    //声明一个通讯簿的引用
    addressBookRef =nil;
    //因为在IOS6.0之后和之前的权限申请方式有所差别，这里做个判断
    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
        //创建通讯簿的引用
        addressBookRef=ABAddressBookCreateWithOptions(NULL, NULL);
        //创建一个出事信号量为0的信号
        dispatch_semaphore_t sema=dispatch_semaphore_create(0);
        //申请访问权限
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool greanted, CFErrorRef error)        {
            //greanted为YES是表示用户允许，否则为不允许
            if (greanted) {
                tip = YES;
            }
            //发送一次信号
            dispatch_semaphore_signal(sema);
        });
        //等待信号触发
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }else{
        //IOS6之前
        addressBookRef =ABAddressBookCreate();
    }
    
    return tip;
#endif
    
}

/*  通讯录联系人详细信息 */
-(NSArray *)AddressBookContactDetails{
    
    NSMutableArray *tempStore = [NSMutableArray array];
#if  __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    _addressBook = [[CNContactStore alloc]init];
    
    // 4.创建获取通信录的请求对象
    // 4.1.拿到所有打算获取的属性对应的key
    NSArray *keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    
    // 4.2.创建CNContactFetchRequest对象
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    
    // 5.遍历所有的联系人
    [_addressBook enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        // 1.获取联系人的姓名
        NSString *lastname = contact.familyName;
        NSString *firstname = contact.givenName;
        NSLog(@"%@ %@", lastname, firstname);
        
        // 2.获取联系人的电话号码
        NSArray *phoneNums = contact.phoneNumbers;
        for (CNLabeledValue *labeledValue in phoneNums) {
            // 2.1.获取电话号码的KEY
            NSString *phoneLabel = labeledValue.label;
            
            // 2.2.获取电话号码
            CNPhoneNumber *phoneNumer = labeledValue.value;
            NSString *phoneValue = phoneNumer.stringValue;
            
            NSLog(@"%@ %@", phoneLabel, phoneValue);
        }
    }];
    
    return nil;
    
#else
    
    //获取所有联系人的数组
    CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    //获取联系人总数
    CFIndex number = ABAddressBookGetPersonCount(addressBookRef);
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
    
    CFRelease(addressBookRef);
    
    NSArray *addressBookModelArray = [NSArray arrayWithArray:tempStore];
    
    return addressBookModelArray;
#endif
}

/*  将通信录信息转成json */
-(NSString *)arrayToJson:(NSArray *)array{

    NSMutableArray *list = [NSMutableArray array];
    
    for (AddressBookPeople *temp in array) {
        NSLog(@"temp.firstName >> %@",temp.lastName);
        NSLog(@"temp.phone >> %@",temp.phone);
        
        NSDictionary *dic = @{@"name":temp.lastName,@"phone":temp.phone};
        
        [list addObject:dic];
    }
    
    
    NSDictionary *dic = @{@"list":list};
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

}

#pragma mark - action
- (IBAction)addressBookToJsonAction:(id)sender {
    //获取通讯录
    NSArray *addressBookModelArray = [self acquisitionSystemAddressBook];
    //转成json
    NSString *temp = [self arrayToJson:addressBookModelArray];
    
    NSLog(@"temp : %@",temp);
}




@end
