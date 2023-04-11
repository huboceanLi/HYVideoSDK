//
//  HYVideoHomeListCell.m
//  CocoaAsyncSocket
//
//  Created by oceanMAC on 2023/4/10.
//

#import "HYVideoHomeListCell.h"

@interface HYVideoHomeListCell()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *name;

@end

@implementation HYVideoHomeListCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.headImageView = [UIImageView new];
        self.headImageView.layer.cornerRadius = 6.0;
        self.headImageView.backgroundColor = UIColor.redColor;
        self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.headImageView];
        
        self.name = [UILabel new];
        self.name.text = @"是的是大的是丰收";
        self.name.font = [UIFont systemFontOfSize:13];
        self.name.textColor = [UIColor textColor22];
        [self addSubview:self.name];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_offset(20);
        }];
        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self.name.mas_top).offset(-6);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end