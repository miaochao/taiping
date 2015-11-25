//
//  ProportionChangeView.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/28.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//投连账户投资比例变更
#import "ProportionChangeView.h"
#import "ProportionChangeDetailCell.h"
#import "ThreeViewController.h"
#import "enumView.h"
#import "BaoQuanPiWenView.h"
#import "PreserveServer-Prefix.pch"
#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.investment.QueryInvestmentAccountServlet"
#define CHANGEURL @"/servlet/hessian/com.cntaiping.intserv.custserv.investment.UpdateInvestmentAccountServlet"
@implementation ProportionChangeView
{
    UITableView         *tableV;
    ProportionChangeDetailView  *detailView;
}
+(ProportionChangeView*)awakeFromNib{
    return [[[NSBundle mainBundle] loadNibNamed:@"ProportionChangeView" owner:nil options:nil] objectAtIndex:0];
}
- (void)sizeToFit{
    [super sizeToFit];
    [self custemView];
}
-(void)request{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            NSDictionary *dic=[[TPLSessionInfo shareInstance] custmerDic];
            
            listBOModel=[remoteService queryInvestmentRatioWithCustmerId:[dic objectForKey:@"customerId"]];
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
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(85, 35, 776, 50)];
    [self addSubview:tableV];
    
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.rowHeight=35;
    [tableV registerClass:[ProportionChangeViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self request];  
    
}
-(void)custemTableViewFrame{
    if (self.mArray.count>9) {
        tableV.frame=CGRectMake(85, 35, 776, 9*35);
    }else{
        tableV.frame=CGRectMake(85, 35, 776, self.mArray.count*35);
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProportionChangeViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ProportionChangeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary *dic=[self.mArray objectAtIndex:indexPath.row];
    cell.num.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.numberL.text=[dic objectForKey:@"policyCode"];
    cell.nameL.text=[dic objectForKey:@"productName"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(detailView){
        [detailView removeFromSuperview];
    }
    detailView=[ProportionChangeDetailView awakeFromNib];
    detailView.dic=[self.mArray objectAtIndex:indexPath.row];
    [detailView custemView];    
    detailView.tag=20000;
    detailView.frame=CGRectMake(1024, 64, 1024, 704);
    [[self superview] addSubview:detailView];
    [UIView animateWithDuration:1 animations:^{
        detailView.frame=CGRectMake(0, 64, 1024, 704);
    }];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


//投连账户投资比例变更cell
#pragma mark  ProportionChangeViewCell

@implementation ProportionChangeViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1];
        _num=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 35)];
        _num.textAlignment=UITextAlignmentCenter;
        _num.font=[UIFont systemFontOfSize:16];
        _num.textColor=[UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1];
        _num.backgroundColor=[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
        [self addSubview:_num];
        
        _numberL=[[UILabel alloc] initWithFrame:CGRectMake(66, 0, 314, 35)];
        _numberL.textAlignment=UITextAlignmentCenter;
        _numberL.font=[UIFont systemFontOfSize:16];
        _numberL.textColor=[UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1];
        _numberL.backgroundColor=[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
        [self addSubview:_numberL];
        
        _nameL=[[UILabel alloc] initWithFrame:CGRectMake(381, 0, 395, 35)];
        _nameL.textAlignment=UITextAlignmentCenter;
        _nameL.font=[UIFont systemFontOfSize:16];
        _nameL.textColor=[UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1];
        _nameL.backgroundColor=[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
        [self addSubview:_nameL];
    }
    return self;
}

@end


//投连账户投资比例变更  详情
#pragma mark ProportionChangeDetailView


@implementation ProportionChangeDetailView
{
    UITableView         *tableV;
    NSMutableArray      *chooseArray;
     BjcaInterfaceView *mypackage;//CA拍照
}
+(ProportionChangeDetailView*)awakeFromNib{
    return [[[NSBundle mainBundle]loadNibNamed:@"ProportionChangeView" owner:nil options:nil] objectAtIndex:1];
}
-(void)request{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            listBOModel=[remoteService queryInvestmentRatioDetailWithpolicyCode:[self.dic objectForKey:@"policyCode"]];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>%@",listBOModel);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"]) {
                //表示请求出错
                UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:[listBOModel.errorBean errorInfo] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }else{
                NSDictionary *dic=[listBOModel.objList objectAtIndex:0];
                self.internalId.text=[NSString stringWithFormat:@"险种代码：%@",[dic objectForKey:@"internalId"]];
                self.productName.text=[NSString stringWithFormat:@"险种名称：%@",[dic objectForKey:@"productName"]];
            }
            
        });
    });
    
}
-(void)custemView{
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
    
    self.mArray=[[NSMutableArray alloc] init];
    chooseArray=[[NSMutableArray alloc] init];
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 184, 712, 50)];
    [self.backView addSubview:tableV];
    tableV.rowHeight=36;
    tableV.delegate=self;
    tableV.dataSource=self;
    [self request];
    self.polityCode.text=[NSString stringWithFormat:@"保单号：%@",[self.dic objectForKey:@"policyCode"]];
    NSDictionary *dic=@{@"accountNumber":@"1001001",@"accountName":@"XXXX账户",@"money":@"1000"};
    [self.mArray addObject:dic];
    [self custemFrame];
}
-(void)custemFrame{
    if (self.mArray.count>4) {
        tableV.frame=CGRectMake(0, 184, 712, 36*5);
        self.allChooseView.frame=CGRectMake(0, tableV.frame.origin.y+36*5+1, 712, 36);
    }else{
        tableV.frame=CGRectMake(0, 184, 712, 36*self.mArray.count);
        self.allChooseView.frame=CGRectMake(0, tableV.frame.origin.y+36*self.mArray.count+1, 712, 36);
        
    }
    self.delegateView.frame=CGRectMake(0, self.allChooseView.frame.origin.y+self.allChooseView.frame.size.height+1, 712, 36);
    self.downView.frame=CGRectMake(0, self.delegateView.frame.origin.y+37, 712, 704-self.delegateView.frame.origin.y-37);
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProportionChangeDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if(!cell){
        cell=[[ProportionChangeDetailViewCell alloc] initWithFrame:CGRectMake(0, 0, 712, 36)];
        cell.restorationIdentifier=@"cell1";
    }
    cell.chooseBtn.alpha=1;
    cell.chooseBtn.tag=indexPath.row;
    [cell.chooseBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.chooseBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    if (indexPath.row==0) {
        cell.chooseBtn.alpha=0;
        cell.numberTF.text=@"50";
    }
    for (int i=0; i<chooseArray.count; i++) {
        if ([[[chooseArray objectAtIndex:i] objectForKey:@"accountNumber"] isEqualToString:[[self.mArray objectAtIndex:indexPath.row] objectForKey:@"accountNumber"]]) {
            [cell.chooseBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
            break;
        }
    }
    cell.numberTF.delegate=self;
    NSDictionary *dic=[self.mArray objectAtIndex:indexPath.row];
    cell.accountNumber.text=[dic objectForKey:@"accountNumber"];
    cell.accountName.text=[dic objectForKey:@"accountName"];
    cell.money.text=[dic objectForKey:@"money"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if (choose==indexPath.row) {
//         [cell.chooseBtn setImage:[UIImage imageNamed:@"danxuan dianji.png"] forState:UIControlStateNormal];
//    }
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
//左边的按钮
- (IBAction)backBtnClick:(UIButton *)sender {
    [self removeFromSuperview];
}

//新增账户按钮
- (IBAction)newAddAccountBtnClick:(UIButton *)sender {
    
    NSMutableArray  *array=[[NSMutableArray alloc] initWithObjects:@"平均稳健账户",@"XXXXXX账户",@"XXXXXX账户", nil];
    enumView *view=[[enumView alloc] initWithFrame:CGRectMake(self.addNewAccountTF.frame.origin.x, 106, self.addNewAccountTF.frame.size.width, 77) mArray:array title:@"请选择账户"];
    view.delegate=self;
    [self.smallDetailView addSubview:view];
    [self custemFrame];
}

#pragma mark  enumViewDelegate
-(void)enumViewDelegateString:(NSString *)str{
    self.addNewAccountTF.text=str;
}

//全选按钮
- (IBAction)allChooseBtnClick:(UIButton *)sender {
    if (sender.tag==100) {
        //表示全选
        sender.tag=50;
        [sender setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        [chooseArray removeAllObjects];
        for (NSString *str in self.mArray) {
            [chooseArray addObject:str];
        }
        [tableV reloadData];
        return;
    }
    if (sender.tag==50) {
        //全部不选
        [chooseArray removeAllObjects];
        sender.tag=100;
        [sender setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
        [tableV reloadData];
    }
}

//新增和删除
- (IBAction)allChooseOrDelegate:(UIButton *)sender {
    
    if(sender.tag==200){
        //表示删除选中
//        if(choose>-1){
//            [self.mArray removeObjectAtIndex:choose];
//        }
//        choose=-1;
        for (int i=0; i<chooseArray.count; i++) {
            for (int j=0; j<self.mArray.count; j++) {
                if ([[[chooseArray objectAtIndex:i] objectForKey:@"accountNumber"] isEqualToString:[[self.mArray objectAtIndex:j] objectForKey:@"accountNumber"]]) {
                    [self.mArray removeObjectAtIndex:j];
                    j--;
                }
            }
        }
        [chooseArray removeAllObjects];
    }
    if(sender.tag==300){
        if (self.addNewAccountTF.text.length<1) {
            return;
        }
        //表示增加一条数据
        NSDictionary *dic=@{@"accountNumber":@"1001002",@"accountName":@"XXXX账户",@"money":@"1000"};
        [self.mArray addObject:dic];
    }
    [self custemFrame];
    [tableV reloadData];
}

//单选
- (void)chooseBtnClick:(UIButton *)sender {
    //choose=sender.tag;
    BOOL  choose=YES;
    for (int i=0;i<chooseArray.count;i++) {
        NSString *str=[[chooseArray objectAtIndex:i] objectForKey:@"accountNumber"];
        if ([str isEqualToString:[[self.mArray objectAtIndex:sender.tag] objectForKey:@"accountNumber"]]) {
            [chooseArray removeObjectAtIndex:i];
            choose=NO;
            break;
        }
    }
    if (choose) {
        //未选择，就添加
        [chooseArray addObject:[self.mArray objectAtIndex:sender.tag]];
    }
    [tableV reloadData];
}
- (IBAction)okChangeBtnClick:(UIButton *)sender {
    //先判断比例有没有超过100
    NSArray *array=[tableV visibleCells];
    int sum=0;
    for (int i=0; i<array.count; i++) {
        ProportionChangeDetailCell *cell=[array objectAtIndex:i];
        sum=sum+[cell.numberTF.text integerValue];
    }
    if (sum>100) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息" message:@"分配比例总和不能超过100%" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [self changeRequest];
    //短信验证
    MessageTestView *view=[[MessageTestView alloc] init];
    view.frame=CGRectMake(0,0, 1024, 768);
//    [backV addSubview:view];
    view.delegate=self;
    [[self superview] addSubview:view];
    
}
//确定变更请求
-(void)changeRequest{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,CHANGEURL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLChangeReturnBOModel> listBOModel=nil;
        @try {
            
            listBOModel=[remoteService updateInvestmentRatioWithpolicyCode:[self.dic objectForKey:@"policyCode"] bizChannel:@"13212" productAccountList:self.mArray ];
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
#pragma mark massageDelegate
-(void)massageTest{
    //    WriteNameView  *view=[[WriteNameView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    //    view.delegate=self;
    //    [[self superview] addSubview:view];
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
-(void)writeNameEnd{
    BaoQuanPiWenView *view=[BaoQuanPiWenView awakeFromNib];
    //    view.frame
    [[self superview] addSubview:view];
}
@end


@implementation ProportionChangeDetailViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ProportionChangeView" owner:nil options:nil] lastObject];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}
@end