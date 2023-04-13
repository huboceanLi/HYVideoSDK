//
//  HYVideoRecommendViewCell.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/13.
//

#import "HYVideoRecommendViewCell.h"

@interface HYVideoRecommendViewCell()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *focus;
@property (nonatomic, strong) UILabel *score;
@property (nonatomic, strong) UILabel *people;

@end

@implementation HYVideoRecommendViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.headImageView = [UIImageView new];
        self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headImageView.layer.cornerRadius = 6.0;
        self.headImageView.backgroundColor = UIColor.lightGrayColor;
        self.headImageView.layer.masksToBounds = YES;
        [self addSubview:self.headImageView];
        
        self.name = [UILabel new];
        self.name.text = @"三方";
        self.name.textColor = UIColor.textColor22;
        self.name.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.name];
        
        self.focus = [UILabel new];
        self.focus.text = @"三方是发疯舒服的";
        self.focus.textColor = UIColor.textColor99;
        self.focus.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.focus];
        
        self.score = [UILabel new];
        self.score.text = @"9.5";
        self.score.textAlignment = NSTextAlignmentRight;
        self.score.font = [UIFont systemFontOfSize:11];
        [self addSubview:self.score];
        
        self.people = [UILabel new];
        self.people.text = @"是的发/大的/郭德纲";
        self.people.textColor = UIColor.textColor99;
        self.people.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.people];
        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(16);
            make.width.mas_offset(100);
            make.top.equalTo(self.mas_top).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.mas_right).offset(-16);
            make.top.equalTo(self.mas_top).offset(13);
            make.height.mas_offset(20);
        }];
        
        [self.focus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.mas_right).offset(-16);
            make.top.equalTo(self.name.mas_bottom).offset(4);
            make.height.mas_offset(16);
        }];
        
        [self.people mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.mas_right).offset(-16);
            make.top.equalTo(self.focus.mas_bottom).offset(8);
            make.height.mas_offset(16);
        }];
        
        [self.score mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.headImageView.mas_right).offset(-4);
            make.bottom.equalTo(self.headImageView.mas_bottom).offset(-4);
            make.height.mas_offset(14);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
