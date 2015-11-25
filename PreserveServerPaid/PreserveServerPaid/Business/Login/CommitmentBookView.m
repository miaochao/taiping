//
//  CommitmentBookView.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/25.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "CommitmentBookView.h"
#import "LoginViewController.h"
#import "PreserveServer-Prefix.pch"

@implementation CommitmentBookView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self=[[[NSBundle mainBundle] loadNibNamed:@"CommitmentBookView" owner:nil options:nil] lastObject];
        
    }
    return self;
}
+(CommitmentBookView*)awakeFromNib{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"CommitmentBookView" owner:self options:nil];
    return [array lastObject];
}
-(void)custem{
    self.okBtn.enabled=NO;
    self.textV=[[UITextView alloc] init];
    self.textV.frame=CGRectMake(56, 71, 497, 479);
    [self addSubview:self.textV];
    [self.textV setTextAlignment:NSTextAlignmentLeft];
    self.textV.backgroundColor=[UIColor whiteColor];
    self.textV.textColor=[UIColor blackColor];
    [self.textV setFont:[UIFont systemFontOfSize:20.0f]];
    [self.textV setEditable:NO];
    [self.textV setText:@"\n1. 本人自愿申请开通保全易服务系统操作权限。\n\n2. 本人将严格遵照保全易服务系统操作规范，并保证所有操作及递交材料均真实可信。\n\n3. 本人将严格根据客户申请意愿进行操作，若公司在保全生效后发现非客户真实意愿申请，本人愿意根据保全易服务管理规范接受相应处罚。\n\n4. 若公司在保全生效后发现因为本人操作不当导致保全错误事项，本人愿意根据保全易服务管理规范接受相应处罚。"];
//    self.textV.text=;
}
- (IBAction)chooseBtn:(UIButton *)sender {
    if (sender.tag==50) {
        //改为选中状态
        sender.tag=40;
        self.okBtn.enabled=YES;
        [self.okBtn setImage:[UIImage imageNamed:@"tongyi gouxuan.png"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
    }else{
        //改为未选中
        sender.tag=50;
        self.okBtn.enabled=NO;
        [self.okBtn setImage:[UIImage imageNamed:@"tongyi weigouxuan.png"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)okOrNoBtn:(UIButton *)sender {
    if (sender.tag==100) {
        //确定按钮
        id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,FIRSTLOGIN]];
        [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
        [(CWDistantHessianObject *)remoteService resHeadDict];
        id<TPLUserBOModel> userBOModer=[TPLSessionInfo shareInstance].userBOModel;
        id<TPLErrorBOModel>errorBOModel=nil;
       // NSLog(@">>>>>>>%@",userBOModer.userName);
        @try {
            errorBOModel=[remoteService approveWithUserCate:@"999" andUserName:userBOModer.userName];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>%@",errorBOModel);
        if ([errorBOModel.errorCode isEqualToString:@"0"]) {
            //0表示成功
            LoginViewController *vc=[LoginViewController sharedManager];
            [vc gotoNextVC];
        }else{
            UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示信息" message:errorBOModel.errorInfo delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertV show];
        }
        
    }
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
