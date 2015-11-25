//
//  TongZhiBianGengView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/23.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "TongZhiBianGengView.h"
#import "BaoDanXiangQingView.h"
#import "TongZhiBianTableViewCell.h"
#import "PreserveServer-Prefix.pch"
#define YONGJIUSHIXIAOURL @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.QueryPreserveServlet"


@implementation TongZhiBianGengView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//+(UIView*)awakeFromNib
//{
//    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"TongZhiBianGengView" owner:self options:nil];
//    
//    
//    return [array lastObject];
//}
{
    BaoDanXiangQingView *baoDanV;
}


+(TongZhiBianGengView *)awakeFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"TongZhiBianGengView" owner:nil options:nil] objectAtIndex:0];
}

- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}


-(void)custemView
{
    self.tabArray = [[NSMutableArray alloc] init];
    self.tabDic = [[NSDictionary alloc] init];
    self.baoDanTabelView.rowHeight=35;
    [self requestNumber];
    
}

- (void)requestNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,YONGJIUSHIXIAOURL]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            NSDictionary *dic = [[TPLSessionInfo shareInstance] custmerDic];
            
            listBOModel=[remoteService queryPermanentFailureNoticeWayWithCustomerId:[dic objectForKey:@"customerId"]];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
        NSLog(@">>>>>>>>>>>>>yjmc%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++) {
            [self.tabArray addObject:[listBOModel.objList objectAtIndex:i]];
           // NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
            //   NSLog(@"%@",dic);
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
                          
                           [self.baoDanTabelView reloadData];
                           [self custemFrame];
                       });
       
     });

    
}
 
-(void)custemFrame{
    if (35*self.tabArray.count>603) {
        self.baoDanTabelView.frame=CGRectMake(0, 35, 776, 603);
       // self.quanxuanView.frame = CGRectMake(0, 35, 844, 603);
        
    }else{
        self.baoDanTabelView.frame=CGRectMake(0, 35, 776, 35*self.tabArray.count);
        //self.quanxuanView.frame = CGRectMake(0, 35+35*self.shouFeiArrray.count, 844, 35);
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
    NSLog(@" mmmmm%lu",(unsigned long)self.tabArray.count);
    return self.tabArray.count;
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
    
    NSString * cellIdentifer = @"cell";
    NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"TongZhiBianTableViewCell" owner:nil options:nil];
    
    TongZhiBianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];

    if (!cell)
    {
        cell = xibArray[0];
        
    }
    self.tabDic = [self.tabArray objectAtIndex:indexPath.row];
    cell.rowNumberLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.ownerLabel.text = [self.tabDic objectForKey:@"insuredName"];
    cell.baoDanNumberLabel.text = [self.tabDic objectForKey:@"policyCode"];
    cell.stateLabel.text = [self.tabDic objectForKey:@"liabilityStateName"];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   // BaoDanXiangQingView *baoDanV = [BaoDanXiangQingView sharedManager];
    if (baoDanV)
    {
        [baoDanV removeFromSuperview];
    }
    baoDanV = [BaoDanXiangQingView awakeFromNib];
    baoDanV.alpha=1;
    
    baoDanV.tag = 20000;
    baoDanV.detailDic = self.tabDic;
    [baoDanV sizeToFit];
    //NSLog(@"z0zzz%@ ",self.tabDic);
    baoDanV.frame = CGRectMake(1024, 64, 1024, 704);
    baoDanV.backgroundColor = [UIColor clearColor];
    [[self superview] addSubview:baoDanV];
    
    [UIView animateWithDuration:1 animations:^
     {
         
         baoDanV.frame = CGRectMake(0, 64, 1024, 704);
         
         
     } completion:^(BOOL finished)
     {
         nil;
         
     }];
    
}





@end
