//
//  MainProgressView.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/22.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "MainProgressView.h"
#import "MainProgressTableCell.h"
#import "PreserveServer-Prefix.pch"

#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.QueryPreserveServlet"
@implementation MainProgressView
{
    UIView      *dateView;
    UIDatePicker *datePicker;
    NSDate      *leftDate;//和右边的对比
    UITableView *tableV;
    NSDate      *beginDate;//左边的开始时间
    NSDate      *endDate;//右边的结束时间
}

+(UIView*)awakeFromNib{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"MainProgressView" owner:self options:nil];
    
    
    return [array lastObject];
}
-(void)customUI{
    self.dateBtn1.layer.borderWidth=1;
    self.dateBtn2.layer.borderWidth=1;
    self.dateBtn1.layer.borderColor=[[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.dateBtn2.layer.borderColor=[[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    
    self.numberTF=[[UITextField alloc] initWithFrame:CGRectMake(465, 16, 285, 34)];
    [self addSubview:self.numberTF];
    
    self.numberTF.borderStyle=UITextBorderStyleRoundedRect;
//    self.numberTF.layer.borderWidth=0.5;
    self.numberTF.placeholder=@"输入保单号";
    self.numberTF.contentVerticalAlignment=UIControlContentHorizontalAlignmentCenter;
    
//    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame=CGRectMake(0, 0, 35, 35);
//    [btn setImage:[UIImage imageNamed:@"sousuo.png"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.numberTF.rightView=btn;
//    self.numberTF.rightViewMode=UITextFieldViewModeAlways;
    
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 111, 832, 768-111)];
    [self addSubview:tableV];
    tableV.delegate=self;
    tableV.dataSource=self;
    [tableV registerNib:[UINib nibWithNibName:@"MainProgressTableCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    tableV.rowHeight=35;
    
    self.mArray=[[NSMutableArray alloc] init];
//    NSDictionary *d=@{@"polityNumber":@"153009905490000",
//                      @"polityID":@"381196879",
//                      @"polityType":@"保单基本信息变更",
//                      @"state":@"保全生效",
//                      @"polityOneNum":@"004050153192807",
//                      @"name":@"宋晓丽",
//                      @"time":@"2015-08-09",
//                      @"passBy":@"易服务"};
//    NSDictionary *d1=@{@"polityNumber":@"153009905491111",
//                      @"polityID":@"381196000",
//                      @"polityType":@"保单基本信息变更",
//                      @"state":@"保全无效",
//                      @"polityOneNum":@"004050153192807",
//                      @"name":@"王小名",
//                      @"time":@"2015-01-01",
//                      @"passBy":@"易服务"};
//    [self.mArray addObject:d];
//    [self.mArray addObject:d1];
//    tableV.frame=CGRectMake(0, 111, 832, 35*self.mArray.count);
    [self custemFrame];
}
-(void)custemFrame{
    if (self.mArray.count>13) {
        tableV.frame=CGRectMake(0, 111, 832, 35*14);
    }else{
        tableV.frame=CGRectMake(0, 111, 832, 35*self.mArray.count);
    }
}
#pragma mark  tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.mArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainProgressTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    id<TPLPreserveBOModel>dic=[self.mArray objectAtIndex:indexPath.row];
    cell.polityNumber.text=dic.policyCode;
    cell.polityID.text=dic.changeId;
    cell.polityType.text=dic.serviceName;
    cell.state.text=dic.changeStatus;
    cell.polityOneNum.text=dic.noticeCode;
    cell.name.text=dic.handlerName;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    cell.time.text=[dateFormatter stringFromDate:dic.proposeTime];
    cell.passBy.text=dic.channelDesc;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
//选择日期
- (IBAction)buttonClick:(UIButton *)sender {
    if (!dateView) {
        [self creatDateView];
    }
    dateView.alpha=1;
    if(sender.tag==100){
        dateView.center=self.dateBtn1.center;
        dateView.frame=CGRectMake(dateView.frame.origin.x, 55, 250, 180);
    }
    if (sender.tag==200) {
        dateView.center=self.dateBtn2.center;
        dateView.frame=CGRectMake(dateView.frame.origin.x, 55, 250, 180);
    }
}
//创建datepicker
-(void)creatDateView{
    dateView=[[UIView alloc] initWithFrame:CGRectMake(29, 55, 250, 180)];
    dateView.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    //dateView.backgroundColor=[UIColor whiteColor];
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
    cancelBtn.frame=CGRectMake(20, 153, 60, 25);
    cancelBtn.tag=1;
    cancelBtn.layer.masksToBounds=YES;
    cancelBtn.layer.cornerRadius=3;
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAndOKBtn:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.borderColor = [[UIColor blackColor] CGColor];
    
    UIButton *okBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame=CGRectMake(150, 153, 60, 25);
    okBtn.tag=2;
    okBtn.layer.masksToBounds=YES;
    okBtn.layer.cornerRadius=3;
    [okBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(cancelAndOKBtn:) forControlEvents:UIControlEventTouchUpInside];
    [dateView addSubview:okBtn];
    okBtn.layer.borderWidth = 1;
    okBtn.layer.borderColor = [[UIColor blackColor] CGColor];
    
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
        [_dateBtn1 setTitle:string forState:UIControlStateNormal];
        leftDate=date;
        beginDate=date;
    }
    else{
        //右边选择时间
        endDate=date;
        if ([date compare:leftDate]==NSOrderedAscending) {
            [self dateAlertView:@"结束时间不能超过开始时间"];
        }
        [_dateBtn2 setTitle:string forState:UIControlStateNormal];
    }
}
//选择时间不对时，提示
-(void)dateAlertView:(NSString *)string{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertV show];
}
- (IBAction)seekBtnClick:(UIButton *)sender {
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            listBOModel=[remoteService queryPreserveWithWithAgentId:@"111" andPolicyCode:self.numberTF.text andCustomerName:Nil andGender:Nil andBirthday:Nil andAuthCertiCode:Nil andStartDate:beginDate  andEndDate:endDate];
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
                [self.mArray removeAllObjects];
                for (int i=0; i<listBOModel.objList.count; i++) {
                    id<TPLPreserveBOModel>dic=[listBOModel.objList objectAtIndex:i];
                    [self.mArray addObject:dic];
                }
                [tableV reloadData];
                
            }
            [self custemFrame];
        });

    });
    

}
#pragma mark 点击搜索
-(void)btnClick:(UIButton *)sender{
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
