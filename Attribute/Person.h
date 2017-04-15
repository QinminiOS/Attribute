//
//  Person.h
//  Attribute
//
//  Created by fanren on 16/4/11.
//  Copyright © 2016年 Qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic,copy) NSString *name;

@property(nonatomic,assign) NSUInteger age;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age;

@end
