//
//  GYContactsModel.h
//  Ying2018
//
//  Created by qiugaoying on 2018/6/26.
//  Copyright © 2018年 qiugaoying. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYContactsModel : NSObject

@property(nonatomic,copy) NSString *contact_id; //唯一id
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *phoneNumberStr;

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *birthTime;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *headPic;
@property (nonatomic, copy) NSString *idCard;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *realName;

@property (nonatomic, assign)NSInteger touch; //是否被选中 0 默认没有选中
@property (nonatomic, assign)NSInteger forbiddenTouch;//禁止点击 默认0 可点击



@end
