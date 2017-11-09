//
//  CommonAlertController.m
//  DesignClothing
//
//  Created by WebUser on 2017/10/30.
//  Copyright © 2017年 yswl. All rights reserved.
//

#import "CommonAlertController.h"

@interface CommonAlertController ()

@property(nonatomic, copy) NSString *topTitle;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;
@property(nonatomic, copy) SureClick sureClick;

@end

@implementation CommonAlertController

- (void)dealloc {
    for (UIView *subView in self.bgView.subviews) {
        [subView removeFromSuperview];
    }
    self.bgView = nil;
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
    self = [super init];
    if (self) {
        self.topTitle = title;
        self.message = message;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBA(0, 0, 0, .4);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:self.bgView];
    CGRect frame = self.bgView.frame;
    CGFloat height = ([NSString getAttributeSizeWithText:self.message fontSize:kTSize14].width/(CGRectGetWidth(frame)-20)+1)*40;
    frame.size.height = height+90;
    self.bgView.frame = frame;
    self.bgView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(frame)-20, 40)];
    titleLabel.text = self.topTitle;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:kTSize17];
    self.titleLabel = titleLabel;
    [self.bgView addSubview:titleLabel];
    
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(frame)-20, height)];
    messageLabel.text = self.message;
    messageLabel.textAlignment = NSTextAlignmentLeft;
    messageLabel.font = [UIFont systemFontOfSize:kTSize14];
    messageLabel.numberOfLines = 0;
    [self.bgView addSubview:messageLabel];
    self.messageLabel = messageLabel;
    
    UIButton *buttonSure = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSure.frame = CGRectMake(CGRectGetWidth(frame)-60, CGRectGetHeight(frame)-45, 60, 40);
    [buttonSure setTitle:@"确定" forState:UIControlStateNormal];
    [buttonSure setTitleColor:navBGColor forState:UIControlStateNormal];
    [buttonSure addTarget:self action:@selector(tappedCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:buttonSure];
    [self animeData];
}


- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    self.titleLabel.textAlignment = _textAlignment;
    self.messageLabel.textAlignment = _textAlignment;
}

-(void)tappedCancel{
    WS(weakSelf);
    [self dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.sureClick) {
            weakSelf.sureClick();
        }
    }];
}
-(void)animeData {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self.view addGestureRecognizer:tapGesture];
    self.view.userInteractionEnabled = YES;
}
-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*0.1, kScreenHeight, kScreenWidth*0.9, 200)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        kViewRadius(_bgView, 5.0);
    }
    return _bgView;
}
+ (CommonAlertController *)showAlertWithSuperController:(UIViewController *)superController title:(NSString *)title message:(NSString *)message click:(SureClick)click {
    CommonAlertController *alertController = [[CommonAlertController alloc] initWithTitle:title message:message];
    alertController.sureClick = click;
    //弹出alertView
    alertController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    alertController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [superController presentViewController:alertController animated:YES completion:nil];
    return alertController;
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
