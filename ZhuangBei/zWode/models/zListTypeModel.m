//
//  zListTypeModel.m
//  ZhuangBei
//
//  Created by aa on 2020/5/12.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zListTypeModel.h"
#import <objc/runtime.h>

@implementation zListTypeModel

+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{
        @"name":@[@"value",@"name"],
        @"typeId":@[@"code",@"id"],
        @"select":@"checked"
    };
}

//归档时调用
-(void)encodeWithCoder:(NSCoder *)coder
{
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        NSString * key = [NSString stringWithUTF8String:name];
        //kvc 获取属性的值
        id value = [self valueForKey:key];
        //归档!!
        [coder encodeObject:value forKey:key];
    }
    free(ivars);
}


- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar * ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char * name = ivar_getName(ivar);
            NSString * key = [NSString stringWithUTF8String:name];
            //解档
            id value = [coder decodeObjectForKey:key];
            //设置到属性上面  kvc
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}


@end
