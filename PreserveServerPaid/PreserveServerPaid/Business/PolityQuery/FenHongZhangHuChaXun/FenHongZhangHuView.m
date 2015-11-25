//
//  FenHongZhangHuView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/14.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "FenHongZhangHuView.h"
#import "PreserveServer-Prefix.pch"
#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.draw.QueryDrawAccountServlet"


#define FENHONGXIANGQINGURL @"/servlet/hessian/com.cntaiping.intserv.custserv.draw.QueryDrawAccountServlet"



@implementation FenHongZhangHuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

{
    UITableView *fenHongTabV;
    int             time;
    NSMutableArray *bArray;
    FenHongZhangHuXiangQingView *dizhiBianGengView;
    NSDate          *beginDate;
    NSDate          *endDate;
    
}

+(FenHongZhangHuView *)awakeFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"FenHongZhangHuView" owner:nil options:nil] objectAtIndex:0];
}


- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
    
    
}

-(void)custemView
{
    time=20;
    self.tabArray = [[NSMutableArray alloc] init];
    bArray = [[NSMutableArray alloc] init];
    fenHongTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 844, 140) style:UITableViewStylePlain];
    [self addSubview:fenHongTabV];
    fenHongTabV.delegate = self;
    fenHongTabV.dataSource =self;
    fenHongTabV.rowHeight = 35;
    [self custemTableViewFrame];
    [self request];
    
}

-(void)request{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            NSDictionary *dic=[[TPLSessionInfo shareInstance] custmerDic];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *birthday = [dateFormatter dateFromString:[dic objectForKey:@"brithday"]];
            int gender=0;//性别，0表示女
            if ([[dic objectForKey:@"gender"] isEqualToString:@"M"]) {
                gender=1;//表示男
            }
            
            listBOModel=[remoteService queryDrawAccOrSetPolicyWithAgentId:@"123" andAccountType:1 andPolicyCode:@"13213" andRealName:[dic objectForKey:@"realName"] andGender:gender andBirthday:birthday andAuthCertiCode:[dic objectForKey:@"certiCode"] ];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>%@",listBOModel);
        [self.tabArray removeAllObjects];
        for (int i=0; i<listBOModel.objList.count; i++) {
            id<TPLPolicyBOModel>dic=[listBOModel.objList objectAtIndex:i];
            [self.tabArray addObject:dic];
        }
        bArray=[NSMutableArray arrayWithArray:self.tabArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"]) {
                //表示请求出错
                UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:[listBOModel.errorBean errorInfo] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }else{
                [fenHongTabV reloadData];
                
            }
            [self custemTableViewFrame];
        });
        
    });
    
}
-(void)custemTableViewFrame{
    if (35*self.tabArray.count>603)
    {
        fenHongTabV.frame=CGRectMake(0, 35, 844, 603);
    }else{
        fenHongTabV.frame=CGRectMake(0, 35, 844, 35*self.tabArray.count);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.tabArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FenHongZhangHuViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[FenHongZhangHuViewCell alloc] initWithFrame:CGRectMake(0, 0, 776, 35)];
    }
   
   id<TPLPolicyBOModel>dic;
    if (time==10) {
        dic=[self.tabArray objectAtIndex:indexPath.row];
    }else{
        dic=[self.tabArray objectAtIndex:(self.tabArray.count-indexPath.row-1)];
    }   

    cell.numberLabel.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.polityNumLabel.text=dic.policyCode;
    cell.typeLabel.text=dic.liabilityStatus;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    cell.timeLabel.text=[dateFormatter stringFromDate:dic.validateDate];
    cell.insureLabel.text=dic.applicantName;
    cell.insuredLabel.text=dic.insurantName;
    cell.polityNameLabel.text=dic.productName;
    
    //[cell.danxuanBtn addTarget:self action:@selector(danXuanZeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dizhiBianGengView)
    {
        [dizhiBianGengView removeFromSuperview];
    }
    
    dizhiBianGengView = [[[NSBundle mainBundle] loadNibNamed:@"FenHongZhangHuView" owner:self options:nil] objectAtIndex:2];
    dizhiBianGengView.alpha=1;
    //传过去保单号
    id<TPLPolicyBOModel>dic = [self.tabArray objectAtIndex:indexPath.row];
    dizhiBianGengView.huodeString = dic.policyCode;
    [dizhiBianGengView sizeToFit];
    dizhiBianGengView.tag=20000;
    dizhiBianGengView.frame = CGRectMake(1024, 64, 1024, 704);
    dizhiBianGengView.backgroundColor = [UIColor clearColor];
    [[self superview] addSubview:dizhiBianGengView];
    
    [UIView animateWithDuration:1 animations:^
     {
         
         dizhiBianGengView.frame = CGRectMake(0, 64, 1024, 704);
         
         
     } completion:^(BOOL finished)
     {
         
     }];

}


//点击生效日期
- (IBAction)dateBtnClick:(UIButton *)sender {
    if (sender.tag==50) {
        sender.tag=40;
        [self.timeImageV setImage:[UIImage imageNamed:@"shengxu.png"]];
        time=10;
    }else{
        sender.tag=50;
        [self.timeImageV setImage:[UIImage imageNamed:@"jiangxu.png"]];
        time=20;
    }
    [fenHongTabV reloadData];
}
//责任状态
- (IBAction)stateBtnClick:(UIButton *)sender {
    //    NSMutableArray *array=@[@"有效",@"无效",@"无"];
    //    enumView *view=[[enumView alloc] initWithFrame:CGRectMake(386, 35, 72, 100) mArray:array tag:1];
    ////    view.backgroundColor=[UIColor greenColor];
    //    [self addSubview:view];
    sender.enabled=NO;
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(302, 35, 94, 100)];
    view.layer.borderWidth=0.5;
    view.backgroundColor=[UIColor grayColor];
    [self addSubview:view];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 94, 33);
    [view addSubview:btn];
    btn.tag=7100;
    [btn setTitle:@"有效" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:btn1];
    btn1.frame=CGRectMake(0, 33, 94, 33);
    btn1.tag=7200;
    [btn1 setTitle:@"无效" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:btn2];
    btn2.frame=CGRectMake(0, 66, 94, 33);
    btn2.tag=7300;
    [btn2 setTitle:@"无" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor whiteColor]];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}



//责任状态点击
-(void)typeBtnClick:(UIButton *)sender{
    self.typeBtn.enabled=YES;
    [self.tabArray removeAllObjects];
    if (sender.tag==7100) {
        //有效
        for (int i=0; i<bArray.count; i++) {
            id<TPLPolicyBOModel>dic=[bArray objectAtIndex:i];
            if ([dic.liabilityStatus isEqualToString:@"有效"]) {
                [self.tabArray addObject:dic];
            }
        }
    }
    if (sender.tag==7200) {
        //有效
        for (int i=0; i<bArray.count; i++) {
            id<TPLPolicyBOModel>dic=[bArray objectAtIndex:i];
            if ([dic.liabilityStatus isEqualToString:@"无效"]) {
                [self.tabArray addObject:dic];
            }
        }
    }
    if (sender.tag==7300) {
        self.tabArray=[NSMutableArray arrayWithArray:bArray];
    }
    
    fenHongTabV.frame=CGRectMake(0, 35, 844, 35*self.tabArray.count);
    if (35*self.tabArray.count>603) {
        fenHongTabV.frame=CGRectMake(0, 35, 844, 603);
    }
    [fenHongTabV reloadData];
    [[sender superview] removeFromSuperview];
}


@end

@implementation FenHongZhangHuViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"FenHongZhangHuView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}


@end


@implementation FenHongZhangHuXiangQingView
{
    UITableView *fenXiangTabV;

}


+(FenHongZhangHuXiangQingView *)awakeFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"FenHongZhangHuView" owner:nil options:nil] objectAtIndex:2];
    
}

- (IBAction)yinCangBtnClick:(id)sender
{
    
    [UIView animateWithDuration:1 animations:^{
        self.frame = CGRectMake(1024, 64, 1024, 704);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    }


- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}


-(void)custemView
{
    self.xiangTabVarray = [[NSMutableArray alloc] init];
//    NSDictionary *dic1=@{@"xianZhongLabel":@"太平寿比南山附加养老两金保险（两金型）",
//                      @"fangshiLabel":@"累积生息",
//                      @"timeLabel":@"2015-09-09",
//                      @"jinE":@"0",
//                      @"xianjin":@"85.0",
//                      };
//    [self.xiangTabVarray addObject:dic1];
//    
//    NSDictionary *dic2=@{@"xianZhongLabel":@"太平寿比南山附加养老两金保险（两金型）",
//                         @"fangshiLabel":@"累积生息",
//                         @"timeLabel":@"2015-09-09",
//                         @"jinE":@"0",
//                         @"xianjin":@"385.05",
//                         };
//    [self.xiangTabVarray addObject:dic2];
//    
//    NSDictionary *dic3=@{@"xianZhongLabel":@"太平寿比南山附加养老两金保险（两金型）",
//                         @"fangshiLabel":@"累积生息",
//                         @"timeLabel":@"2015-09-09",
//                         @"jinE":@"0",
//                         @"xianjin":@"805.05",
//                         };
//    [self.xiangTabVarray addObject:dic3];
//    
//    NSDictionary *dic4=@{@"xianZhongLabel":@"太平寿比南山附加养老两金保险（两金型）",
//                         @"fangshiLabel":@"累积生息",
//                         @"timeLabel":@"2015-09-09",
//                         @"jinE":@"0",
//                         @"xianjin":@"105.05",
//                         };
//    [self.xiangTabVarray addObject:dic4];
//    
//    NSDictionary *dic5=@{@"xianZhongLabel":@"太平寿比南山附加养老两金保险（两金型）",
//                         @"fangshiLabel":@"累积生息",
//                         @"timeLabel":@"2015-09-09",
//                         @"jinE":@"0",
//                         @"xianjin":@"555.05",
//                         };
//    [self.xiangTabVarray addObject:dic5];
    
    fenXiangTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 712, 35) style:UITableViewStylePlain];
    [self.smallXiangView addSubview:fenXiangTabV];
    fenXiangTabV.rowHeight = 35;
    fenXiangTabV.delegate = self;
    fenXiangTabV.dataSource = self;
    
    [self requestDetailNumber];
}


-(void)requestDetailNumber{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,FENHONGXIANGQINGURL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            NSDictionary *dic=[[TPLSessionInfo shareInstance] custmerDic];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
           
            int gender=0;//性别，0表示女
            if ([[dic objectForKey:@"gender"] isEqualToString:@"M"]) {
                gender=1;//表示男
            }
            
            NSDate *dateNow = [NSDate date];
            NSTimeInterval secondPerDay = 7*24*60*60;
            NSDate * sevenDay = [NSDate dateWithTimeIntervalSinceNow:-secondPerDay];
            
            listBOModel=[remoteService queryDrawAccountWithAgentId:@"123" andPolicyCode:self.huodeString andStartDate:sevenDay andEndDate:dateNow ];
          
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>mmmcc>>>>>>>>>>%@",listBOModel);
        [self.xiangTabVarray removeAllObjects];
        for (int i=0; i<listBOModel.objList.count; i++) {
            id<TPLPolicyBOModel>dic=[listBOModel.objList objectAtIndex:i];
            [self.xiangTabVarray addObject:dic];
        }
        NSLog(@"  >>>>mmm%@ ",self.xiangTabVarray);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"]) {
                //表示请求出错
                UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:[listBOModel.errorBean errorInfo] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }else{
                [fenXiangTabV reloadData];
                
            }
            //[self custemTableViewFrame];
        });
        
    });
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return self.xiangTabVarray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FenHongZhangHuXiangQingViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[FenHongZhangHuXiangQingViewCell alloc] initWithFrame:CGRectMake(0, 0, 712, 35)];
    }
    
    id<TPLDrawAccountBOModel>dic = [self.xiangTabVarray objectAtIndex:indexPath.row];
    
    NSDate *timeDate=dic.realloDate ;//获取当前时间
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc]init];
    [timeFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *zongShiJianString = [timeFormat stringFromDate:timeDate];
    
    cell.xianZhongLabel.text=dic.productAbbr;
    cell.xuanZeLabel.text=dic.modeName;
    cell.fangshiLabel.text=dic.authName;
    cell.riqiLabel.text=zongShiJianString;
    cell.baoeLabel.text=dic.bonusSa;
    cell.hongLiLabel.text=dic.distriAmount;
    
    //[cell.danxuanBtn addTarget:self action:@selector(danXuanZeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}




@end


@implementation FenHongZhangHuXiangQingViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"FenHongZhangHuView" owner:nil options:nil] objectAtIndex:3];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}




@end

