//
//  ShouFeiDiZhiBianGengView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/13.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "ShouFeiDiZhiBianGengView.h"
#import "ThreeViewController.h"
#import "PreserveServer-Prefix.pch"

#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.QueryPreserveServlet"
#define CHANGEURL @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.UpdatePreserveServlet"
@implementation ShouFeiDiZhiBianGengView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

{
    ShouFeiDiZhiXiangQingView *dizhiBianGengView;

}

+(ShouFeiDiZhiBianGengView *)awakeFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ShouFeiDiZhiBianGengView" owner:nil options:nil] objectAtIndex:0];
    
}
- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}


-(void)custemView
{
    //tableView.separatorStyle = UITableViewCellSelectionStyleNone
    self.diZhiTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 776, 108)];
    //self.diZhiTabV.backgroundColor = [UIColor redColor];
    self.diZhiTabV.rowHeight = 35;
    [self addSubview:self.diZhiTabV];
    self.diZhiTabV.dataSource = self;
    self.diZhiTabV.delegate = self;
  
    // [self.baoDanNianTabV registerClass:[BaoDanNianDuViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tabvArray = [[NSMutableArray alloc] init];
    [self custemTableViewFrame];
    [self request];
}

-(void)request{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,URL]];
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
            listBOModel=[remoteService queryChargeLocationWithAgentId:@"" andPolicyCode:@"1212" andRealName:[dic objectForKey:@"realName"] andGender:gender andBirthday:birthday andAuthCertiCode:[dic objectForKey:@"certiCode"] ];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>999>>>>%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++) {
            id<TPLChargeFeeAddrBOModel>dic=[listBOModel.objList objectAtIndex:i];
            [self.tabvArray addObject:dic];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"]) {
                //表示请求出错
                UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:[listBOModel.errorBean errorInfo] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }else{
                [self.diZhiTabV reloadData];
                
            }
            [self custemTableViewFrame];
        });
        
    });
    
}

-(void)custemTableViewFrame{
    if (self.tabvArray.count<10) {
        self.diZhiTabV.frame=CGRectMake(0, 36, 776, self.tabvArray.count*35);
    }else{
        self.diZhiTabV.frame=CGRectMake(0, 36, 776, 36*9);
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.tabvArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShouFeiDiZhiBianGengViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[ShouFeiDiZhiBianGengViewCell alloc] initWithFrame:CGRectMake(0, 0, 776, 35)];
    }
    id<TPLChargeFeeAddrBOModel>dic = [self.tabvArray objectAtIndex:indexPath.row];
    cell.numberLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.danhaoLabel.text = dic.policyCode;
   
    cell.baorenLabel.text = dic.addressFee;
    cell.zhuangtaiLabel.text = dic.zipLink;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:( NSIndexPath *)indexPath
{
    id<TPLChargeFeeAddrBOModel>dic = [self.tabvArray objectAtIndex:indexPath.row];
    if (dizhiBianGengView)
    {
        [dizhiBianGengView removeFromSuperview];
    }
    
    dizhiBianGengView = [[[NSBundle mainBundle] loadNibNamed:@"ShouFeiDiZhiBianGengView" owner:self options:nil] objectAtIndex:2];
    dizhiBianGengView.alpha=1;
    dizhiBianGengView.address=dic.addressFee;
    dizhiBianGengView.postcode=dic.zipLink;
    dizhiBianGengView.polityCode=dic.policyCode;
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
         nil;
     }];
    
}

@end


@implementation ShouFeiDiZhiBianGengViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ShouFeiDiZhiBianGengView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}



@end



@implementation ShouFeiDiZhiXiangQingView

{

   BjcaInterfaceView *mypackage;//CA拍照
}


+(ShouFeiDiZhiXiangQingView *)awakeFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ShouFeiDiZhiBianGengView" owner:nil options:nil] objectAtIndex:2];
    
}


- (void)sizeToFit
{
    [super sizeToFit];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
    [self custemView];
}


-(void)custemView
{
    self.diZhiTf.frame = CGRectMake(200, 84, 450, 39);
    self.diZhiTf.text = @"xxxx区xxxx镇xxxx路xxxx号";
    self.youBianTf.frame = CGRectMake(200, 163, 450, 39);
    self.youBianTf.text = @"5624565";
    self.diZhiTf.borderStyle = UITextBorderStyleNone;
    self.diZhiTf.layer.borderWidth = 1;
    self.diZhiTf.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.youBianTf.borderStyle = UITextBorderStyleNone;
    self.youBianTf.layer.borderWidth = 1;
    self.youBianTf.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    
    self.bianGengView.layer.borderWidth = 1;
    self.bianGengView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    
    self.diZhiTf.text=self.address;
    self.youBianTf.text=self.postcode;
   
    self.xiangQingLabel.text= [NSString stringWithFormat:@"保单号：%@",self.polityCode];
}

-(void)massageTest{
//    WriteNameView  *view=[[WriteNameView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
//    view.delegate=self;
//    [[self superview] addSubview:view];
    [mypackage reset];//先清空之前的数据
    [self startinterface];
    
}
-(void)writeNameEnd{
    BaoQuanPiWenView *view=(BaoQuanPiWenView *)[BaoQuanPiWenView awakeFromNib];
    //    view.frame
    [[self superview] addSubview:view];
    self.alpha=0;
}

//签名方法
- (void)startinterface{
    ThreeViewController *three=[ThreeViewController sharedManager];
    NSLog(@"startinterface")  ;
    signinfo info;
    // [self SetSignData:index];
    info= [self SetSignData:1 info:&info];
    //  NSLog(@"8888%@",info);
    NSString *strContextid=@"21";
    int CLS;
    @try
    {
        CLS=[strContextid intValue];
    }
    @catch (NSException *exception) {
        return  ;
    }
    info.imgeInfo.Signrect=[UIScreen mainScreen].bounds;
    // info.geo=TRUE;
    bool res= [mypackage showInputDialog:CLS callBack:@"myPicture" signerInfo:info];
    if (res==TRUE) {
        [three.view addSubview:mypackage.view];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"签名参数配置错误" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }
    
}
- (signinfo )SetSignData:(int)index info:(signinfo *)infodata{
    NSLog(@"SetSignData");
    
    signinfo info=*infodata;
    
    info.name=@"123565";//签名者名字
    info.IdNumber=@"13245678";//签名者证件号
    //info.cid=@"20";
    info.RuleType=@"2";
    info.Tid=@"12332";
    NSString *geoStr=@"true";
    if( [geoStr isEqualToString:@"true"])
    {
        info.geo=TRUE;
    }
    else
    {
        info.geo=FALSE;
        
    }
    info.kw=@"23232";
    info.kwPost=@"2";
    info.kwOffset=@"100";
    info.Left=@"11.01";
    info.Top=@"11.02" ;
    info.Right=@"40.00";
    info.Bottom=@"40.00";
    info.Pageno=@"1";
    info.imgeInfo.SignImageSize.height=260;
    info.imgeInfo.SignImageSize.width=300;
    return info;
}
#pragma mark 拍照之后、签名之后调用
- (void)getimage:(NSNotification *)noti{
    NSLog(@"family");
   	NSDictionary *info = [noti userInfo];
    UIImage *image=[info objectForKey:@"myimage"];
    
    
    
    NSData *data=UIImagePNGRepresentation(image);
    NSLog(@"大小%lu",(unsigned long)data.length);
    
}
-(void)dealloc{
    //    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
    
}


- (IBAction)yinCangBtnClick:(id)sender
{
  
    [UIView animateWithDuration:1 animations:^{
        self.frame = CGRectMake(1024, 64, 1024, 704);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
    
}


- (IBAction)baingengBtnClick:(id)sender
{
    [self changeRequest];
    if ([self.address isEqualToString:self.diZhiTf.text]&&[self.postcode isEqualToString:self.youBianTf.text]) {
        [self alertView:@"您未变更任何信息"];
        return;
    }
    
    MessageTestView *messV = [[MessageTestView alloc] init];
    messV.frame = CGRectMake(0, 0, 1024, 768);
    messV.delegate=self;
    messV.backgroundColor = [UIColor clearColor];
    ThreeViewController *threeVC = [ThreeViewController sharedManager];
    [threeVC.view addSubview:messV];
    
}

-(void)alertView:(NSString *)str{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertV show];
}
//确定变更请求
-(void)changeRequest{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,CHANGEURL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLChangeReturnBOModel> listBOModel=nil;
        @try {
            listBOModel=[remoteService updateLocationWithPolicyCode:@"1" andAddressFee:self.diZhiTf.text andZipLink:self.youBianTf.text andUserCate:[TPLSessionInfo shareInstance].userCate andUserName:[TPLSessionInfo shareInstance].isUserExt.userName andRealName:[TPLSessionInfo shareInstance].isUserExt.realName];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>%@",listBOModel);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([listBOModel.returnFlag  isEqualToString:@"1"]) {
                //表示请求出错
                UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"变更失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }else{
                
            }
        });
        
    });
    
}
@end


