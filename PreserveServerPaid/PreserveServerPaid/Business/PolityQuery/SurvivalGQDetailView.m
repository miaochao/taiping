//
//  SurvivalGQDetailView.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/25.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "SurvivalGQDetailView.h"
#import "PreserveServer-Prefix.pch"
#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.draw.QueryDrawAccountServlet"
@implementation SurvivalGQDetailView
{
    UITableView     *tableV;
    NSMutableArray  *mArray;//接收数据
}
+(UIView*)awakeFromNib{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"SurvivalGQDetailView" owner:self options:nil];
    
    
    return [array lastObject];
}
-(void)sizeToFit{
    [super sizeToFit];
    [self custem];
    [self request];
}
-(void)request{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            listBOModel=[remoteService querySurvivalPolicyListWithpolityCode:self.pilityCode ];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>%@",listBOModel);
        [mArray removeAllObjects];
        for (int i=0; i<listBOModel.objList.count; i++) {
            [mArray addObject:[listBOModel.objList objectAtIndex:i]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"]) {
                //表示请求出错
                UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:[listBOModel.errorBean errorInfo] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }else{
                [tableV reloadData];
                
            }
            [self custemTableViewFrame];
        });
        
    });
    
}

-(void)custem{
    //self.backBtn.backgroundColor=[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:0.9];
    mArray=[[NSMutableArray alloc] init];
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 35, 711, 0)];
    [self.rightView addSubview:tableV];
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.rowHeight=35;
}
-(void)custemTableViewFrame{
    if (mArray.count<16) {
        tableV.frame=CGRectMake(50, 78, 844, mArray.count*35);
    }else{
        tableV.frame=CGRectMake(50, 78, 844, 35*15);
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SurvivalGQDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[SurvivalGQDetailCell alloc] initWithFrame:CGRectMake(0, 0, 711, 35)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic=[mArray objectAtIndex:indexPath.row];
    cell.productNameL.text=[dic objectForKey:@"productNameL"];
    cell.liabNameL.text=[dic objectForKey:@"liabNameL"];
    cell.authNameL.text=[dic objectForKey:@"authNameL"];
    cell.feeAmountL.text=[dic objectForKey:@"feeAmountL"];
    
    cell.distributeDateL.text=[self stringFromeDate:[dic objectForKey:@"distributeDateL"]];
    cell.isDrawL.text=[dic objectForKey:@"isDrawL"];
    cell.drawDateL.text=[self stringFromeDate:[dic objectForKey:@"drawDateL"]];
    return cell;
}
-(NSString *)stringFromeDate:(NSDate *)date{
    //实例化一个NSDateFormatter对象
    
　　NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

　　//设定时间格式,这里可以设置成自己需要的格式

　　[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

　　//用[NSDate date]可以获取系统当前时间
    
    NSString *currentDateStr = [[dateFormatter stringFromDate:[NSDate date]] substringToIndex:10];
    return currentDateStr;
}
- (IBAction)backBtnClick:(UIButton *)sender {
    [self removeFromSuperview];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

#pragma mark SurvivalGQDetailCell

@implementation SurvivalGQDetailCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"SurvivalGQDetailView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end