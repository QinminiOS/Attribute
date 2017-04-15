//
//  main.m
//  Attribute
//
//  Created by fanren on 16/4/11.
//  Copyright © 2016年 Qinmin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define kMaxStringLen 512

struct Vec3 {
    short point[3];
} __attribute__ ((aligned (8)));

struct Vec3Normal {
    short point[3];
};

struct Vec3AutoAlign {
    short point[3];
} __attribute__ ((aligned));

extern void MyLog(const char *tag,const char *format,...) __attribute__((format(printf,2,3)));

void MyLog(const char *tag,const char *format,...) {
    va_list ap;
    va_start(ap, format);
    
    char* pBuf = (char*)malloc(kMaxStringLen);
    if (pBuf != NULL)
    {
        vsnprintf(pBuf, kMaxStringLen, format, ap);
    }
    va_end(ap);
    
    printf("TAG:%s Message:%s",tag,pBuf);

    free(pBuf);
}

extern int square(int n) __attribute__((const));

//__attribute__((format(scanf,m,n)))

extern void exit(int) __attribute__((noreturn));
extern void abort(void) __attribute__((noreturn));

//NS_UNAVAILABLE
//
//UNAVAILABLE_ATTRIBUTE
//

WEAK_IMPORT_ATTRIBUTE
//#if defined(__GNUC__) && ((__GNUC__ >= 4) || ((__GNUC__ == 3) && (__GNUC_MINOR__ >= 1)))
//#define UNAVAILABLE_ATTRIBUTE __attribute__((unavailable))
//#else
//__attribute__((unavailable))

//__attribute__((deprecated))

//__attribute__((deprecated(s)))

//__attribute__((weak_import))

//#if __has_attribute(deprecated)
//#define DEPRECATED_ATTRIBUTE        __attribute__((deprecated))
//#if __has_feature(attribute_deprecated_with_message)
//#define DEPRECATED_MSG_ATTRIBUTE(s) __attribute__((deprecated(s)))
//#else
//#define DEPRECATED_MSG_ATTRIBUTE(s) __attribute__((deprecated))
//#endif
//#else

//__attribute__((noreturn, format(printf, 1, 2)));

//__attribute__ ((warn_unused_result));

//int  __attribute__((const)) inc(int x)
//{
//    printf("%s(%d)\n", __FUNCTION__, x);
//    return x + 1;
//}
//
//int  inc2(int x)
//{
//    printf("%s(%d)\n", __FUNCTION__, x);
//    return x + 1;
//}
//
//int main(void)
//{
//    int i, j;
//    
//    i = inc(10);
//    j = inc(10);
//    
//    printf("%d %d\n", i, j);
//    
//    i = inc2(10);
//    j = inc2(10);
//    
//    printf("%d %d\n", i, j);
//    
//    return 0;
//}

static void stringCleanUp(__strong NSString **string) {
    NSLog(@"%@", *string);
}

void testCleanUp() {
    __strong NSString *string __attribute__((cleanup(stringCleanUp))) = @"stringCleanUp";
}

static void blockCleanUp(__strong void(^ *block)()) {
    if (*block) {
        (*block)();
    }
}

void testBlockCleanUp() {
    __strong void(^block)() __attribute__((cleanup(blockCleanUp))) = ^{
        NSLog(@"block");
    };
}

static void lambdaCleanUp(void (**lambda)()) {
    if (*lambda) {
        (*lambda)();
    }
}

void testLambdaCleanUp() {
    void (*lambda)() __attribute__((cleanup(lambdaCleanUp))) = []() {
        puts("lambda");
    };
}

#define BlockCleanUp __strong void(^block)() __attribute__((cleanup(blockCleanUp))) = ^
#define LambdaCleanUp void (*lambda)() __attribute__((cleanup(lambdaCleanUp))) = []()
void testDefine() {
    BlockCleanUp {
        puts("BlockCleanUp");
    };
    
    LambdaCleanUp{
        puts("LambdaCleanUp");
    };
}

int main(int argc, char * argv[]) {
    //@autoreleasepool {
    
    //    NSLog(@"%ld %ld",sizeof(struct Vec3),sizeof(short));
    //    
    //    NSLog(@"%ld %ld",sizeof(struct Vec3Normal),sizeof(short));
    //    
    //    NSLog(@"%ld %ld",sizeof(struct Vec3AutoAlign),sizeof(short));
    //    
    //    MyLog("AppName","%s","Hello world !!!");
    //    
    //    printf("\n%d",square(1));
    //    printf("\n%d",square(2));
    //    printf("\n%d",square(3));
    
        testCleanUp();
        
        testBlockCleanUp();
        
        testLambdaCleanUp();
        
    //}
     return 0;
}
