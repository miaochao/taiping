//
//  NianJinLingQuFangShiBianGengView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/15.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "NianJinLingQuFangShiBianGengView.h"
#import "ThreeViewController.h"
#import "PreserveServer-Prefix.pch"

#define NIANJINLINGQUURL @"/servlet/hessian/com.cntaiping.intserv.custserv.draw.QueryDrawAccountServlet"
#define NIANJINBIANGENG @"/servlet/hessian/com.cntaiping.intserv.custserv.draw.UpdateBonusWayServlet"


@implementation NianJinLingQuFangShiBianGengView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
{
    UITableView *nianJinTabV;
    NianJinLingQuFangShiBianGengXiangQingView *bigtouLianView;
}


+ (NianJinLingQuFangShiBianGengView *)awakeFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"NianJinLingQuFangShiBianGengView" owner:nil options:nil] objectAtIndex:0];
}

- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}

- (void)custemView
{
    nianJinTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 776, 105) style:UITableViewStylePlain];
    nianJinTabV.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1];
    //lingQuTouLianTabv.backgroundColor=[UIColor redColor];
    [self addSubview:nianJinTabV];
    nianJinTabV.rowHeight = 35;
    nianJinTabV.delegate = self;
    nianJinTabV.dataSource =self;
    
    
    self.quanArray = [[NSMutableArray alloc] init];
    self.chooseArray = [[NSMutableArray alloc] init];
    //    NSDictionary *dic=@{@"number":@"15300990549000",@"name":@"第一主险"};
    //    [self.quanArray addObject:dic];
    //    NSDictionary *dic1=@{@"number":@"18398080985003",@"name":@"第一主险"};
    //    [self.quanArray addObject:dic1];
    //    NSDictionary *dic2=@{@"number":@"15308573878799",@"name":@"第一主险"};
    //    [self.quanArray addObject:dic2];
    
    [self requestNumber];
}


- (void)requestNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,NIANJINLINGQUURL]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            NSDictionary *dic = [[TPLSessionInfo shareInstance] custmerDic];
            listBOModel=[remoteService queryAnnuityWayWithCustomerID:[dic objectForKey:@"customerId"]];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
        //  NSLog(@">>>>>>>>>>>>>lqtlzmc%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++)
        {
            [self.quanArray addObject:[listBOModel.objList objectAtIndex:i]];
            //            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
            //            NSLog(@"%@",dic);
            
        }
        NSLog(@"njlqqqqqq%@",listBOModel.objList);
        // receiveArray=[NSMutableArray arrayWithArray:self.tabArray];
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           NSString *errorStr = [listBOModel.errorBean errorInfo];
                           if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"])
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                               [alert show];
                               return;
                               
                           }
                           [nianJinTabV reloadData];
                           [self custemFrame];
                       });
        
    });
    
}

-(void)custemFrame{
    if (35*self.quanArray.count>600) {
        nianJinTabV.frame=CGRectMake(0, 35, 776, 385);
        self.quanxuanView.frame = CGRectMake(0, 420, 776, 35);
        self.quddingBtn.frame = CGRectMake(686, 440+35, 90, 35);
        
    }else{
        nianJinTabV.frame=CGRectMake(0, 35, 776, 35*self.quanArray.count);
        self.quanxuanView.frame = CGRectMake(0, 35*self.quanArray.count-104, 776, 35);
        self.quddingBtn.frame = CGRectMake(681, 35*self.quanArray.count+50-104, 90, 35);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.quanArray.count;
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NianJinLingQuFangShiBianGengViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[NianJinLingQuFangShiBianGengViewCell alloc] initWithFrame:CGRectMake(0, 0, 776, 35)];
    }
    
    NSDictionary *dic=[self.quanArray objectAtIndex:indexPath.row];
    cell.baodanhaoLabel.text = [dic objectForKey:@"policyCode"];
    cell.zhuXianLabel.text = [dic objectForKey:@"productName"];
    
    cell.xuanZeBtn.tag=indexPath.row;
    [cell.xuanZeBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    [cell.xuanZeBtn addTarget:self action:@selector(danxuanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i=0; i<self.chooseArray.count; i++)
    {
        if ([[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"] isEqualToString:[[self.quanArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]])
        {
            [cell.xuanZeBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL  isChoose=YES;
    for (int i=0;i<self.chooseArray.count;i++) {
        NSString *str=[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.quanArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]]) {
            [self.chooseArray removeObjectAtIndex:i];
            isChoose=NO;
            [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
            break;
        }
    }
    if (isChoose) {
        //未选择，就添加
        [self.chooseArray addObject:[self.quanArray objectAtIndex:indexPath.row]];
        if (self.chooseArray.count==self.quanArray.count) {
            [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [nianJinTabV reloadData];
    
}

- (IBAction)jiazhiQueDingBtnClick:(id)sender
{
    if (self.chooseArray.count == 0)
    {
        [self alertView:@"请选择保单后再进行操作！"];
        return;
    }
    if (bigtouLianView) {
        [bigtouLianView removeFromSuperview];
    }
    
    bigtouLianView = [[[NSBundle mainBundle] loadNibNamed:@"NianJinLingQuFangShiBianGengView" owner:self options:nil] objectAtIndex:2];
    bigtouLianView.alpha=1;
    [bigtouLianView sizeToFit];
    bigtouLianView.tag=20000;
    bigtouLianView.huodeArray = self.chooseArray;
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

- (IBAction)quanxuanBtnClick:(UIButton *)sender
{
    //    if (sender.tag==8051) {
    //        //表示全选
    //        sender.tag=8052;
    //        [sender setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
    //        [self.chooseArray removeAllObjects];
    //        for (NSString *str in self.quanArray) {
    //            [self.chooseArray addObject:str];
    //        }
    //        [nianJinTabV reloadData];
    //        return;
    //    }
    //    if (sender.tag==8052) {
    //        //全部不选
    //        [self.chooseArray removeAllObjects];
    //        sender.tag=8051;
    //        [sender setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    //        [nianJinTabV reloadData];
    //    }
    
    if (self.chooseArray.count!=self.quanArray.count) {
        //表示全选
        sender.tag=8052;
        [sender setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        [self.chooseArray removeAllObjects];
        for (NSDictionary *str in self.quanArray) {
            [self.chooseArray addObject:str];
        }
        [nianJinTabV reloadData];
        return;
    }
    if (self.chooseArray.count==self.quanArray.count) {
        //全部不选
        [self.chooseArray removeAllObjects];
        sender.tag=8051;
        [sender setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
        [nianJinTabV reloadData];
    }
    
}

-(void)danxuanBtnClick:(UIButton *)btn
{
    BOOL  isChoose=YES;
    for (int i=0;i<self.chooseArray.count;i++) {
        NSString *str=[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.quanArray objectAtIndex:btn.tag] objectForKey:@"policyCode"]]) {
            [self.chooseArray removeObjectAtIndex:i];
            isChoose=NO;
            [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
            break;
        }
        
    }
    if (isChoose) {
        //未选择，就添加
        [self.chooseArray addObject:[self.quanArray objectAtIndex:btn.tag]];
        if (self.chooseArray.count==self.quanArray.count) {
            [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [nianJinTabV reloadData];
    
    
}



-(void)alertView:(NSString *)str{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertV show];
}



@end


@implementation NianJinLingQuFangShiBianGengViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"NianJinLingQuFangShiBianGengView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}


@end


@implementation NianJinLingQuFangShiBianGengXiangQingView

{
    UITableView *xiangQingBigTabv;
    UIView *nianView;
    UIView *fangView;
    BjcaInterfaceView *mypackage;//CA拍照
    
}

+(NianJinLingQuFangShiBianGengXiangQingView *)awakeFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"NianJinLingQuFangShiBianGengView" owner:nil options:nil] objectAtIndex:2];
    
}

- (void)sizeToFit
{
    [super sizeToFit];
    
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
    
    
    [self custemView];
}


-(void)custemView
{
    //创建表
    xiangQingBigTabv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 712, 637)];
    [self.xiangQingView addSubview:xiangQingBigTabv];
    xiangQingBigTabv.rowHeight = 36;
    xiangQingBigTabv.delegate = self;
    xiangQingBigTabv.dataSource = self;
    
    self.queDingView.layer.borderWidth = 1;
    self.queDingView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    
    self.detailArray = [[NSMutableArray alloc] init];
    self.quanbuArray = [[NSMutableArray alloc] init];
    self.chooseArray = [[NSMutableArray alloc] init];
    self.huodeArray =  [[NSMutableArray alloc] init];
    self.mArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<3; i++)
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [self.chooseArray addObject:array];
    }
    
    
    /*
     self.smallArray1 = [[NSMutableArray alloc] init];
     self.smallArray2 = [[NSMutableArray alloc] init];
     self.smallArray3 = [[NSMutableArray alloc] init];
     
     NSDictionary *dic1 = @{@"xuhao":@"10001001",@"mingcheng":@"xxxx保险",@"baoe":@"10000",@"qixian":@"年交"};
     [self.smallArray1 addObject:dic1];
     NSDictionary *dic2 = @{@"xuhao":@"10001022",@"mingcheng":@"xxxx保险",@"baoe":@"20000",@"qixian":@"年交"};
     [self.smallArray1 addObject:dic2];
     
     NSDictionary *dic3 = @{@"xuhao":@"10001335",@"mingcheng":@"xxxx保险",@"baoe":@"10000",@"qixian":@"年交"};
     [self.smallArray2 addObject:dic3];
     NSDictionary *dic4 = @{@"xuhao":@"10004444",@"mingcheng":@"xxxx保险",@"baoe":@"20000",@"qixian":@"年交"};
     [self.smallArray2 addObject:dic4];
     
     NSDictionary *dic5 = @{@"xuhao":@"10001555",@"mingcheng":@"xxxx保险",@"baoe":@"10000",@"qixian":@"年交"};
     [self.smallArray3 addObject:dic5];
     NSDictionary *dic6 = @{@"xuhao":@"10001666",@"mingcheng":@"xxxx保险",@"baoe":@"20000",@"qixian":@"年交"};
     [self.smallArray3 addObject:dic6];
     
     [self.detailArray addObject:self.smallArray1];
     [self.detailArray addObject:self.smallArray2];
     [self.detailArray addObject:self.smallArray3];
     
     */
    
    [self requestDetailNumber];
    
}


- (void)requestDetailNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,NIANJINLINGQUURL]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (int i = 0; i<self.huodeArray.count ; i++)
            {
                NSDictionary *huodeDic = [self.huodeArray objectAtIndex:i];
                NSString *huodeStr = [huodeDic objectForKey:@"policyCode"];
                [resultArray addObject:huodeStr];
            }
            listBOModel=[remoteService queryAnnuityWayDetailWithPolityArray:resultArray];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
        //  NSLog(@">>>>>>>>>>>>>lqtlzmc%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++)
        {
            [self.detailArray addObject:[listBOModel.objList objectAtIndex:i]];
            //            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
            //            NSLog(@"%@",dic);
        }
        //NSLog(@"njlqqqqqqxxxxqq%@",listBOModel.objList);
        NSLog(@" xxxqq  %@ ",self.detailArray);
        for (int a = 0; a< self.detailArray.count; a++)
        {
            NSDictionary *dic1 = [self.detailArray objectAtIndex:a];
            // NSLog(@" mmm %@ ",dic1);
            NSMutableArray *array1 = [dic1 objectForKey:@"productInfoList"];
            
            [self.mArray addObject:array1];
            
        }
        // NSLog(@" 输出 %@",self.mArray);
        
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           NSString *errorStr = [listBOModel.errorBean errorInfo];
                           if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"])
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                               [alert show];
                               return;
                               
                           }
                           [xiangQingBigTabv reloadData];
                           //[self custemFrame];
                           //用来标记全选是否选中
                           for (int b = 0; b<self.detailArray.count; b++)
                           {
                               NSString *biaoJiString1 = @"0";
                               [self.quanbuArray addObject:biaoJiString1];
                           }
                           
                       });
    });
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.mArray objectAtIndex:section] count];
    //    if (section == 0)
    //    {
    //       return self.smallArray1.count;
    //    }
    //    else if (section == 1)
    //    {
    //        return self.smallArray2.count;
    //    }
    //    else
    //    {
    //        return self.smallArray3.count;
    //    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 72;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 36;
}

//区尾
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    TableFootView *smallFootView = [TableFootView awakeFromNib];
    [smallFootView sizeToFit];
    [smallFootView.quanXuanBtn addTarget:self action:@selector(quanBuXuanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    smallFootView.quanXuanBtn.tag = 1300+section+1;
    
    NSString *str=[self.quanbuArray objectAtIndex:section];
    if ([str isEqual:@"1"]) {
        //证明全选有
        [smallFootView.quanXuanBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
    }
    return smallFootView;
}

//区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NianJinLingQuSmallXiangQingView *smallXiangView = [NianJinLingQuSmallXiangQingView awakeFromNib];
    [smallXiangView sizeToFit];
    smallXiangView.layer.borderWidth = 1;
    NSString *titleStr = [[self.huodeArray objectAtIndex:section] objectForKey:@"policyCode"];
    
    smallXiangView.titleLabel.text = [NSString stringWithFormat:@"保单号： %@",titleStr];
    smallXiangView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    
    return smallXiangView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ldffff",(long)indexPath.row);
    
    NianJinLingQuSmallXiangQingViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell)
    {
        cell = [[NianJinLingQuSmallXiangQingViewCell alloc] initWithFrame:CGRectMake(0, 0, 776, 35)];
    }
    
    NSMutableArray *smallArray = [self.mArray objectAtIndex:indexPath.section];
    NSDictionary *dic = [smallArray objectAtIndex:indexPath.row];
    
    cell.xianZhongLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"productNumber"]];
    
    cell.mingChengLabel.text = [dic objectForKey:@"productName"];
    cell.baoELabel.text = [NSString stringWithFormat:@"%@/%@/%@",[dic objectForKey:@"amount"],[dic objectForKey:@"benefitLevel"],[dic objectForKey:@"unit"]];
    //cell.qiXianLabel.text = [dic objectForKey:@"initialType"];
    NSDate *date1 = [dic objectForKey:@"startPayDate"];
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString* s1 = [df stringFromDate:date1];
    cell.lingQuNianLingLabel.text = s1;
    //设置 领取年限按钮的图片
    int nianxian = [[dic objectForKey:@"payEnsure"] integerValue];
    [cell.lingQuNIanXianBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",nianxian]] forState:UIControlStateNormal];
    
    //设置 领取方式按钮的图片
    //    NSLog(@" 88888%@ ",[dic objectForKey:@"payType"]);
    //    [cell.lingQuFangShiBtn setImage:[UIImage imageNamed:[dic objectForKey:@"payType"]] forState:UIControlStateNormal];
    
    
    [cell.danxuanBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    
    [cell.danxuanBtn addTarget:self action:@selector(danXuanChooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.danxuanBtn.tag = (indexPath.section+1)*100+indexPath.row;
    
    //    NSString *str=[self.quanbuArray objectAtIndex:indexPath.section];//选择哪个区
    //    if ([str isEqualToString:@"0"])
    //    {}
    for (int i=0; i<[[self.chooseArray objectAtIndex:indexPath.section] count]; i++)
    {
        if ([[[[self.chooseArray objectAtIndex:indexPath.section] objectAtIndex:i ] objectForKey:@"productNumber"] isEqualToString:[[smallArray objectAtIndex:indexPath.row] objectForKey:@"productNumber"]])
        {
            [cell.danxuanBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
            break;
        }
    }
    
    [cell.lingQuNIanXianBtn addTarget:self action:@selector(nianXianBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.lingQuNIanXianBtn.tag = 500*(indexPath.section +1)+indexPath.row;
    [cell.lingQuFangShiBtn addTarget:self action:@selector(fangshiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.lingQuFangShiBtn.tag = 600*(indexPath.section +1)+indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)danXuanChooseBtnClick:(UIButton *)sender
{
    BOOL  isChoose=YES;
    int    section=sender.tag/100-1;//得到那个区
    for (int i=0;i<[[self.chooseArray objectAtIndex:section] count];i++) {
        NSString *str=[[[self.chooseArray objectAtIndex:section] objectAtIndex:i] objectForKey:@"productNumber"];
        
        //        for (int j=0; j<[[self.detailArray objectAtIndex:section] count]; j++) {
        //            if ([str isEqualToString:[[[self.detailArray objectAtIndex:section] objectAtIndex:j] objectForKey:@"xuhao"]]) {
        //                [[self.chooseArray objectAtIndex:section] removeObjectAtIndex:i];
        //                isChoose=NO;
        //                break;
        //            }
        //        }
        if ([str isEqualToString:[[[self.mArray objectAtIndex:section] objectAtIndex:sender.tag%100] objectForKey:@"productNumber"]]) {
            [[self.chooseArray objectAtIndex:section] removeObjectAtIndex:i];
            isChoose=NO;
            [self.quanbuArray replaceObjectAtIndex:section withObject:@"0"];
            break;
        }
        
        
    }
    if (isChoose) {
        //未选择，就添加
        [[self.chooseArray objectAtIndex:section] addObject:[[self.mArray objectAtIndex:section] objectAtIndex:sender.tag%100]];
        if ([[self.chooseArray objectAtIndex:section] count]==[[self.mArray objectAtIndex:section] count]) {
            //说明选择完了
            [self.quanbuArray replaceObjectAtIndex:section withObject:@"1"];
            
        }
    }
    [xiangQingBigTabv reloadData];
    
}

-(void)quanBuXuanBtnClick:(UIButton *)sender
{
    int num=sender.tag%1300-1;
    if ([[self.quanbuArray objectAtIndex:num] isEqualToString:@"0"]) {
        //表示还未选择
        [[self.chooseArray objectAtIndex:num] removeAllObjects];
        for (int i=0; i<[[self.mArray objectAtIndex:num] count]; i++) {
            NSMutableArray *array=[self.mArray objectAtIndex:num];
            [[self.chooseArray objectAtIndex:num] addObject:[array objectAtIndex:i]];
        }
        [self.quanbuArray replaceObjectAtIndex:num withObject:@"1"];
    }else{
        //证明已经是全选了
        [[self.chooseArray objectAtIndex:num] removeAllObjects];
        [self.quanbuArray replaceObjectAtIndex:num withObject:@"0"];
        
    }
    [xiangQingBigTabv reloadData];
    return;
    
    if (sender.tag == 1301)
    {
        
        [xiangQingBigTabv reloadData];
    }
    else if (sender.tag == 1302)
    {
        [[self.chooseArray objectAtIndex:1] removeAllObjects];
        for (int i=0; i<[[self.mArray objectAtIndex:1] count]; i++) {
            [[self.chooseArray objectAtIndex:1] addObject:[[self.mArray objectAtIndex:1] objectAtIndex:i ]];
        }
        
        
        [sender setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        [xiangQingBigTabv reloadData];
    }
    else
    {
        [[self.chooseArray objectAtIndex:2] removeAllObjects];
        for (int i=0; i<[[self.mArray objectAtIndex:2] count]; i++) {
            [[self.chooseArray objectAtIndex:2] addObject:[[self.mArray objectAtIndex:2] objectAtIndex:i ]];
        }
        
        [sender setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        [xiangQingBigTabv reloadData];
        
    }
    
}

- (IBAction)yinCangBtnClick:(id)sender
{
    [UIView animateWithDuration:1 animations:^{
        self.frame = CGRectMake(1024, 64, 1024, 704);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}


//变更请求
-(void)updateNianJinNumber
{
    //updateAnnuityWayWithpolicyCode
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,NIANJINBIANGENG]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLChangeReturnBOModel> changeReturnBOModel=nil;
        @try {
            
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (int i = 0; i<self.huodeArray.count ; i++)
            {
                NSDictionary *huodeDic = [self.huodeArray objectAtIndex:i];
                NSString *huodeStr = [huodeDic objectForKey:@"policyCode"];
                [resultArray addObject:huodeStr];
            }
            //changeReturnBOModel=[remoteService updateAnnuityWayWithpolicyCode:<#(NSString *)#> bizChannel:<#(NSString *)#> list:<#(NSArray *)#>];
            
            NSLog(@" 9999 %@ ",self.detailArray);
            
            changeReturnBOModel=[remoteService updateAnnuityWayWithPolicyList:self.detailArray];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
        NSLog(@" njbggg%@ ",changeReturnBOModel);
        
        
    });
    
}

//确定变更
- (IBAction)queDingBianGengBtnClick:(id)sender
{
    
         [self updateNianJinNumber];
        MessageTestView *messV = [[MessageTestView alloc] init];
        messV.frame = CGRectMake(0, 0, 1024, 768);
        messV.delegate=self;
        messV.backgroundColor = [UIColor clearColor];
        ThreeViewController *threeVC = [ThreeViewController sharedManager];
        [threeVC.view addSubview:messV];
    
}

-(void)massageTest{
//    WriteNameView  *view=[[WriteNameView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
//    view.delegate=self;
//    [[self superview] addSubview:view];
    
    [mypackage reset];//先清空之前的数据
    [self startinterface];
    
}
-(void)writeNameEnd{
    BaoQuanPiWenView *view=(BaoQuanPiWenView *)[BaoQuanPiWenView awakeFromNib];
    //    view.frame
    [[self superview] addSubview:view];
    self.alpha=0;
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



- (void)nianXianBtnClick:(UIButton *)btn
{
    NSLog(@"  大ppppppppp%ld ",(long)btn.tag);
    if (nianView)
    {
        [nianView removeFromSuperview];
    }
    nianView = [[UIView alloc] init];
    
    //NSArray *tabArray=[xiangQingBigTabv visibleCells];
    //NSLog(@"输出 999 %lu  ",(unsigned long)tabArray.count);
    //        ProportionChangeDetailCell *cell=[array objectAtIndex:i];
    
    NianJinLingQuSmallXiangQingViewCell *cell = (NianJinLingQuSmallXiangQingViewCell *)[[[btn superview] superview] superview];
    //获取到cell 进而设置弹出view位置
    nianView.frame = CGRectMake(530, cell.frame.origin.y+32 , 85, 138);
    
    nianView.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1];
    [xiangQingBigTabv  addSubview:nianView];
    
    for (int i = 0; i< 6; i ++)
    {
        UIButton *nianbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        nianbtn.frame = CGRectMake(1, 1+23*i, 85, 22);
        nianbtn.tag = btn.tag+(i+1)*10000;
        NSString *string = [NSString stringWithFormat:@"%d",(5*i)];
        [nianbtn setTitle:string forState:UIControlStateNormal];
        [nianbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        nianbtn.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        [nianbtn addTarget:self action:@selector(smallNianBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [nianView addSubview:nianbtn];
    }
    
}


- (void)fangshiBtnClick:(UIButton *)btn
{
    // NSLog(@" 方式  %ld",(long)btn.tag);
    if (fangView)
    {
        [fangView removeFromSuperview];
    }
    fangView = [[UIView alloc] init];
    
    NianJinLingQuSmallXiangQingViewCell *cell = (NianJinLingQuSmallXiangQingViewCell *)[[[btn superview] superview] superview];
    
    fangView.frame = CGRectMake(622, cell.frame.origin.y+32 , 85, 68);
    
    //WithFrame:CGRectMake(530, 100+35*(btn.tag-300) , 85, 138)];
    
    fangView.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1];
    [xiangQingBigTabv  addSubview:fangView];
    
    for (int i = 0; i< 3; i ++)
    {
        UIButton *fangbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        fangbtn.frame = CGRectMake(1, 1+23*i, 85, 22);
        
        if (i == 0)
        {
            [fangbtn setTitle:@"年领" forState:UIControlStateNormal];
        }
        else if (i == 1)
        {
            [fangbtn setTitle:@"月领" forState:UIControlStateNormal];
        }
        else
        {
            [fangbtn setTitle:@"趸领" forState:UIControlStateNormal];
        }
        
        [fangbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        fangbtn.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        fangbtn.tag = btn.tag+100000*(i+1);
        [fangbtn addTarget:self action:@selector(smallFangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [fangView addSubview:fangbtn];
    }
    
}

- (void)smallNianBtnClick:(UIButton *)btn
{
    NSLog(@"小9999nnn 的值%ld ",(long)btn.tag);
    
    
    [UIView animateWithDuration:0.1 animations:^
     {
         
         //             UIButton *button = (UIButton *)[self viewWithTag:btn.tag-2];
         //             [button setImage:[UIImage imageNamed:@"0.png"] forState:UIControlStateNormal];
         [btn setBackgroundColor:[UIColor colorWithRed:0 green:151/255.0 blue:255.0 alpha:1]];
         if (btn.tag/10000 == 1)
         {
             long btnTgOne = btn.tag -10000;
             UIButton *button = (UIButton *)[self viewWithTag:btnTgOne];
             [button setImage:[UIImage imageNamed:@"0.png"] forState:UIControlStateNormal];
             int btnSection = btnTgOne/500-1;
             int btnRow = btnTgOne%500;
             NSDictionary *dic1 = [self.detailArray objectAtIndex:btnSection];
             NSMutableArray *array1 = [dic1 objectForKey:@"productInfoList"];
             NSMutableDictionary *dic = [array1 objectAtIndex:btnRow];
             int a = 0;
             NSNumber *myNumber = [NSNumber numberWithInt:a];
             [dic setObject:myNumber forKey:@"payEnsure"];
             //[dic setObject:@"0" forKey:@"payEnsure"];
             
         }
         else if (btn.tag/10000 == 2)
         {
             long btnTgOne = btn.tag -20000;
             UIButton *button = (UIButton *)[self viewWithTag:btnTgOne];
             [button setImage:[UIImage imageNamed:@"5.png"] forState:UIControlStateNormal];
             int btnSection = btnTgOne/500-1;
             int btnRow = btnTgOne%500;
             //             NSMutableArray *smallArray = [self.mArray objectAtIndex:btnSection];
             //             NSMutableDictionary *dic = [smallArray objectAtIndex:btnRow];
             NSDictionary *dic1 = [self.detailArray objectAtIndex:btnSection];
             NSMutableArray *array1 = [dic1 objectForKey:@"productInfoList"];
             NSMutableDictionary *dic = [array1 objectAtIndex:btnRow];
             int a = 5;
             NSNumber *myNumber = [NSNumber numberWithInt:a];
             [dic setObject:myNumber forKey:@"payEnsure"];
             // [dic setObject:@"5" forKey:@"payEnsure"];
             
         }
         else if (btn.tag/10000 == 3)
         {
             long btnTgOne = btn.tag -30000;
             UIButton *button = (UIButton *)[self viewWithTag:btnTgOne];
             [button setImage:[UIImage imageNamed:@"10.png"] forState:UIControlStateNormal];
             int btnSection = btnTgOne/500-1;
             int btnRow = btnTgOne%500;
             //             NSMutableArray *smallArray = [self.mArray objectAtIndex:btnSection];
             //             NSMutableDictionary *dic = [smallArray objectAtIndex:btnRow];
             NSDictionary *dic1 = [self.detailArray objectAtIndex:btnSection];
             NSMutableArray *array1 = [dic1 objectForKey:@"productInfoList"];
             NSMutableDictionary *dic = [array1 objectAtIndex:btnRow];
             int a = 10;
             NSNumber *myNumber = [NSNumber numberWithInt:a];
             [dic setObject:myNumber forKey:@"payEnsure"];
             //   [dic setObject:@"10" forKey:@"payEnsure"];
         }
         else if (btn.tag/10000 == 4)
         {
             long btnTgOne = btn.tag -40000;
             UIButton *button = (UIButton *)[self viewWithTag:btnTgOne];
             [button setImage:[UIImage imageNamed:@"15.png"] forState:UIControlStateNormal];
             int btnSection = btnTgOne/500-1;
             int btnRow = btnTgOne%500;
             //             NSMutableArray *smallArray = [self.mArray objectAtIndex:btnSection];
             //             NSMutableDictionary *dic = [smallArray objectAtIndex:btnRow];
             NSDictionary *dic1 = [self.detailArray objectAtIndex:btnSection];
             NSMutableArray *array1 = [dic1 objectForKey:@"productInfoList"];
             NSMutableDictionary *dic = [array1 objectAtIndex:btnRow];
             int a = 15;
             NSNumber *myNumber = [NSNumber numberWithInt:a];
             [dic setObject:myNumber forKey:@"payEnsure"];
             //  [dic setObject:@"15" forKey:@"payEnsure"];
             
         }
         else if (btn.tag/10000 == 5)
         {
             long btnTgOne = btn.tag -50000;
             UIButton *button = (UIButton *)[self viewWithTag:btnTgOne];
             [button setImage:[UIImage imageNamed:@"20.png"] forState:UIControlStateNormal];
             int btnSection = btnTgOne/500-1;
             int btnRow = btnTgOne%500;
             //             NSMutableArray *smallArray = [self.mArray objectAtIndex:btnSection];
             //             NSMutableDictionary *dic = [smallArray objectAtIndex:btnRow];
             NSDictionary *dic1 = [self.detailArray objectAtIndex:btnSection];
             NSMutableArray *array1 = [dic1 objectForKey:@"productInfoList"];
             NSMutableDictionary *dic = [array1 objectAtIndex:btnRow];
             int a = 20;
             NSNumber *myNumber = [NSNumber numberWithInt:a];
             [dic setObject:myNumber forKey:@"payEnsure"];
             //  [dic setObject:@"20" forKey:@"payEnsure"];
         }
         else
         {
             long btnTgOne = btn.tag -60000;
             UIButton *button = (UIButton *)[self viewWithTag:btnTgOne];
             [button setImage:[UIImage imageNamed:@"25.png"] forState:UIControlStateNormal];
             int btnSection = btnTgOne/500-1;
             int btnRow = btnTgOne%500;
             //             NSMutableArray *smallArray = [self.mArray objectAtIndex:btnSection];
             //             NSMutableDictionary *dic = [smallArray objectAtIndex:btnRow];
             NSDictionary *dic1 = [self.detailArray objectAtIndex:btnSection];
             NSMutableArray *array1 = [dic1 objectForKey:@"productInfoList"];
             NSMutableDictionary *dic = [array1 objectAtIndex:btnRow];
             int a = 25;
             NSNumber *myNumber = [NSNumber numberWithInt:a];
             [dic setObject:myNumber forKey:@"payEnsure"];
             // [dic setObject:@"25" forKey:@"payEnsure"];
             
         }
         
         
     } completion:^(BOOL finished)
     {
         
         [[btn superview] removeFromSuperview];
     }];
    
}

-(void)smallFangBtnClick:(UIButton *)btn
{
    NSLog(@"按钮 的值%ld ",(long)btn.tag);
    
    
    [UIView animateWithDuration:0.1 animations:^
     {
         [btn setBackgroundColor:[UIColor colorWithRed:0 green:151/255.0 blue:255.0 alpha:1]];
         if (btn.tag/100000 == 1)
         {
             long btnTgOne = btn.tag - 100000;
             UIButton *button = (UIButton *)[self viewWithTag:btnTgOne];
             [button setImage:[UIImage imageNamed:@"nianling.png"] forState:UIControlStateNormal];
             int btnSection = btnTgOne/600-1;
             int btnRow = btnTgOne%600;
             //             NSMutableArray *smallArray = [self.mArray objectAtIndex:btnSection];
             //             NSMutableDictionary *dic = [smallArray objectAtIndex:btnRow];
             
             NSDictionary *dic1 = [self.detailArray objectAtIndex:btnSection];
             NSMutableArray *array1 = [dic1 objectForKey:@"productInfoList"];
             NSMutableDictionary *dic = [array1 objectAtIndex:btnRow];
             [dic setObject:@"年领" forKey:@"payType"];
             
         }
         else if (btn.tag/100000 ==2)
         {
             long btnTgOne = btn.tag - 200000;
             UIButton *button = (UIButton *)[self viewWithTag:btnTgOne];
             [button setImage:[UIImage imageNamed:@"yueling.png"] forState:UIControlStateNormal];
             int btnSection = btnTgOne/600-1;
             int btnRow = btnTgOne%600;
             //             NSMutableArray *smallArray = [self.mArray objectAtIndex:btnSection];
             //             NSMutableDictionary *dic = [smallArray objectAtIndex:btnRow];
             NSDictionary *dic1 = [self.detailArray objectAtIndex:btnSection];
             NSMutableArray *array1 = [dic1 objectForKey:@"productInfoList"];
             NSMutableDictionary *dic = [array1 objectAtIndex:btnRow];
             [dic setObject:@"月领" forKey:@"payType"];
             
         }
         else
         {
             long btnTgOne = btn.tag - 300000;
             UIButton *button = (UIButton *)[self viewWithTag:btnTgOne];
             [button setImage:[UIImage imageNamed:@"duling.png"] forState:UIControlStateNormal];
             int btnSection = btnTgOne/600-1;
             int btnRow = btnTgOne%600;
             //             NSMutableArray *smallArray = [self.mArray objectAtIndex:btnSection];
             //             NSMutableDictionary *dic = [smallArray objectAtIndex:btnRow];
             NSDictionary *dic1 = [self.detailArray objectAtIndex:btnSection];
             NSMutableArray *array1 = [dic1 objectForKey:@"productInfoList"];
             NSMutableDictionary *dic = [array1 objectAtIndex:btnRow];
             [dic setObject:@"趸领" forKey:@"payType"];
             
         }
         
         
     } completion:^(BOOL finished)
     {
         
         [[btn superview] removeFromSuperview];
     }];
    
}

@end


@implementation NianJinLingQuSmallXiangQingView

{
    UITableView *smallXiangViewTabV;
    
}


+(NianJinLingQuSmallXiangQingView *)awakeFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"NianJinLingQuFangShiBianGengView" owner:nil options:nil] objectAtIndex:3];
    
}


- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}


-(void)custemView
{
    
    
    //    smallXiangViewTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 71, 712, 105) style:UITableViewStylePlain];
    //    [self addSubview:smallXiangViewTabV];
    //    smallXiangViewTabV.rowHeight = 36;
    //    smallXiangViewTabV.delegate =self;
    //    smallXiangViewTabV .dataSource = self;
    
    //    NSDictionary *dic1 = @{@"xuhao":@"10001001",@"mingcheng":@"xxxx保险",@"baoe":@"10000",@"qixian":@"年交"};
    //    [self.detailArray addObject:dic1];
    //    NSDictionary *dic2 = @{@"xuhao":@"10001022",@"mingcheng":@"xxxx保险",@"baoe":@"20000",@"qixian":@"年交"};
    //    [self.detailArray addObject:dic2];
}


/*
 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 NianJinLingQuSmallXiangQingViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
 if (!cell)
 {
 cell = [[NianJinLingQuSmallXiangQingViewCell alloc] initWithFrame:CGRectMake(0, 0, 776, 35)];
 }
 NSDictionary *dic = [self.detailArray objectAtIndex:indexPath.row];
 cell.xianZhongLabel.text = [dic objectForKey:@"xuhao"];
 cell.mingChengLabel.text = [dic objectForKey:@"mingcheng"];
 cell.baoELabel.text = [dic objectForKey:@"baoe"];
 cell.qiXianLabel.text = [dic objectForKey:@"qixian"];
 //cell.lingQuNianLingLabel.text = [dic objectForKey:@""];
 [cell.lingQuNIanXianBtn addTarget:self action:@selector(nianXianBtnClick:) forControlEvents:UIControlEventTouchUpInside];
 cell.lingQuNIanXianBtn.tag = 7500+indexPath.row;
 [cell.lingQuFangShiBtn addTarget:self action:@selector(fangshiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
 cell.lingQuFangShiBtn.tag = 7600+indexPath.row;
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 return cell;
 }
 
 */



@end


@implementation NianJinLingQuSmallXiangQingViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"NianJinLingQuFangShiBianGengView" owner:nil options:nil] objectAtIndex:4];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}


@end



@implementation TableFootView


+(TableFootView *)awakeFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"NianJinLingQuFangShiBianGengView" owner:nil options:nil] objectAtIndex:5];
    
}

- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}

-(void)custemView
{
    
}

@end



