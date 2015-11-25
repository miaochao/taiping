//
//  MainViewController.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/21.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "MainViewController.h"
#import "MainChangeView.h"
#import "MainPropertyView.h"
#import "MainQueryView.h"
#import "MainProgressView.h"
#import "LeaveView.h"
#import "MainXSZYView.h"
@interface MainViewController ()
{
    MainViewController      *vc;
    NSMutableArray          *btnArray;//用来放透明的btn
}
@end

@implementation MainViewController
+(instancetype)sharedManager{
    static MainViewController *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    btnArray=[[NSMutableArray alloc] init];
    
    self.leftView.backgroundColor=[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.progressView.backgroundColor=[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.propertyView.backgroundColor=[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.queryView.backgroundColor=[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.nameLabel.text=self.name;    

    //[self custemView];
}
-(void)custemView{
    self.scrollV=[[UIScrollView alloc] initWithFrame:CGRectMake(192, 64, 832, 704)];
    [self.view addSubview:self.scrollV];
    self.scrollV.delegate = self;
    
    self.scrollV.contentOffset=CGPointMake(0, 0);
    self.scrollV.pagingEnabled=YES;
    
    if (self.type==1) {
        //代理人
        self.scrollV.contentSize=CGSizeMake(832, 704*2);
        self.changeView.alpha=0;
        self.propertyView.alpha=0;
        self.queryView.frame=self.changeView.frame;
        self.progressView.frame=self.propertyView.frame;
        for (int i=3; i<5; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(0, 166+69*(i-3), 192, 69);
            [self.leftView addSubview:btn];
            btn.tag=i;
            btn.backgroundColor=[UIColor clearColor];
            [btn addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [btnArray addObject:btn];
            if (btn.tag==3) {
                //初始化左边，默认显示第一个
                [self leftButtonClick:btn];
            }
        }
    }else{
        self.changeView.alpha=1;
        self.propertyView.alpha=1;
        self.changeView.frame=CGRectMake(0, 166, 192, 69);
        self.propertyView.frame=CGRectMake(0, 166+69, 192, 69);
        self.queryView.frame=CGRectMake(0, 166+69*2, 192, 69);
        self.progressView.frame=CGRectMake(0, 166+69*3, 192, 69);
        for (int i=1; i<5; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(0, 166+69*(i-1), 192, 69);
            [self.leftView addSubview:btn];
            btn.tag=i;
            btn.backgroundColor=[UIColor clearColor];
            [btn addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [btnArray addObject:btn];
            if (i==1) {
                //初始化左边，默认显示第一个
                [self leftButtonClick:btn];
               
            }
        }
        
        self.scrollV.contentSize=CGSizeMake(832, 704*4);
    }
    
    [self scrollViewChangeView];
    
    switch (self.type) {
        case 1:
            self.typeImageV.image=[UIImage imageNamed:@"dailiren.png"];
            break;
        case 2:
            self.typeImageV.image=[UIImage imageNamed:@"neiqing.png"];
            [self.headBtn setImage:[UIImage imageNamed:@"nantouxiang"] forState:UIControlStateNormal];
            break;
        case 3:
            self.typeImageV.image=[UIImage imageNamed:@"xushouzhuanyuan.png"];
            break;
    }
}
-(void)scrollViewChangeView{
    MainProgressView *progressView=(MainProgressView *)[MainProgressView awakeFromNib] ;
    [progressView customUI];
    
    [self.scrollV addSubview:progressView];
    if (self.type==1) {
        //代理人
        progressView.frame=CGRectMake(0, 704*1, 832, 704);
        
        MainQueryView *queryView=(MainQueryView *)[MainQueryView awakeFromNib] ;
        queryView.frame=CGRectMake(0, 704*0, 832, 704);
        [self.scrollV addSubview:queryView];
        return;
        
    }
    progressView.frame=CGRectMake(0, 704*3, 832, 704);
    if (self.type==3) {
        //续收专员
        MainXSZYView *changeView=[[[NSBundle mainBundle] loadNibNamed:@"MainXSZYView" owner:nil options:nil] objectAtIndex:0];
        changeView.frame=CGRectMake(0, 0, 832, 704);
        [self.scrollV addSubview:changeView];
        
        MainXSZYPropertyView *propertyView=[[[NSBundle mainBundle] loadNibNamed:@"MainXSZYView" owner:nil options:nil] objectAtIndex:1];
        propertyView.frame=CGRectMake(0, 704, 832, 704);
        [self.scrollV addSubview:propertyView];
        
        MainXSZYQueryView *queryView=[[[NSBundle mainBundle] loadNibNamed:@"MainXSZYView" owner:nil options:nil] objectAtIndex:2];
        queryView.frame=CGRectMake(0, 704*2, 832, 704);
        [self.scrollV addSubview:queryView];
        return;
    }
    MainChangeView *changeView=(MainChangeView *)[MainChangeView awakeFromNib] ;
    changeView.frame=CGRectMake(0, 0, 832, 704);
    [self.scrollV addSubview:changeView];
    
    MainPropertyView *propertyView=(MainPropertyView *)[MainPropertyView awakeFromNib] ;
    if (self.type==1) {
        propertyView.addNewAccountBtn.alpha=0;
        propertyView.addNewAccountL.alpha=0;
    }
    propertyView.frame=CGRectMake(0, 704, 832, 704);
    [self.scrollV addSubview:propertyView];
    
    MainQueryView *queryView=(MainQueryView *)[MainQueryView awakeFromNib] ;
    queryView.frame=CGRectMake(0, 704*2, 832, 704);
    [self.scrollV addSubview:queryView];
    
    
}
//左边的子view对应的按钮
- (void)leftButtonClick:(UIButton *)sender {
    [self leftAllView];
    if (self.type==1) {
        //代理人
        if (sender.tag==3) {
            self.scrollV.contentOffset=CGPointMake(0, 704*0);
            self.leftLabel.frame=CGRectMake(0, self.queryView.frame.origin.y, self.leftLabel.frame.size.width, self.leftLabel.frame.size.height);
            [self chooseLeftChildView:self.queryView];
        }
        if (sender.tag==4) {
            self.scrollV.contentOffset=CGPointMake(0, 704*1);
            self.leftLabel.frame=CGRectMake(0, self.progressView.frame.origin.y, self.leftLabel.frame.size.width, self.leftLabel.frame.size.height);
            [self chooseLeftChildView:self.progressView];
        }
        return;
    }
    
    if (sender.tag==1) {
        self.scrollV.contentOffset=CGPointMake(0, 0);
        self.leftLabel.frame=CGRectMake(0, self.changeView.frame.origin.y, self.leftLabel.frame.size.width, self.leftLabel.frame.size.height);
        [self chooseLeftChildView:self.changeView];
    }
    if (sender.tag==2) {
        self.scrollV.contentOffset=CGPointMake(0, 704*1);
        self.leftLabel.frame=CGRectMake(0, self.propertyView.frame.origin.y, self.leftLabel.frame.size.width, self.leftLabel.frame.size.height);
        [self chooseLeftChildView:self.propertyView];
    }
    if (sender.tag==3) {
        self.scrollV.contentOffset=CGPointMake(0, 704*2);
        self.leftLabel.frame=CGRectMake(0, self.queryView.frame.origin.y, self.leftLabel.frame.size.width, self.leftLabel.frame.size.height);
        [self chooseLeftChildView:self.queryView];
    }
    if (sender.tag==4) {
        self.scrollV.contentOffset=CGPointMake(0, 704*3);
        self.leftLabel.frame=CGRectMake(0, self.progressView.frame.origin.y, self.leftLabel.frame.size.width, self.leftLabel.frame.size.height);
        [self chooseLeftChildView:self.progressView];
    }
}
//选择左边的子view进行设置
-(void)chooseLeftChildView:(UIView *)view{
    view.backgroundColor=[UIColor whiteColor];
    UILabel *label=(UILabel *)[view viewWithTag:200];
    label.textColor=[UIColor blueColor];
    UIImageView *imageV=(UIImageView *)[view viewWithTag:100];
    switch (view.tag) {
        case 1:
            imageV.image=[UIImage imageNamed:@"bqbg dianji.png"];
            break;
        case 2:
            imageV.image=[UIImage imageNamed:@"zcgl dianji.png"];
            break;
        case 3:
            imageV.image=[UIImage imageNamed:@"bqcx dianji.png"];
            break;
        case 4:
            imageV.image=[UIImage imageNamed:@"bqjd dianji.png"];
            break;
    }
}
//初始化左边的子view
-(void)leftAllView{
    self.changeView.backgroundColor=[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self leftLabelAndImageView:self.changeView];
    
    self.progressView.backgroundColor=[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self leftLabelAndImageView:self.propertyView];
    
    self.propertyView.backgroundColor=[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self leftLabelAndImageView:self.progressView];
    
    self.queryView.backgroundColor=[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self leftLabelAndImageView:self.queryView];
    
}
//初始化左边的个个子view
-(void)leftLabelAndImageView:(UIView *)view{
    UILabel *label=(UILabel *)[view viewWithTag:200];
    label.textColor=[UIColor blackColor];
    UIImageView *imageV=(UIImageView *)[view viewWithTag:100];
    switch (view.tag) {
        case 1:
            imageV.image=[UIImage imageNamed:@"bqbg weidianji.png"];
            break;
        case 2:
            imageV.image=[UIImage imageNamed:@"zcgl weidianji.png"];
            break;
        case 3:
            imageV.image=[UIImage imageNamed:@"bqcx weidianji.png"];
            break;
        case 4:
            imageV.image=[UIImage imageNamed:@"bqjd weidianji.png"];
            break;
    }
}

#pragma mark  scrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int content=scrollView.contentOffset.y/704;
    [self leftAllView];
    if (self.type==1) {
        //代理人
        if (content==0) {
            self.leftLabel.frame=CGRectMake(0, self.queryView.frame.origin.y, self.leftLabel.frame.size.width, self.leftLabel.frame.size.height);
            [self chooseLeftChildView:self.queryView];
        }else{
            self.leftLabel.frame=CGRectMake(0, self.progressView.frame.origin.y, self.leftLabel.frame.size.width, self.leftLabel.frame.size.height);
            [self chooseLeftChildView:self.progressView];
        }
        return;
    }
    switch (content+1) {
        case 1:
            self.leftLabel.frame=CGRectMake(0, self.changeView.frame.origin.y, self.leftLabel.frame.size.width, self.leftLabel.frame.size.height);
            [self chooseLeftChildView:self.changeView];
            break;
        case 2:
            self.leftLabel.frame=CGRectMake(0, self.propertyView.frame.origin.y, self.leftLabel.frame.size.width, self.leftLabel.frame.size.height);
            [self chooseLeftChildView:self.propertyView];
            break;
        case 3:
            self.leftLabel.frame=CGRectMake(0, self.queryView.frame.origin.y, self.leftLabel.frame.size.width, self.leftLabel.frame.size.height);
            [self chooseLeftChildView:self.queryView];
            break;
        case 4:
            self.leftLabel.frame=CGRectMake(0, self.progressView.frame.origin.y, self.leftLabel.frame.size.width, self.leftLabel.frame.size.height);
            [self chooseLeftChildView:self.progressView];
            break;
    }
}


#pragma mark 点击头像退出
- (IBAction)headBtnClick:(UIButton *)sender {
    LeaveView *view=[LeaveView awakeFromNib];
    view.frame=CGRectMake(0, 64, 1024, 704);
    [view custemView:1];
    view.delegate=self;
    [self.view addSubview:view];
}
//退出
-(void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark leaveDelegate

-(void)pushVC{
    //把scrollV上的视图全部移除
    [self.scrollV removeFromSuperview];
    for (UIButton *btn in btnArray) {
        [btn removeFromSuperview];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
