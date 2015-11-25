//
//  TouLianZhuiJiaView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/28.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "TouLianZhuiJiaView.h"
#import "TouLianTableViewCell.h"
#import "TouLianZhuiJiaXiangQingView.h"
#import "PreserveServer-Prefix.pch"

#define TOULIANCHAXUN @"/servlet/hessian/com.cntaiping.intserv.custserv.investment.QueryInvestmentAccountServlet"



@implementation TouLianZhuiJiaView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


+(UIView*)awakeFromNib{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"TouLianZhuiJiaView" owner:self options:nil];
    
    TouLianZhuiJiaView *touLianView = [array lastObject];
    touLianView.quanArray = [[NSMutableArray alloc] init];
    touLianView.chooseArray = [[NSMutableArray alloc] init];
    
    touLianView.xuanZeBtn.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
    touLianView.baoDanBtn.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
    touLianView.zhuXianBtn.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
    //touLianView.touLianQueRenBtn.backgroundColor =  [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
    
    NSDictionary *dic=@{@"number":@"15300990549000",@"name":@"第一主险"};
    [touLianView.quanArray addObject:dic];
    NSDictionary *dic1=@{@"number":@"18398080985003",@"name":@"第一主险"};
    [touLianView.quanArray addObject:dic1];
    NSDictionary *dic2=@{@"number":@"15308573878799",@"name":@"第一主险"};
    [touLianView.quanArray addObject:dic2];
    
    touLianView.touLianTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 776, touLianView.quanArray.count*35) style:UITableViewStylePlain];
    [touLianView addSubview:touLianView.touLianTableView];
    
    
    touLianView.quanXuanView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    return touLianView;
}

*/

{
    TouLianZhuiJiaXiangQingView *bigtouLianView;
}


+(TouLianZhuiJiaView *)awakeFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"TouLianZhuiJiaView" owner:nil options:nil] objectAtIndex:0];
    
}


- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}


-(void)custemView
{
    self.quanArray = [[NSMutableArray alloc] init];
    self.chooseArray = [[NSMutableArray alloc] init];
    
    self.xuanZeBtn.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
    self.baoDanBtn.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
    self.zhuXianBtn.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
    //touLianView.touLianQueRenBtn.backgroundColor =  [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
    
//    NSDictionary *dic=@{@"number":@"15300990549000",@"name":@"第一主险"};
//    [self.quanArray addObject:dic];
//    NSDictionary *dic1=@{@"number":@"18398080985003",@"name":@"第一主险"};
//    [self.quanArray addObject:dic1];
//    NSDictionary *dic2=@{@"number":@"15308573878799",@"name":@"第一主险"};
//    [self.quanArray addObject:dic2];
    
    
    self.quanXuanView.frame = CGRectMake(0, 140, 776, 38);
    self.touLianTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 776, 70) style:UITableViewStylePlain];
    //NSLog(@"qqqq%d",self.quanArray.count);
    [self addSubview:self.touLianTableView];
    self.touLianTableView.delegate = self;
    self.touLianTableView.dataSource = self;
    
    self.quanXuanView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];


    [self requestNumber];
    
}


- (void)requestNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,TOULIANCHAXUN]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            NSDictionary *dic = [[TPLSessionInfo shareInstance] custmerDic];
            
            listBOModel=[remoteService queryInvestmentUniversalAdditionalInvestmentWithcustomerId:[dic objectForKey:@"customerId"] busiType:@"3"];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
       // NSLog(@">>>>>>>>>>>>>tlzmc%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++) {
            [self.quanArray addObject:[listBOModel.objList objectAtIndex:i]];
            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
            NSLog(@"%@",dic);
        }
        // receiveArray=[NSMutableArray arrayWithArray:self.tabArray];
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
                           [self.touLianTableView reloadData];
                           [self custemFrame];
                       });
        
    });
    
    
}

-(void)custemFrame{
    if (35*self.quanArray.count>385) {
        self.touLianTableView.frame=CGRectMake(0, 35, 776, 385);
        self.quanXuanView.frame = CGRectMake(0, 420, 776, 35);
        self.touLianQueRenBtn.frame = CGRectMake(686, 440+35, 90, 35);
        
    }else{
        self.touLianTableView.frame=CGRectMake(0, 35, 776, 35*self.quanArray.count);
        self.quanXuanView.frame = CGRectMake(0, 35+35*self.quanArray.count, 776, 35);
        self.touLianQueRenBtn.frame = CGRectMake(686, 35+35*self.quanArray.count+50, 90, 35);
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

//redefinition of method parameter section
//section used as the name of the previous parameter rather than as part of the selector

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@" gggg %lu",(unsigned long)self.quanArray.count);
    return self.quanArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     //自定义cell
     static NSString *cellIdeitifier1 = @"Cell1";
     static NSString *cellIdeitifier2 = @"Cell2";
     ZYTableViewCell *cell = nil;
     
     NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"ZYTableViewCell" owner:nil options:nil];
     
     if (news.newsType != 6)
     {
     // cell1
     cell = [tableView dequeueReusableCellWithIdentifier:cellIdeitifier1];
     if (cell == nil)
     {
     cell = xibArray[0];
     }
     */
    
    static NSString * cellIdentifer = @"cell";
    NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"TouLianTableViewCell" owner:nil options:nil];
    
    TouLianTableViewCell *cell = (TouLianTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if (cell== nil)
    {
        cell = xibArray[0];
        [cell.tableBtn addTarget:self action:@selector(xuanZhongBtnClick:) forControlEvents:UIControlEventTouchUpInside];
      
    }
    
    
    cell.tableBtn.tag=indexPath.row;
    [cell.tableBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    [cell.tableBtn addTarget:self action:@selector(xuanZhongBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *dic=[self.quanArray objectAtIndex:indexPath.row];
    cell.baodanLabel.text = [dic objectForKey:@"policyCode"];
    cell.xianZhongLabel.text = [dic objectForKey:@"productName"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (int i=0; i<self.chooseArray.count; i++)
    {
        if ([[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"] isEqualToString:[[self.quanArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]])
        {
            [cell.tableBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
            break;
        }
    }
   
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if (bigtouLianView)
    {
        [bigtouLianView removeFromSuperview];
    }
    //TouLianZhuiJiaXiangQingView *bigtouLianView = (TouLianZhuiJiaXiangQingView *)[TouLianZhuiJiaXiangQingView awakeFromNib];
    bigtouLianView = [TouLianZhuiJiaXiangQingView sharedManager];
    bigtouLianView.alpha=1;
    bigtouLianView.tag=20000;
    bigtouLianView.frame = CGRectMake(1024, 64, 1024, 704);
    bigtouLianView.backgroundColor = [UIColor clearColor];
    [[self superview] addSubview:bigtouLianView];
    
    [UIView animateWithDuration:1 animations:^
     {
         
         bigtouLianView.frame = CGRectMake(0, 64, 1024, 704);
         
     } completion:^(BOOL finished)
     {
         nil;
         
     }];
    */
    BOOL  isChoose=YES;
    for (int i=0;i<self.chooseArray.count;i++) {
        NSString *str=[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.quanArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]]) {
            [self.chooseArray removeObjectAtIndex:i];
            isChoose=NO;
             [self.quanXuanBtn  setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
            break;
        }
       
    }
    if (isChoose) {
        //未选择，就添加
        [self.chooseArray addObject:[self.quanArray objectAtIndex:indexPath.row]];
        if (self.chooseArray.count==self.quanArray.count) {
            [self.quanXuanBtn  setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [self.touLianTableView reloadData];
    
}

//单选
-(void)xuanZhongBtnClick:(UIButton *)btn
{
    BOOL  isChoose=YES;
    for (int i=0;i<self.chooseArray.count;i++) {
        NSString *str=[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.quanArray objectAtIndex:btn.tag] objectForKey:@"policyCode"]]) {
            [self.chooseArray removeObjectAtIndex:i];
            isChoose=NO;
            [self.quanXuanBtn  setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
            break;
        }
        
    }
    if (isChoose) {
        //未选择，就添加
        [self.chooseArray addObject:[self.quanArray objectAtIndex:btn.tag]];
        if (self.chooseArray.count==self.quanArray.count) {
            [self.quanXuanBtn  setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [self.touLianTableView reloadData];
    

}


//全选功能按钮
- (IBAction)quanXuanBtnClick:(UIButton *)sender
{
    if (sender.tag==9057) {
        //表示全选
        sender.tag=9058;
        [sender setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        [self.chooseArray removeAllObjects];
        for (NSString *str in self.quanArray) {
            [self.chooseArray addObject:str];
        }
        [self.touLianTableView reloadData];
        return;
    }
    if (sender.tag==9058) {
        //全部不选
        [self.chooseArray removeAllObjects];
        sender.tag=9057;
        [sender setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
        [self.touLianTableView reloadData];
    }

    
}

//确定按钮
- (IBAction)queDingBtnClick:(id)sender
{
    if (self.chooseArray.count == 0)
    {
        [self alertView:@"请选择保单后再进行操作！"];
        return;
    }
    if (bigtouLianView)
    {
        [bigtouLianView removeFromSuperview];
    }
    //bigtouLianView = [[[NSBundle mainBundle] loadNibNamed:@"TouLianZhuiJiaXiangQingView" owner:nil options:nil] lastObject];
    bigtouLianView = [TouLianZhuiJiaXiangQingView awakeFromNib];
    
    bigtouLianView.alpha=1;
    bigtouLianView.tag=20000;
    [bigtouLianView sizeToFit];
    bigtouLianView.huodeArray = self.chooseArray;
    bigtouLianView.chargV.bankTextField.text = @"";
    bigtouLianView.chargV.acountTextField.text = @"";
    bigtouLianView.chargV.organizationTextField.text = @"";
    
    bigtouLianView.frame = CGRectMake(1024, 64, 1024, 704);
    bigtouLianView.backgroundColor = [UIColor clearColor];
    [[self superview] addSubview:bigtouLianView];
    
    [UIView animateWithDuration:1 animations:^
     {
         
         bigtouLianView.frame = CGRectMake(0, 64, 1024, 704);
         
         
     } completion:^(BOOL finished)
     {
         nil;
     }];
}

-(void)alertView:(NSString *)str{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertV show];
}

@end
