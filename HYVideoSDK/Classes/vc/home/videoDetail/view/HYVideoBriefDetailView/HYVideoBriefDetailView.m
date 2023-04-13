//
//  HYVideoBriefDetailView.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/13.
//

#import "HYVideoBriefDetailView.h"

@interface HYVideoBriefDetailView()

@property(nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *des;
@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UILabel *briefLab;

@end

@implementation HYVideoBriefDetailView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.whiteColor;
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage sdk_bundleImage:@"guanbi"] forState:0];
    [self addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.width.height.mas_offset(50);
    }];
    
    self.name = [UILabel new];
    self.name.font = [UIFont boldSystemFontOfSize:18];
    self.name.textColor = UIColor.textColor22;
    self.name.text = @"萨芬";
    [self addSubview:self.name];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_offset(50);
        make.right.equalTo(closeBtn.mas_left).offset(-10);
    }];
    
    self.scrollView = [UIScrollView new];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
//    self.scrollView.bounces = NO;
    [self addSubview:self.scrollView];
    if (@available(iOS 11.0, *)) {
        [self.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(self);
    }];
    
    self.des = [UILabel new];
    self.des.font = [UIFont systemFontOfSize:13];
    self.des.numberOfLines = 0;
    self.des.textColor = UIColor.textColor99;
    self.des.attributedText = [self getFirstChapterString:@"三方公司的风格\n时代根深蒂固啊公司的风格\n sewer认为他玩儿v啊多少三方公司的风格\n时代根深蒂固啊公司的风格\n sewer认为他玩儿v啊多少"];
    [self.scrollView addSubview:self.des];
    
    [self.des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.scrollView.mas_top).offset(10);
        make.right.equalTo(self.mas_right).offset(-16);
    }];
    
    UIView *lines = [UIView new];
    lines.backgroundColor = [UIColor.grayColor colorWithAlphaComponent:0.2];
    [self.scrollView addSubview:lines];
    
    [lines mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.des.mas_bottom).offset(20);
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.mas_offset(0.5);
    }];
    
    self.tipLab = [UILabel new];
    self.tipLab.font = [UIFont boldSystemFontOfSize:18];
    self.tipLab.text = @"简介";
    self.tipLab.textColor = UIColor.textColor22;
    [self.scrollView addSubview:self.tipLab];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(lines.mas_bottom).offset(20);
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.mas_offset(20);
    }];
    
    self.briefLab = [UILabel new];
    self.briefLab.font = [UIFont systemFontOfSize:13];
    self.briefLab.numberOfLines = 0;
    self.briefLab.textColor = UIColor.textColor99;
    self.briefLab.attributedText = [self getFirstChapterString:@"转码原则：确诊病例治愈出院、无症状感染者出舱、疑似病例排除后、解除集中隔离观察等转为居家健康监测期间，藏易通健康码由红码转黄码；解除居家健康监测或按相关要求完成核酸检测转码原则：确诊病例治愈出院、无症状感染者出舱、疑似病例排除后、解除集中隔离观察等转为居家健康监测期间，藏易通健康码由红码转黄码；解除居家健康监测或按相关要求完成核酸检测转码原则：确诊病例治愈出院、无症状感染者出舱、疑似病例排除后、解除集中隔离观察等转为居家健康监测期间，藏易通健康码由红码转黄码；解除居家健康监测或按相关要求完成核酸检测转码原则：确诊病例治愈出院、无症状感染者出舱、疑似病例排除后、解除集中隔离观察等转为居家健康监测期间，藏易通健康码由红码转黄码；解除居家健康监测或按相关要求完成核酸检测转码原则：确诊病例治愈出院、无症状感染者出舱、疑似病例排除后、解除集中隔离观察等转为居家健康监测期间，藏易通健康码由红码转黄码；解除居家健康监测或按相关要求完成核酸检测转码原则：确诊病例治愈出院、无症状感染者出舱、疑似病例排除后、解除集中隔离观察等转为居家健康监测期间，藏易通健康码由红码转黄码；解除居家健康监测或按相关要求完成核酸检测转码原则：确诊病例治愈出院、无症状感染者出舱、疑似病例排除后、解除集中隔离观察等转为居家健康监测期间，藏易通健康码由红码转黄码；解除居家健康监测或按相关要码原则：确诊病例治愈出院、无症状感染者出舱、疑似病例排除后、解除集中隔离观察等转为居家健康监测期间，藏易通健康码由红码转黄码；解除居家健康监测或按相关要求完成核酸检测转码原则：确诊病例治愈出院、无症状感染者出舱、疑似病例排除后、解除集中隔离观察等转为居家健康监测期间，藏易通健康码由红码转黄码；解除居家健康监测或按相关要求完成核酸检测转码原则：确诊病例治愈出院、无症状感染者出舱、疑似病例排除后、解除集中隔离观察等转为居家健康监测期间，藏易通健康码由红码转黄码；解除居家健康监测或按相关要求完成核酸检测转码原则：确诊病例治愈出院、无症状感染者出舱、疑似病例排除后、解除集中隔离观察等转为居家健康监测期间，藏易通健康码由红码转黄码；解除居家健康监测或按相关要求完成核酸检测转码原则：确诊病例治愈出院、无症状感染者出舱、疑似病例排除后、解除集中隔离观察等转为居家健康监测期间，藏易通健康码由红码转黄码；解除居家健康监测或按相关要码原则：确诊病例治愈出院、无症状感染者出舱、疑似病例排除后、解除集中隔离观察等转为居家健康监测期间，藏易通健康码由红码转黄码；解除居家健康监测或按相关要求完成核酸检测转码原则：确诊病例治愈出院、无症状感染者出舱、疑似病例排除后、解除集中隔离观察等转为居家健康监测期间，藏易通健康码由红码转黄码；解除居家健康监测或按相关要求完成核酸检测转码原则：确诊病例治愈出院、无症状感染者出舱、疑似病例排除后、解除集中隔离观察等转为居家健康监测期间，藏易通健康码由红码转黄码；解除居家健康监测或按相关要求完成核酸检测"];
    [self.scrollView addSubview:self.briefLab];
    
    [self.briefLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.tipLab.mas_bottom).offset(20);
        make.right.equalTo(self.mas_right).offset(-16);
        make.bottom.equalTo(self.scrollView.mas_bottom).offset(-(IS_iPhoneX ? 44 : 20));
    }];
}

- (NSAttributedString *)getFirstChapterString:(NSString *)chapterStr
{
    NSMutableAttributedString *textAttributed = [[NSMutableAttributedString alloc] initWithString:chapterStr];
    textAttributed.font = [UIFont systemFontOfSize:13];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [textAttributed addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textAttributed length])];
    [textAttributed addAttribute:NSForegroundColorAttributeName value:[UIColor textColor99] range:NSMakeRange(0,[textAttributed length])];

    return textAttributed;
}

- (void)closeButtonClick {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:nil];
    }
}

@end
