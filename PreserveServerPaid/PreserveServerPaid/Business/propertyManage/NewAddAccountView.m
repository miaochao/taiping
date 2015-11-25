//
//  NewAddAccountView.m
//  PreserveServerPaid
//
//  Created by yang on 15/10/9.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "NewAddAccountView.h"
#import "ChargeView.h"
#import "PreserveServer-Prefix.pch"
#import "ThreeViewController.h"
#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.investment.QueryInvestmentAccountServlet"
#define CHANGEURL @"/servlet/hessian/com.cntaiping.intserv.custserv.investment.UpdateInvestmentAccountServlet"
@implementation NewAddAccountView
{
    UITableView         *tableV;
    NewAddAccountDetailView *detailView;
}

+(NewAddAccountView*)awakeFromNib{
    return [[[NSBundle mainBundle] loadNibNamed:@"NewAddAccountView" owner:nil options:nil] objectAtIndex:0];
}
-(void)request{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            NSDictionary *dic=[[TPLSessionInfo shareInstance] custmerDic];
            listBOModel=[remoteService queryNewProfitsAccountWithCustomerCIF:[dic objectForKey:@"partyNO"]];
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
    [tableV registerClass:[NewAddAccountCell class] forCellReuseIdentifier:@"cell"];
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
    NewAddAccountCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *dic=[self.mArray objectAtIndex:indexPath.row];
    cell.numberL.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.accountL.text=[dic objectForKey:@"policyCode"];
    cell.nameL.text=[dic objectForKey:@"productName"];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(detailView){
        [detailView removeFromSuperview];
    }
    detailView=[NewAddAccountDetailView awakeFromNib];
    detailView.polityCode=[[self.mArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"];
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


#pragma mark NewAddAccountCell

@implementation NewAddAccountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1];
        _numberL=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 64, 35)];
        _numberL.backgroundColor=[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
        _numberL.textAlignment=UITextAlignmentCenter;
        [self addSubview:_numberL];
        
        _accountL=[[UILabel alloc] initWithFrame:CGRectMake(65, 0, 339, 35)];
        _accountL.backgroundColor=[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
        _accountL.textAlignment=UITextAlignmentCenter;
        [self addSubview:_accountL];
        
        _nameL=[[UILabel alloc] initWithFrame:CGRectMake(405, 0, 370, 35)];
        _nameL.backgroundColor=[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
        _nameL.textAlignment=UITextAlignmentCenter;
        [self addSubview:_nameL];
    }
    return self;
}
@end


#pragma mark  NewAddAccountDetailView

@implementation NewAddAccountDetailView
{
    UIView              *certainView;//确认书
    ChargeView *chargV;
    BjcaInterfaceView *mypackage;//CA拍照
}
+(NewAddAccountDetailView*)awakeFromNib{
    return [[[NSBundle mainBundle] loadNibNamed:@"NewAddAccountView" owner:nil options:nil] objectAtIndex:1];
}
-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
}
-(void)request{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            listBOModel=[remoteService queryNewProfitsAccountDetailWithPolityCode:self.polityCode];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++) {
            //[self.mArray addObject:[listBOModel.objList objectAtIndex:i]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"]) {
                //表示请求出错
                UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:[listBOModel.errorBean errorInfo] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }else{
                
            }
            
        });
    });
    
}
-(void)custemView{
    self.textF.enabled=NO;
    self.textF.delegate=self;
    self.certainBtn.enabled=NO;
    
    chargV=[ChargeView awakeFromNib];
    chargV.frame=CGRectMake(0, 491, 712, 164);
    chargV.upOrdown=YES;
    chargV.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [chargV createBtn];
    [self.rightView addSubview:chargV];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 163, 712, 1)];
    label.backgroundColor=[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1];
    [chargV addSubview:label];
    
    [self request];
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
//新增万能账户信息确认书
- (IBAction)addNewAccountBtn:(UIButton *)sender {
    if (sender.tag==100) {
        //显示出来
        self.addNewAccountBtn.tag=200;
        self.addNewAccountBtn1.tag=200;
        self.addNewAccountView.frame=CGRectMake(0, 135+36, 712, 112);
        if (!certainView) {
            [self createBookView];
        }else{
            certainView.alpha=1;
        }
        [self.addNewAccountBtn setImage:[UIImage imageNamed:@"zhankai.png"] forState:UIControlStateNormal];
    }else{
        //隐藏掉
        self.addNewAccountBtn.tag=100;
        self.addNewAccountBtn1.tag=100;
        certainView.alpha=0;
        self.addNewAccountView.frame=CGRectMake(0, 0, 712, 112);
        [self.addNewAccountBtn setImage:[UIImage imageNamed:@"shouqi.png"] forState:UIControlStateNormal];
    }
}
-(void)createBookView{
    certainView=[[UIView alloc] initWithFrame:CGRectMake(0, 141+36, 712, 171)];
    certainView.backgroundColor=[UIColor whiteColor];
    [self.rightView addSubview:certainView];
    
    UIButton    *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(120, 124, 40, 40);
    btn.tag=110;
    [btn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(bookViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [certainView addSubview:btn];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(170, 124, 500, 40)];
    label.text=@"以上内容均已阅读并确认，新增的“太平盈账户终身寿险（万能型）”犹豫期从即日起开始计算";
    label.font=[UIFont systemFontOfSize:12];
    [certainView addSubview:label];
    label.font=[UIFont boldSystemFontOfSize:12];
    
    UITextView *textV=[[UITextView alloc] initWithFrame:CGRectMake(15, 0, 682, 124)];
    [certainView addSubview:textV];
    textV.layer.borderWidth=0.4;
    [textV setEditable:NO];
    textV.font=[UIFont systemFontOfSize:12];
    [textV setText:@"尊敬的客户：\n\n    您选择的保单新增了”太平盈账户终身寿险（万能型）“产品，该产品的生效日期保险期限等相关信息详见批文。 \n\n    请您认真阅读以下内容并进行签字确认。     \n\n    一、太平“太平盈账户终身寿险（万能型）”产品的保险责任如下：在本合同保险期间内且本合同有效，如果被保险人身\n故，我们按被保险人身故时本合同保单账户价值（有关保单账户价值，请参照本合同第十条）的105%给付身故保险金，同时本\n合同终止。\n\n     二、新增“太平盈账户终身寿险（万能型）”产品后，在保单无欠款的前提下，可通过两种方式将公司约定的产品各期生\n存金转入“太平盈账户终身寿险（万能型）”产品的保单账户（以下简称“该账户”）。方式一：新增“该账户”的保单，生\n存金将默认转入；方式二：其他相关保单的生存金将由生存受益人授权转入“该账户”。除另有约定外，转入次数不低于10次。\n     生存金实际转入日期作为本次进入“该账户”资金的计息开始日。新增或是授权转入“该账户”后，上述保单的投保人默\n认成为相关保单的生存受益人。进入“该账户”的生存金将由上述保单投保人自行支配。“该账户”终止或生存金授权方式改\n为其他方式后，相关保单的生存受益人将恢复为默认前的生存受益人。\n\n     三、万能产品说明及风险提示 \n    “太平盈账户终身寿险（万能型）”为万能保险产品，请您注意以下事项：万能保险产品通常有最低保\n证利率的约定，最低保证利率仅针对投资账户中资金。您应当详细了解万能保险的费用扣除情况，包括初始费用、死亡风险保险费、保单管理费、\n手续费、退保费用等。您应当要求销售人员将万能保险账户价值的详细计算方法对您进行解释。万能保险产品的投资回报具有\n不确定性，您要承担部分投资风险。保险公司每月公布的结算利率只能代表一个月的投资情况，不能理解为对全年的预期，结\n算利率仅针对投资账户中的资金，不针对全部保险费。产品说明书或保险利益测算书中关于未来保险合同利益的预测是基于公\n司精算假设，最低保证利率之上的投资收益是不确定的，不能理解为对未来的预期。如果您选择灵活交费方式的，您应当要求\n销售人员将您停止交费可能产生的风险和不利后果对您进行解释\n\n"];
}
-(void)bookViewBtnClick:(UIButton *)sender{
    if (sender.tag==110) {
        //变为选中状态
        [sender setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        self.textF.enabled=YES;
        self.textF.backgroundColor=[UIColor whiteColor];
        self.certainBtn.enabled=YES;
        [self.certainBtn setBackgroundColor:[UIColor colorWithRed:0 green:151/255.0 blue:255/255.0 alpha:1]];
        sender.tag=120;
    }else{
        [sender setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
        self.textF.enabled=NO;
        self.textF.backgroundColor=[UIColor grayColor];
        self.certainBtn.enabled=NO;
        [self.certainBtn setBackgroundColor:[UIColor grayColor ]];
        sender.tag=110;
    }
}
//确定变更
- (IBAction)certainBtnClick:(UIButton *)sender {
    if (self.textF.text.length<=0) {
        [self alertView:@"请输入首期保费！"];
        return;
    }
    if ([chargV.bankTextField.text isEqualToString:@""])
    {
        [self alertView:@"请选择账号所属银行！"];
        return;
    }
    if ([chargV.acountTextField.text isEqualToString:@""])
    {
        [self alertView:@"请输入收费账号！"];
        return;
    }
    if ([chargV.organizationTextField.text isEqualToString:@""])
    {
        [self alertView:@"请选择账号所属机构！"];
        return;
    }
    
    [self changeRequest];
    MessageTestView *view=[[MessageTestView alloc] init];
    view.frame=CGRectMake(0,0, 1024, 768);
    view.delegate=self;
    [[self superview] addSubview:view];
    
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
            
            listBOModel=[remoteService newProfitsAccountWithpolicyCode:self.polityCode bizChannel:@"1232" internalId:@"1233" bankCode:chargV.bankTextField.text bankAccount:chargV.acountTextField.text accountType:chargV.typeTextField.text accoOwnername:chargV.nameTextField.text organId:chargV.organizationTextField.text firstPrem:self.textF.text];
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

//左边的按钮
- (IBAction)backBtnClick:(UIButton *)sender {
    [self removeFromSuperview];
}

@end


@implementation NewAddAccountDetailViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"NewAddAccountView" owner:nil options:nil] objectAtIndex:3];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end