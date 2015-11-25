//
//  ShouFeiBianGengVIew.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/25.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "ShouFeiBianGengVIew.h"
#import "ShouFeiTableViewCell.h"
#import "ShouFeiXiangQingView.h"
#import "PreserveServer-Prefix.pch"

#define SHOUFEIBIANGENGURL @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.QueryPreserveServlet"


@implementation ShouFeiBianGengVIew

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


+(UIView*)awakeFromNib{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"ShouFeiBianGengVIew" owner:self options:nil];
    
    ShouFeiBianGengVIew *shouFeiView = [array lastObject];
    shouFeiView.shouFeiArrray = [[NSMutableArray alloc] init];
    shouFeiView.chooseArray = [[NSMutableArray alloc] init];
   
    
    NSDictionary *dic=@{@"number":@"153009905490009",@"fangshi":@"现金",@"bank":@"--",@"账号":@"6008545845254521541",@"所有人":@"宋晓丽"};
    [shouFeiView.shouFeiArrray  addObject:dic];
    NSDictionary *dic1=@{@"number":@"183980809850037",@"fangshi":@"银行转账",@"bank":@"中国银行",@"账号":@"6008545845254500000",@"所有人":@"宋晓丽"};
    [shouFeiView.shouFeiArrray  addObject:dic1];
    NSDictionary *dic2=@{@"number":@"153085738787991",@"fangshi":@"现金",@"bank":@"交通银行",@"账号":@"60085458452545888888",@"所有人":@"宋晓丽"};
    [shouFeiView.shouFeiArrray  addObject:dic2];
   // shouFeiView.quanxuanView.layer.borderWidth = 0.5;
   // shouFeiView.quanxuanView.layer.borderColor = [[UIColor grayColor] CGColor];
    
    return shouFeiView;
}
*/
{
    //服务器接收到的数据
    NSMutableArray *receiveArray;
    
}


+(ShouFeiBianGengVIew *)awakeFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ShouFeiBianGengVIew" owner:nil options:nil] objectAtIndex:0];
}


- (void)sizeToFit
{
    [super sizeToFit];
   
    
    [self custemView];
}


-(void)custemView
{
    
    self.shouFeiArrray = [[NSMutableArray alloc] init];
    self.chooseArray = [[NSMutableArray alloc] init];
    
//    NSDictionary *dic=@{@"number":@"153009905490009",@"fangshi":@"现金",@"bank":@"--",@"账号":@"6008545845254521541",@"所有人":@"宋晓丽"};
//    [self.shouFeiArrray  addObject:dic];
//    NSDictionary *dic1=@{@"number":@"183980809850037",@"fangshi":@"银行转账",@"bank":@"中国银行",@"账号":@"6008545845254500000",@"所有人":@"宋晓丽"};
//    [self.shouFeiArrray  addObject:dic1];
//    NSDictionary *dic2=@{@"number":@"153085738787991",@"fangshi":@"现金",@"bank":@"交通银行",@"账号":@"60085458452545888888",@"所有人":@"宋晓丽"};
//    [self.shouFeiArrray  addObject:dic2];
    
    //id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:@"http://172.16.13.159:8080/custServ/servlet/hessian/com.cntaiping.intserv.custserv.draw.QueryDrawAccountServlet"];
    
    [self requestNumber];
    
}

- (void)requestNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,SHOUFEIBIANGENGURL]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            NSDictionary *dic = [[TPLSessionInfo shareInstance] custmerDic];
            
            listBOModel=[remoteService queryChargeAccountWithCustomerId:[dic objectForKey:@"customerId"]];
        
        }
        @catch (NSException *exception) {
            
        }
        @finally
        {
        }
        NSLog(@">>>>>>>>>>>>>mc%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++) {
            [self.shouFeiArrray addObject:[listBOModel.objList objectAtIndex:i]];
            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
         //   NSLog(@"%@",dic);
        }
        receiveArray=[NSMutableArray arrayWithArray:self.shouFeiArrray];
        
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           NSString *errorStr = [listBOModel.errorBean errorInfo];
                           if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"])
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                               [alert show];
                               return;
                               
                           }
                           [self.shouFeiTableView reloadData];
                           
                           // NSLog(@"收费账号%@",listBOModel.objList);
                           
                           [self custemFrame];
                       });
        
    });
   
}


-(void)custemFrame{
    if (35*self.shouFeiArrray.count>603) {
        self.shouFeiTableView.frame=CGRectMake(0, 35, 844, 603);
        self.quanxuanView.frame = CGRectMake(0, 35, 844, 603);
        
    }else{
        self.shouFeiTableView.frame=CGRectMake(0, 35, 844, 35*self.shouFeiArrray.count);
        self.quanxuanView.frame = CGRectMake(0, 35+35*self.shouFeiArrray.count, 844, 35);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSLog(@"   sssss %lu",(unsigned long)self.shouFeiArrray.count);
    return self.shouFeiArrray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
     
    static NSString * cellIdentifer = @"cell";
    NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"ShouFeiTableViewCell" owner:nil options:nil];
    
    ShouFeiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if (!cell)
    {
        cell = xibArray[0];
      
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    NSDictionary *dic = [self.shouFeiArrray objectAtIndex:indexPath.row];
    cell.baoDanLabel.text = [dic objectForKey:@"policyCode"];
    
    int a = [[dic objectForKey:@"payMode"] integerValue];
    if (a == 1)
    {
       cell.fangShiLabel.text = @"现金";
    }
    else
    {
       cell.fangShiLabel.text = @"银行转账";
    }
   // cell.fangShiLabel.text = [dic objectForKey:@"payMode"]  ;
    
    
    cell.yinHangLabel.text = [dic objectForKey:@"bankCode"];
    cell.zhangHaoLabel.text = [dic objectForKey:@"bankAccount"];
    cell.suoYouRenLabel.text = [dic objectForKey:@"accountOwner"];
    
    cell.xuanzeBtn.tag=indexPath.row;
    [cell.xuanzeBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    [cell.xuanzeBtn addTarget:self action:@selector(xuanZhongBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i=0; i<self.chooseArray.count; i++)
    {
        if ([[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"] isEqualToString:[[self.shouFeiArrray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]])
        {
            [cell.xuanzeBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
            break;
        }
    }
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    //ShouFeiXiangQingView *bigShouFeiView = (ShouFeiXiangQingView *)[ShouFeiXiangQingView awakeFromNib];
    ShouFeiXiangQingView *bigShouFeiView = [ShouFeiXiangQingView sharedManager];
    bigShouFeiView.alpha=1;
    bigShouFeiView.tag=20000;
    bigShouFeiView.frame = CGRectMake(1024, 64, 944, 704);
    bigShouFeiView.backgroundColor = [UIColor clearColor];
    [[self superview] addSubview:bigShouFeiView];
    
    [UIView animateWithDuration:1 animations:^
    {
      
        bigShouFeiView.frame = CGRectMake(0, 64, 1024, 704);
        
    } completion:^(BOOL finished)
    {
        nil;
        
    }];
    */
    BOOL  isChoose=YES;
    for (int i=0;i<self.chooseArray.count;i++) {
        NSString *str=[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.shouFeiArrray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]]) {
            [self.chooseArray removeObjectAtIndex:i];
            isChoose=NO;
            [self.allChooseBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
            break;
        }
        
    }
    if (isChoose) {
        //未选择，就添加
        [self.chooseArray addObject:[self.shouFeiArrray objectAtIndex:indexPath.row]];
        if (self.chooseArray.count==self.shouFeiArrray.count) {
            [self.allChooseBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [self.shouFeiTableView reloadData];
    
    
}

//单选
-(void)xuanZhongBtnClick:(UIButton *)sender
{
    BOOL  isChoose=YES;
    for (int i=0;i<self.chooseArray.count;i++) {
        NSString *str=[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.shouFeiArrray objectAtIndex:sender.tag] objectForKey:@"policyCode"]]) {
            [self.chooseArray removeObjectAtIndex:i];
            isChoose=NO;
        [self.allChooseBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
            break;
        }
   
    }
    if (isChoose) {
        //未选择，就添加
        [self.chooseArray addObject:[self.shouFeiArrray objectAtIndex:sender.tag]];
        if (self.chooseArray.count==self.shouFeiArrray.count) {
            [self.allChooseBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [self.shouFeiTableView reloadData];
    
    
}


- (IBAction)quanxuanBtnClick:(UIButton *)sender
{

    if (self.chooseArray.count!=self.shouFeiArrray.count) {
        //表示全选
        sender.tag=50;
        [sender setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        [self.chooseArray removeAllObjects];
        for (NSDictionary *str in self.shouFeiArrray) {
            [self.chooseArray addObject:str];
        }
        [self.shouFeiTableView reloadData];
        return;
    }
    if (self.chooseArray.count==self.shouFeiArrray.count) {
        //全部不选
        [self.chooseArray removeAllObjects];
        sender.tag=100;
        [sender setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
        [self.shouFeiTableView reloadData];
    }
    
    
}

- (IBAction)quedingBtnClick:(id)sender
{
    if (self.chooseArray.count == 0)
    {
        [self alertView:@"请选择保单后再进行操作！"];
        return;
    }
    
    NSLog(@" 字典  %@ ",self.chooseArray);
    
   // ShouFeiXiangQingView *bigShouFeiView = [ShouFeiXiangQingView sharedManager];
    
    ShouFeiXiangQingView *bigShouFeiView = [ShouFeiXiangQingView awakeFromNib];
    bigShouFeiView.alpha=1;
    [bigShouFeiView sizeToFit];
    bigShouFeiView.tag=20000;
    bigShouFeiView.detailArray = self.chooseArray;
    bigShouFeiView.chargView.bankTextField.text = @"";
    bigShouFeiView.chargView.acountTextField.text = @"";
    bigShouFeiView.chargView.organizationTextField.text = @"";
    bigShouFeiView.frame = CGRectMake(1024, 64, 944, 704);
    bigShouFeiView.backgroundColor = [UIColor clearColor];
    [[self superview] addSubview:bigShouFeiView];
    
    [UIView animateWithDuration:1 animations:^
     {
         
         bigShouFeiView.frame = CGRectMake(0, 64, 1024, 704);
         
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
