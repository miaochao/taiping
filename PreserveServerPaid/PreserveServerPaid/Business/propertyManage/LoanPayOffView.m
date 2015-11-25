//
//  LoanPayOffView.m
//  PreserveServerPaid
//
//  Created by yang on 15/10/10.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//贷款清偿
#import "LoanPayOffView.h"
#import "BjcaInterfaceView.h"
#import "ThreeViewController.h"
#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.loan.LoanRepaymentServlet"

@implementation LoanPayOffView
{
    UITableView         *tableV;
    BjcaInterfaceView *mypackage;//CA拍照
}
-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
}
-(void)request{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            NSDate *date=[NSDate date];
            NSDictionary *dic=[[TPLSessionInfo shareInstance] custmerDic];
            
            listBOModel=[remoteService queryLoanRepaymentWithPolityID:[dic objectForKey:@"customerId"] calcDate:date];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++) {
            [self.mArray addObject:[listBOModel.objList objectAtIndex:i]];
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
-(void)custemView{
    self.mArray=[[NSMutableArray alloc] init];
    self.payOffBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.payOffBtn.frame=CGRectMake(0, 0, 90, 35);
    self.payOffBtn.backgroundColor=[UIColor grayColor];
    [self.payOffBtn setTitle:@"立即还款" forState:UIControlStateNormal];
    [self.payOffBtn setTintColor:[UIColor whiteColor]];
    [self.payOffBtn addTarget:self action:@selector(okBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.payOffBtn];
    
    self.payOffBtn.enabled=NO;
    //[self.payOffBtn addTarget:self action:@selector(okBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(85, 35, 845, 50)];
    [self addSubview:tableV];
    
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.rowHeight=36;
    
    [self request];
    //    [self.mArray addObject:@"1"];
    //    [self.mArray addObject:@"1"];
    //    [self.mArray addObject:@"1"];
    //
    //    [self custemTableViewFrame];
}
-(void)custemTableViewFrame{
    if (self.mArray.count<9) {
        tableV.frame=CGRectMake(85, 35, 845, self.mArray.count*35);
    }else{
        tableV.frame=CGRectMake(85, 35, 845, 350);
    }
    self.label.frame=CGRectMake(85, tableV.frame.origin.y+tableV.frame.size.height+58, 272, 21);
    self.payOffBtn.frame=CGRectMake(840, tableV.frame.origin.y+tableV.frame.size.height+10, 90, 35);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoanPayOffCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[LoanPayOffCell alloc] initWithFrame:CGRectMake(0, 0, 845, 36)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic=[self.mArray objectAtIndex:indexPath.row];
    cell.numberL.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.polityNumberL.text=[dic objectForKey:@"policyId"];
    cell.loanExtensionDate.text=[dic objectForKey:@"loanExtensionDate"];
    cell.interestCapital.text=[dic objectForKey:@"interestCapital"];
    cell.interestBalance.text=[dic objectForKey:@"interestBalance"];
    cell.productTotalAmount.text=[dic objectForKey:@"productTotalAmount"];
    cell.textF.delegate=self;
    return cell;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    int   num;
    for (int i=0; i<[[tableV visibleCells] count]; i++) {
        LoanPayOffCell *cell=[[tableV visibleCells] objectAtIndex:i];
        if (cell.textF.text.length>0) {
            num=1;
            break;
        }
    }
    if (num==1) {
        self.payOffBtn.enabled=YES;
        [self.payOffBtn setBackgroundColor:[UIColor colorWithRed:0 green:151/255.0 blue:255/255.0 alpha:1]];
    }else{
        self.payOffBtn.enabled=NO;
        self.payOffBtn.backgroundColor=[UIColor grayColor];
    }
    //    self.payOffBtn.enabled=YES;
    //    if (textField.text.length<=0) {
    //
    //    }
    //    else{
    //        number++;
    //    }
    //    if (number>0) {
    //        [self.payOffBtn setBackgroundColor:[UIColor colorWithRed:0 green:151/255.0 blue:255/255.0 alpha:1]];
    //    }else{
    //        number--;
    //        self.payOffBtn.enabled=NO;
    //        self.payOffBtn.backgroundColor=[UIColor grayColor];
    //    }
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
//立即还款
-(void)okBtn:(UIButton *)sender{
    MessageTestView *view=[[MessageTestView alloc] init];
    view.frame=CGRectMake(0,0, 1024, 768);
    view.delegate=self;
    [[self superview] addSubview:view];
}
//- (IBAction)okBtnClick:(UIButton *)sender {
//    MessageTestView *view=[[MessageTestView alloc] init];
//    view.frame=CGRectMake(0,0, 1024, 768);
//    view.delegate=self;
//    [[self superview] addSubview:view];
//}
#pragma  mark  messageTestViewDelegate

-(void)massageTest{
//        WriteNameView  *view=[[WriteNameView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
//        view.delegate=self;
//        [[self superview] addSubview:view];
    [mypackage reset];//先清空之前的数据
    [self startinterface];
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
#pragma  mark  writeNameDelegate

-(void)writeNameEnd{
    BaoQuanPiWenView *view=(BaoQuanPiWenView *)[BaoQuanPiWenView awakeFromNib];
    //    view.frame
    [[self superview] addSubview:view];
}

@end


#pragma mark  LoanPayOffCell

@implementation LoanPayOffCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"LoanPayOffView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end
