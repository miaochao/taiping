//
//  ChargeView.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/24.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//选择银行界面
#import "ChargeView.h"
#import "enumView.h"
#import "ChargeViewCell.h"

@implementation ChargeView
{
    UIView  *backgView;//点击银行等的view
    UILabel *nameLabel;//银行或者机构
    UITableView *tableV;
    NSMutableArray *mArray;
    
    int         choose;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self=[[[NSBundle mainBundle] loadNibNamed:@"ChargeView" owner:nil options:nil] lastObject];
        [self createBtn];
    }
    return self;
}
+(ChargeView*)awakeFromNib{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"ChargeView" owner:self options:nil];
    
    
    return [array lastObject];
}
//红利领取方式变更
-(void)bounsReceiveType{
    self.typeL.alpha=1;
    self.typeTextF.alpha=1;
    
    self.accountL.text=@"授权银行";
     self.acountTextField.placeholder=@"请输入授权账号";
    self.nameL.text=@"账户所有人姓名";
    self.nameTextField.placeholder=@"请填写真实姓名";
    UIButton *btn=(UIButton *)[self viewWithTag:400];
    btn.alpha=1;
}
-(void)createLabel{
    self.accountL.text=@"授权账号：";
    self.acountTextField.placeholder=@"请输入授权账号";
    self.typeL.alpha=1;
    self.typeTextF.alpha=1;
    UIButton *btn=(UIButton *)[self viewWithTag:400];
    btn.alpha=1;
    
    self.bankTextField.enabled=NO;
    self.organizationTextField.enabled=NO;
    self.typeTextF.enabled=NO;
    
//    self.bankL.frame=CGRectMake(350, 113, 119, 21);
//    self.bankTextField.frame=CGRectMake(481, 111, 167, 30);
//    self.bankBtn.frame=self.bankTextField.frame;
//    
//    
//    self.typeL.frame=CGRectMake(33, 28, 119, 21);
//    self.typeTextF.frame=CGRectMake(169, 25, 167, 30);
//    self.typeBtn.frame=self.typeTextF.frame;
    self.bankL.text=@"授权方式：";
    self.bankTextField.placeholder=@"请选择授权方式";
    self.bankBtn.tag=400;
    
    
    self.typeL.text=@"账号所属银行";
    self.typeTextF.placeholder=@"请选择银行";
    self.typeBtn.tag=100;
    
    
    //让其他功能不能编辑
    self.organizationBtn.enabled=NO;
    self.typeBtn.enabled=NO;
    self.bankBtn.enabled=YES;
    
}
-(void)createBtn{
    self.bankView.layer.borderWidth=1;
    self.typeTextField.enabled=NO;
    self.nameTextField.enabled=NO;
    self.nameTextField.text=@"宋晓丽";
    self.acountTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.typeL.alpha=0;
    self.typeTextF.alpha=0;
    
    UIButton *btn=(UIButton *)[self viewWithTag:400];
    btn.alpha=0;
    
//    //银行
//    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn1.frame=self.bankTextField.frame;
//    btn1.backgroundColor=[UIColor clearColor];
//    btn1.tag=100;
//    [btn1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:btn1];
//    
//    //类型
//    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn2.frame=self.typeTextField.frame;
//    btn2.backgroundColor=[UIColor clearColor];
//    btn2.tag=200;
//    [btn2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:btn2];
//    
//    //账户机构
//    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn3.frame=self.organizationTextField.frame;
//    btn3.backgroundColor=[UIColor clearColor];
//    btn3.tag=300;
//    [btn3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:btn3];
}
//-(void)buttonClick:(UIButton *)sender{
//    
//    
//    if (!backgView) {
//        [self createView];
//    }
//    if (sender.tag==100) {
//        nameLabel.text=@"请选择所属银行";
//        choose=100;
//        mArray=@[@"中国工商银行",@"中国建设银行",@"中国交通银行",@"中国农业银行",@"中国银行",@"中国邮政储蓄银行",@"中信银行",@"兴业银行",@"光大银行",@"广东发展银行",@"华侨银行",@"民生银行",@"浦发发展银行",@"深圳发展银行",@"招商银行"];
//    }
//    if (sender.tag==300) {
//        choose=300;
//        nameLabel.text=@"请选择所属机构";
//        mArray=@[@"太平人寿保险有限公司上海分公司",@"太平人寿保险有限公司北京分公司",@"太平人寿保险有限公司广东分公司",@"太平人寿保险有限公司四川分公司",@"太平人寿保险有限公司河北分公司",@"太平人寿保险有限公司河南分公司",@"太平人寿保险有限公司江苏分公司",@"太平人寿保险有限公司山东分公司",@"太平人寿保险有限公司浙江分公司",@"太平人寿保险有限公司辽宁分公司",@"太平人寿保险有限公司宁波分公司",@"太平人寿保险有限公司深圳分公司",@"太平人寿保险有限公司青岛分公司",@"太平人寿保险有限公司大连分公司",@"太平人寿保险有限公司佛山分公司"];
//    }
//    if(sender.tag==200){
//        return;
//    }
//    [tableV reloadData];
//    backgView.alpha=1;
//    if (!self.upOrdown) {
//        //no表示下面
//        backgView.frame=CGRectMake(self.frame.origin.x+sender.frame.origin.x, self.frame.origin.y+sender.frame.origin.y+sender.frame.size.height, 167, 305);
//        return;
//    }
//    backgView.frame=CGRectMake(self.frame.origin.x+sender.frame.origin.x, self.frame.origin.y+sender.frame.origin.y-305, 167, 305);
//}
- (IBAction)btnClick:(UIButton *)sender {
    if (sender.tag==400) {
        //授权方式按钮
        self.bankView.alpha=1;
        
        return;
    }
    
    if (!backgView) {
        [self createView];
    }
    if (sender.tag==100) {
        nameLabel.text=@"请选择所属银行";
        choose=100;
        mArray=@[@"中国工商银行",@"中国建设银行",@"中国交通银行",@"中国农业银行",@"中国银行",@"中国邮政储蓄银行",@"中信银行",@"兴业银行",@"广大银行",@"广东发展银行",@"华侨银行",@"民生银行",@"浦发发展银行",@"深圳发展银行",@"招商银行"];
        if (self.type==1) {
            //表示有授权方式
            backgView.frame=CGRectMake(sender.frame.origin.x, self.frame.origin.y+sender.frame.origin.y-18*6, 167, 18*6);
        }else{
        backgView.frame=CGRectMake(self.frame.origin.x+sender.frame.origin.x, self.frame.origin.y+sender.frame.origin.y+sender.frame.size.height, 167, 18*6);
        }
    }
    if (sender.tag==300) {
        choose=300;
        nameLabel.text=@"请选择所属机构";
        mArray=@[@"太平人寿保险有限公司上海分公司",@"太平人寿保险有限公司北京分公司",@"太平人寿保险有限公司广东分公司",@"太平人寿保险有限公司四川分公司",@"太平人寿保险有限公司河北分公司",@"太平人寿保险有限公司河南分公司",@"太平人寿保险有限公司江苏分公司",@"太平人寿保险有限公司山东分公司",@"太平人寿保险有限公司浙江分公司",@"太平人寿保险有限公司辽宁分公司",@"太平人寿保险有限公司宁波分公司",@"太平人寿保险有限公司深圳分公司",@"太平人寿保险有限公司青岛分公司",@"太平人寿保险有限公司大连分公司",@"太平人寿保险有限公司佛山分公司",@"太平人寿保险有限公司苏州分公司",@"太平人寿保险有限公司天津分公司",@"太平人寿保险有限公司湖北分公司",@"太平人寿保险有限公司安徽分公司",@"太平人寿保险有限公司福建分公司",@"太平人寿保险有限公司黑龙江分公司",@"太平人寿保险有限公司江西分公司",@"太平人寿保险有限公司重庆分公司",@"太平人寿保险有限公司湖南分公司",@"太平人寿保险有限公司陕西分公司",@"太平人寿保险有限公司山西分公司",@"太平人寿保险有限公司云南分公司",@"太平人寿保险有限公司吉林分公司",@"太平人寿保险有限公司广西分公司",@"太平人寿保险有限公司新疆分公司",@"太平人寿保险有限公司贵州分公司",@"太平人寿保险有限公司甘肃分公司",@"太平人寿保险有限公司内蒙古分公司",@"太平人寿保险有限公司海南分公司",@"太平人寿保险有限公司青海分公司"];
        backgView.frame=CGRectMake(self.frame.origin.x+sender.frame.origin.x, self.frame.origin.y+sender.frame.origin.y-18*6, 167, 18*6);
    }
    if(sender.tag==200){
        return;
    }
    [tableV reloadData];
    backgView.alpha=1;
//    if (!self.upOrdown) {
//        //no表示下面
//        backgView.frame=CGRectMake(self.frame.origin.x+sender.frame.origin.x, self.frame.origin.y+sender.frame.origin.y+sender.frame.size.height, 167, 305);
//        return;
//    }
//    backgView.frame=CGRectMake(self.frame.origin.x+sender.frame.origin.x, self.frame.origin.y+sender.frame.origin.y-305, 167, 305);
    
}
-(void)recriveSurvivalGold{
    self.accountL.text=@"付费账号：";
    self.acountTextField.placeholder=@"请输入付费账号";
   
}
-(void)createView{
    mArray =[[NSMutableArray alloc] init];
    backgView=[[UIView alloc] initWithFrame:CGRectMake(200, 100, 167, 18*6)];//305
    backgView.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    backgView.alpha=0;
    [[self superview]  addSubview:backgView];
    
    
    nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 167, 18)];
    [backgView addSubview:nameLabel];
    nameLabel.textAlignment=UITextAlignmentCenter;
    nameLabel.backgroundColor=[UIColor colorWithRed:0 green:151/255.0 blue:255/255.0 alpha:1];
    nameLabel.font=[UIFont systemFontOfSize:14];
    nameLabel.textColor=[UIColor whiteColor];
    
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 18, 167, 18*5) style:UITableViewStylePlain];
    tableV.layer.borderWidth=1;//边框
    [backgView addSubview:tableV];
//    [[self superview] addSubview:tableV];
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.rowHeight=18;
    
    [tableV registerNib:[UINib nibWithNibName:@"ChargeViewCell" bundle:nil] forCellReuseIdentifier:@"chargeCell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChargeViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"chargeCell"];
//    if (!cell) {
//        cell=[[enumTableViewCell alloc] initWithFrame:CGRectMake(0, 0, 167, 18)];
//    }
    cell.label.text=[mArray objectAtIndex:indexPath.row];
    if (choose==300) {
        cell.label.font=[UIFont systemFontOfSize:11];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    backgView.alpha=0;
    if (choose==100) {
        if (self.type==1) {
            self.typeTextF.text=[mArray objectAtIndex:indexPath.row];
        }else{
            self.bankTextField.text=[mArray objectAtIndex:indexPath.row];
        }
    }
    if (choose==300) {
        self.organizationTextField.text=[mArray objectAtIndex:indexPath.row];
    }
}
//
- (IBAction)bankChooseBtn:(UIButton *)sender {
    self.bankView.alpha=0;
    if (sender.tag==10) {
        if (self.type==1) {
            self.bankTextField.text=@"现金";
        }else{
        self.typeTextF.text=@"现金";
        }
        //让其他功能不能编辑
        self.organizationBtn.enabled=NO;
        self.typeBtn.enabled=NO;
        self.acountTextField.enabled=NO;
        //清空所填的内容
        self.acountTextField.text=@"";
        self.organizationTextField.text=@"";
        self.typeTextF.text=@"";
    }
    if (sender.tag==20) {
        if (self.type==1) {
            self.bankTextField.text=@"银行转账";
        }else{
        self.typeTextF.text=@"银行转账";
        }
        //让其他功能不能编辑
        self.organizationBtn.enabled=YES;
        self.typeBtn.enabled=YES;
        self.acountTextField.enabled=YES;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
