//
//  YFRouterDesCell.m
//  YFRouter_Example
//
//  Created by 胡玉峰 on 2021/5/21.
//  Copyright © 2021 iosyufeng@sina.com. All rights reserved.
//

#import "YFRouterDesCell.h"
@import Masonry;

@interface YFRouterDesCell()

@end

@implementation YFRouterDesCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
+(UITableViewCell *)getCellWithTableView:(UITableView *)tableView andReuseID:(NSString *)resueID{
    YFRouterDesCell * cell = [tableView dequeueReusableCellWithIdentifier:resueID];
    if (!cell) {
        cell = [[YFRouterDesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resueID];
    }
    return cell;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    [self packageData:dataDic];
    
}

-(void)packageData:(NSDictionary *)dataDic{
    _yfTitleLabel.text = dataDic[@"title"];
    [_yfDesLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
    }];
    
    if ([dataDic[@"title"] isEqualToString:@"当前vc的名称"] ||
        [dataDic[@"title"] isEqualToString:@"当前vc的RouterCode"]) {
        _yfDesLabel.text = dataDic[@"desData"];
    }else if([dataDic[@"title"] isEqualToString:@"跳转当前vc传递过来的参数"]) {
        NSString * dataString = [self dictionaryToJson:dataDic[@"desData"]];
        _yfDesLabel.text = dataString;
        [_yfDesLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(100);
        }];
    }else if([dataDic[@"title"] isEqualToString:@"执行跳转当前vc注册的回调"]) {
        _yfDesLabel.text = @"点击当前行执行回调";
    }
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

-(void)setUpView{
    _yfTitleLabel = [UILabel new];
    _yfDesLabel = [UILabel new];
    _yfDesLabel.numberOfLines = 0;
    _yfDesLabel.textColor = [UIColor orangeColor];
    
    [self.contentView addSubview:_yfTitleLabel];
    [self.contentView addSubview:_yfDesLabel];
    [self setConstraint];
}
-(void)setConstraint{
    [_yfTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(10);
        make.top.mas_offset(10);
        make.height.mas_equalTo(25);
    }];
    
    [_yfDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(10);
        make.top.equalTo(_yfTitleLabel.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(100);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
