//
//  GYStringSectionTool.h
//  Ying2018
//
//  Created by qiugaoying on 2018/6/26.
//  Copyright © 2018年 qiugaoying. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^processLetterBlock)(NSMutableArray *letterArr,NSMutableDictionary * dataDic);

@interface GYStringSectionTool : NSObject

//对象排序
-(void)dataRankObject:(NSMutableArray *)dataArr processBlock:(processLetterBlock)letterBlock;

//字符串排序
-(void)dataRankString:(NSMutableArray *)dataArr processBlock:(processLetterBlock)letterBlock;
    
@end
