//
//  YFRouterDesCell.h
//  YFRouter_Example
//
//  Created by 胡玉峰 on 2021/5/21.
//  Copyright © 2021 iosyufeng@sina.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFRouterDesCell : UITableViewCell
@property (nonatomic,strong) UILabel * yfTitleLabel;
@property (nonatomic,strong) UILabel * yfDesLabel;

@property (nonatomic,strong) NSDictionary * dataDic;




+(UITableViewCell *)getCellWithTableView:(UITableView *)tableView andReuseID:(NSString *)resueID;
@end

NS_ASSUME_NONNULL_END
