//
//  GYStringSectionTool.m
//  Ying2018
//
//  Created by qiugaoying on 2018/6/26.
//  Copyright © 2018年 qiugaoying. All rights reserved.
//

#import "GYStringSectionTool.h"
#import "GYContactsModel.h"
#import "pinyin.h"

@interface GYStringSectionTool()

@property(nonatomic,strong) NSMutableArray *headLetterArr;
@property(nonatomic,strong) NSMutableDictionary *dataDic;

@end

@implementation GYStringSectionTool

-(NSMutableArray *)headLetterArr
{
    if(!_headLetterArr){
        _headLetterArr = [[NSMutableArray alloc]init];
    }
    return  _headLetterArr;
}

-(NSMutableDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}

//排序数组对象
-(void)dataRankObject:(NSMutableArray *)dataArr processBlock:(processLetterBlock)letterBlock{
    
    for (int i=0; i< dataArr.count; i++) {
        
        GYContactsModel *model = dataArr[i];
        NSString *name = model.name;
        if(name.length == 0){
            name = model.phoneNumberStr;
        }
        
        [self HanZiFirstLetter:name object:dataArr[i]];
    }
    //按字母顺序排序
    [self.headLetterArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //把#放到最后
    if ([self.headLetterArr containsObject:@"#"]) {
        [self.headLetterArr removeObject:@"#"];
        [self.headLetterArr addObject:@"#"];
    }
    
    //block刷新
    if(letterBlock){
        letterBlock(self.headLetterArr,self.dataDic);
    }
}


-(void)dataRankString:(NSMutableArray *)dataArr processBlock:(processLetterBlock)letterBlock{
    
    for (int i=0; i< dataArr.count; i++) {
        
        NSString *name = dataArr[i];
        
        [self HanZiFirstLetter:name object:dataArr[i]];
    }
    //按字母顺序排序
    [self.headLetterArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //把#放到最后
    if ([self.headLetterArr containsObject:@"#"]) {
        [self.headLetterArr removeObject:@"#"];
        [self.headLetterArr addObject:@"#"];
    }
    
    //block刷新
    if(letterBlock){
        letterBlock(self.headLetterArr,self.dataDic);
    }
}



//根据首字母分组
- (void)HanZiFirstLetter:(NSString *)checkName object:(id)object{
    
    char lowerFirstLetter=pinyinFirstLetter([checkName characterAtIndex:0]);
    NSString *firstLetter=[[NSString stringWithFormat:@"%c",lowerFirstLetter] uppercaseString];
    
    
    //判断是不是特殊字符
    if (![self bWordNormal:firstLetter]) {
        //是特殊字符
        //判断首字母数组里面有没有@“#”，没有就添加，有就不添加
        NSString *sepStr = @"#";
        if(![self.headLetterArr containsObject:sepStr]) {
            //添加首字母数组
            [self.headLetterArr addObject:sepStr];
            //添加字典@"#"key对应的array
            NSMutableArray *arr = [NSMutableArray array];
            [arr addObject:object];
            [self.dataDic setValue:arr forKey:sepStr];
            
        }else{
            //添加字典@"#"key对应的array
            NSMutableArray *arr = [self.dataDic valueForKey:sepStr];
            [arr addObject:object];
        }
    }
    else{
        //不是特殊字符
        //判断当前字母是否在首字母数组中，如果没有就添加，有就不添加
        if (![self.headLetterArr containsObject:firstLetter]) {
            //添加首字母数组
            [self.headLetterArr addObject:firstLetter];
            //添加字典首字母key对应的array
            NSMutableArray *arr = [NSMutableArray array];
            [arr addObject:object];
            [self.dataDic setValue:arr forKey:firstLetter];
            
        }else{
            //添加字典首字母key对应的array
            NSMutableArray *arr = [self.dataDic valueForKey:firstLetter];
            [arr addObject:object];
        }
    }
}
//判断是不是字母
- (BOOL)bWordNormal:(NSString *)searchFirstWord {
    NSRange range = [searchFirstWord rangeOfString:@"^[A-Z]$" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

@end
