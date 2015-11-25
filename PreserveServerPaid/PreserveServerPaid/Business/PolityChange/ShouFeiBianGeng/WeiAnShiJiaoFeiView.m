//
//  WeiAnShiJiaoFeiView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/25.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "WeiAnShiJiaoFeiView.h"
#import "WeiAnShiTableViewCell.h"
#import "BaoQuanPiWenView.h"
#import "PreserveServer-Prefix.pch"
#import "ThreeViewController.h"


#define WEIANSHICHAXUNURL @"/servlet/hessian/com.cntaiping.intserv.custserv.draw.QueryDrawAccountServlet"
#define WEIANSHIBIANGENGuRL @"/servlet/hessian/com.cntaiping.intserv.custserv.draw.UpdateBonusWayServlet"

@implementation WeiAnShiJiaoFeiView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
{
    UIView *biangengView;
    UITableView *weiAnShiTabv;
    BjcaInterfaceView *mypackage;//CA拍照
}



+(WeiAnShiJiaoFeiView *)awakeFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WeiAnShiJiaoFeiView" owner:nil options:nil] objectAtIndex:0];
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
    self.detailArray = [[NSMutableArray alloc] init];
    self.chooseArray = [[NSMutableArray alloc] init];
    
    weiAnShiTabv = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 776, 105)];
    weiAnShiTabv.delegate = self;
    weiAnShiTabv.dataSource = self;
    [self addSubview:weiAnShiTabv];
    
    [self requestNumber];
}


- (void)requestNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,WEIANSHICHAXUNURL]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            NSDictionary *dic = [[TPLSessionInfo shareInstance] custmerDic];
            
            listBOModel=[remoteService queryOverdueApproachWithCustomerId:[dic objectForKey:@"customerId"]];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
       // NSLog(@">>>>>>>>>>>>>wasmc%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++) {
            [self.detailArray addObject:[listBOModel.objList objectAtIndex:i]];
//            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
//            NSLog(@"%@",dic);
        }
        // receiveArray=[NSMutableArray arrayWithArray:self.tabArray];
        NSLog(@">>>>>>>>>>>>>999wasmc%@",self.detailArray);
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           NSString *errorStr = [listBOModel.errorBean errorInfo];
                           if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"])
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                               [alert show];
                               return;
                               
                               // NSLog(@"收费账号%@",listBOModel.objList);
                               
                           }
                          // [self.weiAnShiTabelView reloadData];
                           [self custemFrame];
                       });
        
    });
    
    
}


-(void)custemFrame{
    if (35*self.detailArray.count>385)
    {
        weiAnShiTabv.frame=CGRectMake(0, 35, 776, 385);
        self.quanXuanView.frame = CGRectMake(0, 35, 776, 385);
        
    }else{
        weiAnShiTabv.frame=CGRectMake(0, 35, 776, 35*self.detailArray.count);
        self.quanXuanView.frame = CGRectMake(0, 35+35*self.detailArray.count, 776, 35);
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;

}

//redefinition of method parameter section
//section used as the name of the previous parameter rather than as part of the selector

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    //NSLog(@"  %lu",(unsigned long)self.detailArray.count);
    return self.detailArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    static NSString * cellIdentifer = @"cell";
    NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"WeiAnShiTableViewCell" owner:nil options:nil];
    
    WeiAnShiTableViewCell *cell = (WeiAnShiTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if (!cell)
    {
        cell = xibArray[0];
        
    }
    NSDictionary *dic = [self.detailArray objectAtIndex:indexPath.row];
    
    cell.bianGengBtn.enabled=NO;
    
    [cell.bianGengBtn addTarget:self action:@selector(bianGengBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.bianGengBtn.tag = 8000+indexPath.row;
    //cell.bianGengBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    cell.baodanLabel.text = [dic objectForKey:@"policyCode"];
    
    //NSString *overStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"overDueManage"]];
    if ([[dic objectForKey:@"overDueManage"] integerValue] == 1)
    {
       cell.chuliLabel.text = @"自动垫缴";
        
    }
    else
    {
       cell.chuliLabel.text = @"停效";
    }
   
 
    if ([[dic objectForKey:@"overDueManageName"] isEqualToString:@"自动垫缴"])
    {
          [cell.bianGengBtn setImage:[UIImage imageNamed:@"zidongdianjiao.png"] forState:UIControlStateNormal];
    }
    else
    {
      
        [cell.bianGengBtn setImage:[UIImage imageNamed:@"tingxiao .png"] forState:UIControlStateNormal];
    }
    
    cell.tableBtn.tag=indexPath.row;
    [cell.tableBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    [cell.tableBtn addTarget:self action:@selector(xuanZhongaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (int i=0; i<self.chooseArray.count; i++)
    {
        if ([[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"] isEqualToString:[[self.detailArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]])
        {
            cell.bianGengBtn.enabled=YES;
            [cell.tableBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
            break;
        }
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    BOOL  isChoose=YES;
    for (int i=0;i<self.chooseArray.count;i++) {
        NSString *str=[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.detailArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]]) {
            [self.chooseArray removeObjectAtIndex:i];
            isChoose=NO;
            
            [self.allChooseBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
            break;
        }
        
    }
    if (isChoose) {
        //未选择，就添加
        [self.chooseArray addObject:[self.detailArray objectAtIndex:indexPath.row]];
        if (self.chooseArray.count==self.detailArray.count) {
            [self.allChooseBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [weiAnShiTabv reloadData];
    
}

//单选
-(void)xuanZhongaBtnClick:(UIButton *)btn
{
    BOOL  isChoose=YES;
    for (int i=0;i<self.chooseArray.count;i++) {
        NSString *str=[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.detailArray objectAtIndex:btn.tag] objectForKey:@"policyCode"]]) {
            [self.chooseArray removeObjectAtIndex:i];
            isChoose=NO;
            
             [self.allChooseBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
            break;
        }
       
    }
    if (isChoose) {
        //未选择，就添加
        [self.chooseArray addObject:[self.detailArray objectAtIndex:btn.tag]];
        if (self.chooseArray.count==self.detailArray.count) {
            [self.allChooseBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [weiAnShiTabv reloadData];
    
}

//全选功能
- (IBAction)quanXuanBtnClick:(UIButton *)sender
{
    if (sender.tag==7301) {
        //表示全选
        sender.tag=7302;
        [sender setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        [self.chooseArray removeAllObjects];
        for (NSString *str in self.detailArray) {
            [self.chooseArray addObject:str];
        }
        [weiAnShiTabv reloadData];
        return;
    }
    if (sender.tag==7302) {
        //全部不选
        [self.chooseArray removeAllObjects];
        sender.tag=7301;
        [sender setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
        [weiAnShiTabv reloadData];
    }
    
}


- (IBAction)quedingBtnClick:(id)sender
{
    
    if (self.chooseArray.count<1)
    {
        UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择保单后再进行操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }
    
    [self updateNumber];
//    
//    MessageTestView *messV = [[MessageTestView alloc] init];
//    messV.frame = CGRectMake(0, 0, 1024, 768);
//    messV.delegate=self;
//    messV.backgroundColor = [UIColor clearColor];
//    //    ThreeViewController *threeVC = [ThreeViewController sharedManager];
//    //    [threeVC.view addSubview:messV];
//    [[self superview] addSubview:messV];
    
}

//变更接口
-(void)updateNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,WEIANSHIBIANGENGuRL]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLChangeReturnBOModel> changeReturnBOModel=nil;
        @try {
            
           // NSDictionary *dic = [[TPLSessionInfo shareInstance] custmerDic];
            
            changeReturnBOModel=[remoteService updateOverdueApproachWithChangeArray:self.chooseArray];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
        NSLog(@">>>>>>>>>>>>>wasmcbg%@",changeReturnBOModel);

        dispatch_async(dispatch_get_main_queue(), ^
                       {
//                           NSString *errorStr = [listBOModel.errorBean errorInfo];
//                           if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"])
//                           {
//                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//                               [alert show];
//                               return;
//                               
//                               // NSLog(@"收费账号%@",listBOModel.objList);
//                           }
                           
                         //  [weiAnShiTabv reloadData];
                       
                       });
        
    });
    
    
}


- (void)bianGengBtnClick:(UIButton *)btn
{
    if (biangengView)
    {
        [biangengView removeFromSuperview];
    }
    biangengView = [[UIView alloc] initWithFrame:CGRectMake(599, 69+35*(btn.tag-8000), 100, 64)];
    [self addSubview:biangengView];
    
    UIButton *zidongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zidongBtn setImage:[UIImage imageNamed:@"zidongdianjiao.png"] forState:UIControlStateNormal];
    [zidongBtn addTarget:self action:@selector(zidongBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    zidongBtn.tag = btn.tag +100;
    zidongBtn.frame = CGRectMake(0, 0, 100, 32);
    [biangengView addSubview:zidongBtn];
    
    UIButton *tingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tingBtn setImage:[UIImage imageNamed:@"tingxiao .png"] forState:UIControlStateNormal];
    [tingBtn addTarget:self action:@selector(tingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    tingBtn.tag = btn.tag +200;
    tingBtn.frame = CGRectMake(0, 32, 100, 32);
    [biangengView addSubview:tingBtn];
    
}


-(void)zidongBtnClick:(UIButton *)sender
{
    UIButton *btn = (UIButton *)[self viewWithTag:sender.tag-100];
    NSLog(@" 按钮的值  %ld  ",(long)btn.tag);
//    id<TPLBonusWayBOModel>dic =  [self.huoDeArray objectAtIndex:btnTag-10];
//    dic.bonusType = @"现金领取";
    NSDictionary *dic = [self.detailArray objectAtIndex:btn.tag-8000];
    NSString *policyStr = [dic objectForKey:@"policyCode"];
    
    for (int i=0; i<self.chooseArray.count; i++)
    {
        if ([[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"] isEqualToString:policyStr])
        {
          
            NSString *ziStr = @"2";
            [dic setValue:ziStr forKey:@"overDueManage"];
            
        }
        
    }
    

   // btn.titleLabel.text = @"自动垫缴";
    [btn setImage:[UIImage imageNamed:@"zidongdianjiao.png"] forState:UIControlStateNormal];
    [sender.superview removeFromSuperview];
    
}

- (void)tingBtnClick:(UIButton *)sender
{
    UIButton *btn = (UIButton *)[self viewWithTag:sender.tag-200];
   // btn.titleLabel.text = @"停效";
    NSDictionary *dic = [self.detailArray objectAtIndex:btn.tag-8000];
   
    NSString *policyStr = [dic objectForKey:@"policyCode"];
    
    //根据保单号对chooseArray 中相应的内容进行修改
    for (int i=0; i<self.chooseArray.count; i++)
    {
        if ([[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"] isEqualToString:policyStr])
        {
            
            NSString *ziStr = @"1";
            [dic setValue:ziStr forKey:@"overDueManage"];
            
        }
        
    }
    
    
    [btn setImage:[UIImage imageNamed:@"tingxiao .png"] forState:UIControlStateNormal];
    [sender.superview removeFromSuperview];
    
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



@end
