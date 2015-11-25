//
//  HistoryChangeQueryView.m
//  PreserveServerPaid
//
//  Created by yang on 15/10/14.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "HistoryChangeQueryView.h"
#import "SurvivalAccountCell.h"
#import "PreserveServer-Prefix.pch"

#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.QueryPreserveServlet"
@implementation HistoryChangeQueryView
{
    UITableView     *tableV;
    NSMutableArray  *array;
    int             time;//用来表示时间的升序降序
    HistoryChangeQueryDetailView *detailView;
}
+(UIView*)awakeFromNib{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"HistoryChangeQueryView" owner:self options:nil];
    
    
    return [array lastObject];
}
-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
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
            NSDate *date=[NSDate date];
            listBOModel=[remoteService queryPolicyWithAgentId:@"112" andPolicyCode:@"1212" andRealName:[dic objectForKey:@"realName"] andGender:gender andBirthday:birthday andAuthCertiCode:[dic objectForKey:@"certiCode"]];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>%@",listBOModel);
        [self.mArray removeAllObjects];
        for (int i=0; i<listBOModel.objList.count; i++) {
            id<TPLPolicyBOModel>dic=[listBOModel.objList objectAtIndex:i];
            [self.mArray addObject:dic];
            //NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
        }
        array=[NSMutableArray arrayWithArray:self.mArray];
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
    array=[[NSMutableArray alloc] init];
    
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(50, 35, 844, 0)];
    [self addSubview:tableV];
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.rowHeight=35;
    [tableV registerNib:[UINib nibWithNibName:@"SurvivalAccountCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    [self custemTableViewFrame];
    [self request];
}
-(void)custemTableViewFrame{
    if (35*self.mArray.count>603) {
        tableV.frame=CGRectMake(50, 35, 844, 603);
    }else{
        tableV.frame=CGRectMake(50, 35, 844, 35*self.mArray.count);
    }
}
#pragma mark UItableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SurvivalAccountCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    id<TPLPolicyBOModel>dic=nil;
    if (time==10) {
        dic=[self.mArray objectAtIndex:self.mArray.count-1-indexPath.row];
    }else{
        dic=[self.mArray objectAtIndex:indexPath.row];
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
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (detailView) {
        [detailView removeFromSuperview];
    }
    detailView=[[[NSBundle mainBundle] loadNibNamed:@"HistoryChangeQueryView" owner:self options:nil] objectAtIndex:1];
    detailView.frame=CGRectMake(1024, 64, 1024, 704);
    detailView.tag=20000;
    [detailView sizeToFit];
    [[self superview] addSubview:detailView];
    [UIView animateWithDuration:1 animations:^{
        detailView.frame=CGRectMake(0, 64, 1024, 704);
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
    [tableV reloadData];
}
//责任状态
- (IBAction)stateBtnClick:(UIButton *)sender {
    //    NSMutableArray *array=@[@"有效",@"无效",@"无"];
    //    enumView *view=[[enumView alloc] initWithFrame:CGRectMake(386, 35, 72, 100) mArray:array tag:1];
    ////    view.backgroundColor=[UIColor greenColor];
    //    [self addSubview:view];
    sender.enabled=NO;
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(386, 35, 72, 100)];
    view.layer.borderWidth=0.5;
    view.backgroundColor=[UIColor grayColor];
    [self addSubview:view];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 72, 33);
    [view addSubview:btn];
    btn.tag=100;
    [btn setTitle:@"有效" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:btn1];
    btn1.frame=CGRectMake(0, 33, 72, 33);
    btn1.tag=200;
    [btn1 setTitle:@"无效" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:btn2];
    btn2.frame=CGRectMake(0, 66, 72, 33);
    btn2.tag=300;
    [btn2 setTitle:@"无" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
//责任状态点击
-(void)typeBtnClick:(UIButton *)sender{
    self.typeBtn.enabled=YES;
    [self.mArray removeAllObjects];
    if (sender.tag==100) {
        //有效
        for (int i=0; i<array.count; i++) {
            
            id<TPLPolicyBOModel>dic=[array objectAtIndex:i];
            if ([dic.liabilityStatus  isEqualToString:@"有效"]) {
                [self.mArray addObject:dic];
            }
        }
    }
    if (sender.tag==200) {
        //有效
        for (int i=0; i<array.count; i++) {
            id<TPLPolicyBOModel>dic=[array objectAtIndex:i];
            if ([dic.liabilityStatus isEqualToString:@"无效"]) {
                [self.mArray addObject:dic];
            }
        }
    }
    if (sender.tag==300) {
        self.mArray=[NSMutableArray arrayWithArray:array];
    }
    
    tableV.frame=CGRectMake(50, 35, 844, 35*self.mArray.count);
    if (35*self.mArray.count>603) {
        tableV.frame=CGRectMake(50, 35, 844, 603);
    }
    [tableV reloadData];
    [[sender superview] removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



@implementation HistoryChangeQueryDetailView
{
    UITableView         *tableV;
    int                 time;
    UIView      *dateView;
    UIDatePicker *datePicker;
    NSDate      *leftDate;//和右边的对比
    NSDate      *beginDate;
    NSDate      *endDate;
}
-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
}
-(void)custemView{
    self.beginTimeL.layer.borderWidth=1;
    self.beginTimeL.layer.borderColor=[[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.endTimeL.layer.borderWidth=1;
    self.endTimeL.layer.borderColor=[[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.mArray=[[NSMutableArray alloc] init];
    
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 90, 712, 50)];
    [self.baseView addSubview:tableV];
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.rowHeight=35;
    
    [self custemTableViewFrame];
    
}
-(void)custemTableViewFrame{
    if (self.mArray.count<16) {
        tableV.frame=CGRectMake(0, 90, 712, self.mArray.count*35);
    }else{
        tableV.frame=CGRectMake(0, 90, 712, 35*15);
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryChangeQueryDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    if (!cell) {
        cell=[[HistoryChangeQueryDetailCell alloc] initWithFrame:CGRectMake(0, 0, 712, 35)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.btn.tag=indexPath.row;
    [cell.btn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    id<TPLPreserveBOModel>dic=[self.mArray objectAtIndex:indexPath.row];
    //PreserveBO   保全ID号   changeId   String    客户ID   customerId   String    保单号   policyCode   String    保全项目   serviceName   String    保全操作状态   changeStatus   String    保全批单号   noticeCode   String    申请人姓名   handlerName   String    保全申请时间   proposeTime   Date    保全生效时间   validateDate   Date    保全操作途径   channelDesc   String    批文   approval   String
    cell.changeId.text=dic.changeId;
    cell.serviceName.text=dic.serviceName;
    cell.changeStatus.text=dic.changeStatus;
    cell.noticeCode.text=dic.noticeCode;
    cell.handlerName.text=dic.handlerName;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    cell.proposeTime.text=[dateFormatter stringFromDate:dic.proposeTime];
    cell.validateDate.text=[dateFormatter stringFromDate:dic.validateDate];
    cell.channelDesc.text=dic.channelDesc;
    return cell;
}
//cell上的按钮
-(void)cellBtnClick:(UIButton *)sender
{
    NSLog(@"%d",sender.tag);
    HistoryCheckView *hisCheck = [[[NSBundle mainBundle] loadNibNamed:@"HistoryChangeQueryView" owner:nil options:nil] objectAtIndex:3];
    id<TPLPreserveBOModel>dic=[self.mArray objectAtIndex:sender.tag];
    hisCheck.str=dic.approval;
    [hisCheck sizeToFit];
    hisCheck.backgroundColor = [UIColor clearColor];
    [[self superview] addSubview:hisCheck];
    
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
            listBOModel=[remoteService queryPreserveWithWithAgentId:@"111" andPolicyCode:@"111" andCustomerName:[dic objectForKey:@"realName"] andGender:gender andBirthday:birthday andAuthCertiCode:[dic objectForKey:@"certiCode"] andStartDate:beginDate  andEndDate:endDate];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>%@",listBOModel);
        [self.mArray removeAllObjects];
        for (int i=0; i<listBOModel.objList.count; i++) {
            id<TPLPreserveBOModel>dic=[listBOModel.objList objectAtIndex:i];
            [self.mArray addObject:dic];
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
        dateView.center=self.beginTimeL.center;
        dateView.frame=CGRectMake(dateView.frame.origin.x, 46, 250, 180);
    }
    if (sender.tag==200) {
        dateView.center=self.endTimeL.center;
        dateView.frame=CGRectMake(dateView.frame.origin.x, 46, 250, 180);
    }
}
//创建datepicker
-(void)creatDateView{
    dateView=[[UIView alloc] initWithFrame:CGRectMake(125, 46, 250, 180)];
    dateView.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.baseView addSubview:dateView];
    
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
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    cancelBtn.layer.masksToBounds=YES;
    cancelBtn.layer.cornerRadius=3;
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAndOKBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *okBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame=CGRectMake(150, 150, 60, 25);
    okBtn.tag=2;
    okBtn.layer.masksToBounds=YES;
    okBtn.layer.cornerRadius=3;
    okBtn.layer.borderWidth = 1;
    okBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    [okBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(cancelAndOKBtn:) forControlEvents:UIControlEventTouchUpInside];
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
        self.beginTimeL.text=string;
        leftDate=date;
        beginDate=date;
    }
    else{
        //右边选择时间
        endDate=date;
        if ([date compare:leftDate]==NSOrderedAscending) {
            [self dateAlertView:@"结束时间不能超过开始时间"];
        }
        self.endTimeL.text=string;
    }
}
//选择时间不对时，提示
-(void)dateAlertView:(NSString *)string{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertV show];
}
//左边的按钮
- (IBAction)backBtnClick:(UIButton *)sender {
    //self.alpha=0;
    [self removeFromSuperview];
}

@end




#pragma mark  HistoryChangeQueryDetailCell

@implementation HistoryChangeQueryDetailCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"HistoryChangeQueryView" owner:nil options:nil] objectAtIndex:2];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end

@implementation HistoryCheckView

-(void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}
-(void)custemView
{
    
    self.smallCheckView.layer.borderWidth = 1;
    self.smallCheckView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.approval.text=self.str;
}

- (IBAction)checkCloseBtnClick:(id)sender
{
    
    [self removeFromSuperview];
    
}



@end


