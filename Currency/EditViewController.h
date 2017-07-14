//
//  EditViewController.h
//  Currency
//
//  Created by Admin on 7/13/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditViewController;

@protocol EditViewControllerDelegate <NSObject>
- (void)addItemViewController:(EditViewController *)controller didFinishEnteringItem:(NSString *)item;
@end

@interface EditViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *MainCurrency;
@property (nonatomic, strong) NSArray *currencies;
@property (nonatomic, weak) id <EditViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *SelectedCurrency;
@property (weak, nonatomic) IBOutlet UITableView *tableCheck;


@property (nonatomic, strong) NSMutableArray *dataArray;

@end


