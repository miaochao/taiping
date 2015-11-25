//
//  LoanAccountQueryView.m
//  PreserveServerPaid
//
//  Created by yang on 15/10/14.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//贷款账户查询
#import "LoanAccountQueryView.h"
#import "PreserveServer-Prefix.pch"

#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.loan.QueryLoanAccountServlet"
@implementation LoanAccountQueryView
{
    UITableView         *tableV;
    int                 time;
    UIView      *dateView;
    UIDatePicker *datePicker;
    NSDate      *leftDate;//和右边的对比
    NSDate      *beginDate;//开始时间
    NSDate      *endDate;//结束时间
}

+(LoanAccountQueryView*)awakeFromNib{
    return [[[NSBundle mainBundle] loadNibNamed:@"LoanAccountQueryView" owner:nil options:nil] objectAtIndex:0];
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
            listBOModel=[remoteService queryLoanAccountWithAgentId:@"12346" andPolicyCode:self.textF.text andRealName:@"xiaowang" andGender:0 andBirthday:endDate andAuthCertiCode:@"45845454565654545" andStartDate:beginDate andEndDate:endDate ];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>%@",listBOModel);
        [self.mArray removeAllObjects];
        for (int i=0; i<listBOModel.objList.count; i++) {
            id<TPLLoanAccountBOModel>dic=[listBOModel.objList objectAtIndex:i];
            [self.mArray addObject:dic];
            //NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
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
    self.textF.layer.borderWidth=1;
    self.textF.layer.borderColor=[[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.beginBtn.layer.borderWidth=1;
    self.beginBtn.layer.borderColor=[[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.endBtn.layer.borderWidth=1;
    self.endBtn.layer.borderColor=[[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.mArray=[[NSMutableArray alloc] init];
    
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(50, 78, 844, 0)];
    [self addSubview:tableV];
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.rowHeight=35;
    
//    NSDictionary *dic=@{@"accountNumber":@"1001001",@"accountName":@"XXXX账户",@"money":@"1000"};
//    [self.mArray addObject:dic];
//    NSDictionary *dic1=@{@"accountNumber":@"1001002",@"accountName":@"XXXX账户",@"money":@"1000"};
//    [self.mArray addObject:dic1];
//    NSDictionary *dic2=@{@"accountNumber":@"1001003",@"accountName":@"XXXX账户",@"money":@"1000"};
//    [self.mArray addObject:dic2];
//    
//    [self custemTableViewFrame];
    
}
-(void)custemTableViewFrame{
    if (self.mArray.count<16) {
        tableV.frame=CGRectMake(50, 78, 844, self.mArray.count*35);
    }else{
        tableV.frame=CGRectMake(50, 78, 844, 35*15);
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoanAccountQueryCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[LoanAccountQueryCell alloc] initWithFrame:CGRectMake(0, 0, 844, 35)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    //private String customerId;//客户ID    private String policyCode;//保单号    private Date loanTime;//操作日期    private String capitalAmount;//贷款金额    private String repayAmount;//还款金额    private String balanceAccount;//结算    private String loanAmount;//本息合计    private String interestRate;//贷款利率    private Date settledTime;//约定到期日    private String channelDesc;//操作途径
    
    id<TPLLoanAccountBOModel>dic=[self.mArray objectAtIndex:indexPath.row];
    cell.policyCode.text=dic .policyCode;
    cell.loanTime.text=[self stringFromeDate:dic.loanTime];
    cell.capitalAmount.text=dic.capitalAmount;
    cell.repayAmount.text=dic.repayAmount;
    cell.balanceAccount.text=dic.balanceAccount;
    cell.loanAmount.text=dic.loanAmount;
    cell.interestRate.text=dic.interestRate;
    cell.settledTime.text=[self stringFromeDate:dic.settledTime];
    cell.channelDesc.text=dic.channelDesc;
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
    [tableV reloadData];
}

//右边的查询按钮
- (IBAction)queryBtnClick:(UIButton *)sender {
    [self request];
}
//点击得到时间
- (IBAction)timeBtnClick:(UIButton *)sender {
    if (!dateView) {
        [self creatDateView];
    }
    dateView.alpha=1;
    if(sender.tag==100){
        dateView.center=self.beginBtn.center;
        dateView.frame=CGRectMake(dateView.frame.origin.x, 46, 250, 180);
    }
    if (sender.tag==200) {
        dateView.center=self.endBtn.center;
        dateView.frame=CGRectMake(dateView.frame.origin.x, 46, 250, 180);
    }
}
//创建datepicker
-(void)creatDateView{
    dateView=[[UIView alloc] initWithFrame:CGRectMake(125, 33, 250, 180)];
    dateView.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self addSubview:dateView];
    
    datePicker=[[UIDatePicker alloc] init];
    datePicker.frame=CGRectMake(5, 0, 240, 130);
    [dateView addSubview:datePicker];
    datePicker.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //    NSDate *miniDate=[dateFormatter dateFromString:@"2015-05-06"];
    datePicker.maximumDate=[NSDate date];
    NSLog(@"%@",datePicker.date);
    //NSLog(@"%f",datePicker.frame.size.height);
    UIButton *cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [dateView addSubview:cancelBtn];
    cancelBtn.frame=CGRectMake(20, 150, 60, 25);
    cancelBtn.tag=1;
    cancelBtn.layer.masksToBounds=YES;
    cancelBtn.layer.cornerRadius=3;
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAndOKBtn:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    
    UIButton *okBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame=CGRectMake(150, 150, 60, 25);
    okBtn.tag=2;
    okBtn.layer.masksToBounds=YES;
    okBtn.layer.cornerRadius=3;
    [okBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(cancelAndOKBtn:) forControlEvents:UIControlEventTouchUpInside];
    okBtn.layer.borderWidth = 1;
    okBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    [dateView addSubview:okBtn];
    
}
//取消、确定按钮
-(void)cancelAndOKBtn:(UIButton *)sender{
    NSDate *date=datePicker.date;
    NSString *shengRiNianString = [NSString stringWithFormat:@"%@ - ",[date.description substringToIndex:4]];
    NSString *shengRiYueString = [NSString stringWithFormat:@"%@ - ",[date.description substringWithRange:NSMakeRange(5, 2)]];
    NSString *shengRiRiString = [NSString stringWithFormat:@"%@",[date.description substringWithRange:NSMakeRange(8, 2)]];
    NSString *string = [NSString stringWithFormat:@"%@%@%@",shengRiNianString,shengRiYueString,shengRiRiString];
    
    dateView.alpha=0;
    NSDate *nowDate=[[NSDate alloc] init];
    if ([nowDate compare:date]==NSOrderedAscending) {
        [self dateAlertView:@"选择的时间不能超出当前的时间"];
        return;
    }
    if (dateView.frame.origin.x<100) {
        //左边
        beginDate=date;
        [self.beginBtn setTitle:string forState:UIControlStateNormal];
        leftDate=date;
    }
    else{
        //右边选择时间
        endDate=date;
        if ([date compare:leftDate]==NSOrderedAscending) {
            [self dateAlertView:@"结束时间不能超过开始时间"];
        }
        [self.endBtn setTitle:string forState:UIControlStateNormal];
    }
}
//选择时间不对时，提示
-(void)dateAlertView:(NSString *)string{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertV show];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


#pragma mark  LoanAccountQueryCell

@implementation LoanAccountQueryCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"LoanAccountQueryView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end
