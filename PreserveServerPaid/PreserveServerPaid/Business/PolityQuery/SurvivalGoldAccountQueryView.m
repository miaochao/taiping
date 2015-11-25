//
//  SurvivalGoldAccountQueryView.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/25.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//生存金账户信息
#import "SurvivalGoldAccountQueryView.h"
#import "SurvivalAccountCell.h"
#import "SurvivalGQDetailView.h"
#import "PreserveServer-Prefix.pch"
#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.draw.QueryDrawAccountServlet"
@implementation SurvivalGoldAccountQueryView
{
    UITableView     *tableV;
    SurvivalGQDetailView *detailView;
    NSMutableArray  *array;
    int             time;//用来表示时间的升序降序
    
    int             page;//请求的页码
}
+(UIView*)awakeFromNib{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"SurvivalGoldAccountQueryView" owner:self options:nil];
    
    
    return [array lastObject];
}
-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
}
-(void)custemView{
    self.mArray=[[NSMutableArray alloc] init];
    array=[[NSMutableArray alloc] init];
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(50, 35, 844, 35*5) style:UITableViewStylePlain];
    [self addSubview:tableV];
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.rowHeight=35;
    [tableV registerNib:[UINib nibWithNibName:@"SurvivalAccountCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            NSDictionary *dic=[[TPLSessionInfo shareInstance] custmerDic];
            listBOModel=[remoteService survivalGoldAccountInformationWith:[dic objectForKey:@"customerId"] ];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
       // NSLog(@">>>>>>>>>>>>>%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++) {
            [self.mArray addObject:[listBOModel.objList objectAtIndex:i]];
            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
           // NSLog(@"%@",dic);
        }
        array=[NSMutableArray arrayWithArray:self.mArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"]) {
            //表示请求出错
            UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:[listBOModel.errorBean errorInfo] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertV show];
            }else{
                [tableV reloadData];
                [self custemFrame];
            }

        });
    });
  
}
-(void)custemFrame{
    if (35*self.mArray.count>524) {
        tableV.frame=CGRectMake(50, 35, 844, 525);
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
    NSDictionary *dic=nil;
    if (time==10) {
        dic=[self.mArray objectAtIndex:self.mArray.count-1-indexPath.row];
    }else{
        dic=[self.mArray objectAtIndex:indexPath.row];
    }
    cell.numberLabel.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.polityNumLabel.text=[dic objectForKey:@"policyCode"];
    cell.typeLabel.text=[dic objectForKey:@"liabilityStateName"];
    cell.timeLabel.text=[dic objectForKey:@"validateDate"];
    cell.insureLabel.text=[dic objectForKey:@"holderName"];
    cell.insuredLabel.text=[dic objectForKey:@"insuredName"];
    cell.polityNameLabel.text=[dic objectForKey:@"productName"];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(detailView){
        [detailView removeFromSuperview];
    }
    detailView=(SurvivalGQDetailView *)[SurvivalGQDetailView awakeFromNib];
    detailView.pilityCode=[[self.mArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"];
    detailView.frame=CGRectMake(1024, 64, 1024, 704);
    detailView.tag=20000;
    [detailView custem];
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
    view.backgroundColor=[UIColor whiteColor];
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
            NSDictionary *dic=[array objectAtIndex:i];
            if ([[dic objectForKey:@"typeLabel"] isEqualToString:@"有效"]) {
                [self.mArray addObject:dic];
            }
        }
    }
    if (sender.tag==200) {
        //有效
        for (int i=0; i<array.count; i++) {
            NSDictionary *dic=[array objectAtIndex:i];
            if ([[dic objectForKey:@"typeLabel"] isEqualToString:@"无效"]) {
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
