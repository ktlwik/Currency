//
//  CurrencyListTableViewController.h
//  Currency
//
//  Created by Admin on 7/13/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"

@interface CurrencyListTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, EditViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *MainCurrency;

@property (nonatomic, strong) NSMutableArray *curs;
@property (nonatomic, strong) NSMutableArray *prices;
@property (nonatomic, strong) NSMutableArray *newprices;
@end
