# GYStringSectionTool
通讯录联系人按首字母分组 

### 用法 code demo ###
```
//读取通讯录
    NSArray  *contactsDicArr = [self getAllPhoneContactsDicArr];
    NSArray *contactsModelArr  = [GYContactsModel mj_objectArrayWithKeyValuesArray:contactsDicArr];
  
    //加载完成，刷新tableView
    [self allLoadingCompleted:contactsModelArr];
    
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //分组处理工具 GYStringSectionTool
        __weak typeof(self) weakSelf = self;
        GYStringSectionTool *tool = [[GYStringSectionTool alloc]init];
        [tool dataRankObject:self.datas processBlock:^(NSMutableArray *letterArr, NSMutableDictionary *dataDic) {
            
            weakSelf.headLetterArr = letterArr;
            weakSelf.dataDic = dataDic;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }];
   });
  ```
  
