//
//  VacillateSurrenderView.m
//  PreserveServerPaid
//
//  Created by yang on 15/10/8.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//犹豫期退保
#import "VacillateSurrenderView.h"
#import "PreserveServer-Prefix.pch"
#import "ThreeViewController.h"
#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.effect.QueryPolicyEffectivenessServlet"
@implementation VacillateSurrenderView
{
    UITableView         *tableV;
    VacillateSurrenderDateilView    *detailView;
    int                 lastBtn;//用来记录查看详情上次那个按钮点击了
    UILabel             *label;
    UITextView          *textV;//用来显示不可退保原因
    
}
+(VacillateSurrenderView*)awakeFromNib{
    return [[[NSBundle mainBundle]loadNibNamed:@"VacillateSurrenderView" owner:nil options:nil] objectAtIndex:0];
}
-(void)sizeToFit{
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
            listBOModel=[remoteService queryHesitateSurrenderWithCustomerID:[dic objectForKey:@"customerId"] bizChannel:@"111"];
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
    lastBtn=-1;
    self.mArray=[[NSMutableArray alloc] init];
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(50, 35, 845, 50)];
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.rowHeight=35;
    [self addSubview:tableV];
    //[tableV registerNib:[UINib nibWithNibName:@"VacillateSurrenderViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    //[tableV registerClass:[VacillateSurrenderViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self request];
}
-(void)custemTableViewFrame{
    if (self.mArray.count<11) {
        tableV.frame=CGRectMake(50, 35, 845, self.mArray.count*35);
    }else{
        tableV.frame=CGRectMake(50, 35, 845, 350);
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VacillateSurrenderViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[VacillateSurrenderViewCell alloc] initWithFrame:CGRectMake(0, 0, 845, 35)];
        cell.restorationIdentifier=@"cell";
        cell.selected=YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.numberL.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.btn.tag=indexPath.row;
    
    NSDictionary *dic=[self.mArray objectAtIndex:indexPath.row];
    cell.polityNumberL.text=[dic objectForKey:@"policyCode"];
    cell.polityTimeL.text=[dic objectForKey:@"takeEffectDate"];
    cell.polityNameL.text=[dic objectForKey:@"productName"];
    cell.polityTypeL.text=[dic objectForKey:@"policyStatus"];
    cell.surrenderL.text=[dic objectForKey:@"isRefund"];
    cell.notRedundReason.text=[dic objectForKey:@"notRedundReason"];
    if ([[dic objectForKey:@"isRefund"] isEqualToString:@"是"]) {
        //按钮不能点击
    }else{
        [cell.btn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=[self.mArray objectAtIndex:indexPath.row];
    if ([[dic objectForKey:@"isRefund"] isEqualToString:@"否"]) {
        //不能进入详情页
        return;
    }
    if(detailView){
        [detailView removeFromSuperview];
    }
    detailView=[VacillateSurrenderDateilView awakeFromNib];
    detailView.dic=[self.mArray objectAtIndex:indexPath.row];
    [detailView sizeToFit];
    detailView.tag=20000;
    detailView.frame=CGRectMake(1024, 64, 1024, 704);
    [[self superview] addSubview:detailView];
    [UIView animateWithDuration:1 animations:^{
        detailView.frame=CGRectMake(0, 64, 1024, 704);
    }];

}
-(void)cellBtnClick:(UIButton *)sender{
    VacillateSurrenderViewCell *cell=[[tableV visibleCells] objectAtIndex:sender.tag];
    if (lastBtn == sender.tag)
    {
        lastBtn=-1;
        //说明点击的是同一个按钮
        [textV removeFromSuperview];
        [cell.imageV setImage:[UIImage imageNamed:@"VacillateWei.png"]];
        //[cell.imageV setImage:[UIImage imageNamed:@"VacillateWei.png"] forState:UIControlStateNormal];
        return;
    }
    else
    {
        if (lastBtn>=0) {
            VacillateSurrenderViewCell *cell1=[[tableV visibleCells] objectAtIndex:lastBtn];
            [cell1.imageV setImage:[UIImage imageNamed:@"VacillateWei.png"]];
        }
        lastBtn=sender.tag;
        [cell.imageV setImage:[UIImage imageNamed:@"Vacillate.png"]];
    }
    if (textV) {
        [textV removeFromSuperview];
    }
    textV=[[UITextView alloc] init];
    textV.backgroundColor=[UIColor whiteColor];
    textV.layer.borderWidth=1;
    [textV setEditable:NO];
    textV.layer.borderColor=[[UIColor blackColor] CGColor];
    NSString *str=@"现不可犹豫期退保原因，现不可犹豫期退保原因，现不可犹豫期退保原因，现不可犹豫期退保原因，现不可犹豫期退保原因。";
    textV.text=[[self.mArray objectAtIndex:sender.tag] objectForKey:@"notRedundReason"];
    textV.font=[UIFont systemFontOfSize:14];
    textV.frame=CGRectMake(771, cell.frame.origin.y+70, 122, 150);
    [self addSubview:textV];
//CGRect size=[str boundingRectWithSize:CGSizeMake(122, 0) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

#pragma mark VacillateSurrenderViewCell

@implementation VacillateSurrenderViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle]loadNibNamed:@"VacillateSurrenderView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end



#pragma mark VacillateSurrenderDateilView

@implementation VacillateSurrenderDateilView
{
    UITableView     *tableV;
    BjcaInterfaceView *mypackage;//CA拍照
}

+(VacillateSurrenderDateilView *)awakeFromNib{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"VacillateSurrenderView" owner:nil options:nil] objectAtIndex:2];
}

-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
}
-(void)custemView{
    self.textFOne.delegate=self;
    self.textFTwo.delegate=self;
    self.mArray=[[NSMutableArray alloc] init];
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 107, 712, 107)];
    [self.baseView addSubview:tableV];
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.rowHeight=35;
    
    self.polityCode.text=[NSString stringWithFormat:@"保单号：%@",[self.dic objectForKey:@"policyCode"]];
    self.polityCodeDown.text=[self.dic objectForKey:@"policyCode"];
    self.bankAccount.text=[self.dic objectForKey:@"bankAccount"];
    self.accoOwnerName.text=[self.dic objectForKey:@"accoOwnerName"];
    self.bankCode.text=[self.dic objectForKey:@"bankCode"];
    self.accountType.text=[self.dic objectForKey:@"accountType"];
    
    self.mArray=[NSMutableArray arrayWithArray:[self.dic objectForKey:@"interList"]];

    [self custemFrame];
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
    int num=[self.number.text integerValue]-[self.textFOne.text integerValue]-[self.textFTwo.text integerValue];
    self.numberAmount.text=[NSString stringWithFormat:@"犹豫期退保实退金额合计:  %d",num];
}
-(void)custemFrame{
    if (self.mArray.count<4) {
        tableV.frame=CGRectMake(0, 106, 712, self.mArray.count*35);
    }
    else{
        tableV.frame=CGRectMake(0, 106, 712, 3*35);
    }
    self.rightDownView.frame=CGRectMake(0, tableV.frame.origin.y+tableV.frame.size.height+10, self.rightDownView.frame.size.width, self.rightDownView.frame.size.height);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VacillateSurrenderDateilCell *cell=[tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    if (!cell) {
        cell=[[VacillateSurrenderDateilCell alloc] initWithFrame:CGRectMake(0, 0, 712, 35)];
    }
    NSDictionary *dic=[self.mArray objectAtIndex:indexPath.row];
    cell.numberL.text=[dic objectForKey:@"itemId"];
    cell.codeL.text=[dic objectForKey:@"internalId"];
    cell.nameL.text=[dic objectForKey:@"productName"];
    cell.typeL.text=[dic objectForKey:@"liaStatusName"];
    return cell;
}
- (IBAction)backBtnClick:(UIButton *)sender {
    [self removeFromSuperview];
}
//确定按钮
- (IBAction)okBtnClick:(UIButton *)sender {
    MessageTestView *view=[[MessageTestView alloc] init];
    view.frame=CGRectMake(0,0, 1024, 768);
    view.delegate=self;
    [[self superview] addSubview:view];
    
}

#pragma  mark  messageTestViewDelegate

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
#pragma  mark  writeNameDelegate

-(void)writeNameEnd{
    BaoQuanPiWenView *view=(BaoQuanPiWenView *)[BaoQuanPiWenView awakeFromNib];
    //    view.frame
    [[self superview] addSubview:view];
}



@end


#pragma mark VacillateSurrenderDateilCell

@implementation VacillateSurrenderDateilCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"VacillateSurrenderView" owner:nil options:nil] objectAtIndex:3];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end
