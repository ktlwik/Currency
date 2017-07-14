//
//  EditViewController.m
//  Currency
//
//  Created by Admin on 7/13/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "EditViewController.h"


@interface EditViewController ()
@end

@implementation EditViewController
@synthesize MainCurrency;
@synthesize SelectedCurrency;
@synthesize delegate;
@synthesize tableCheck;
@synthesize dataArray;

-(void)viewWillDisappear:(BOOL)animated
{
    NSString *itemToPassBack = @"Pass this value back to ViewControllerA";
    [self.delegate addItemViewController:self didFinishEnteringItem:itemToPassBack];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SelectedCurrency.text = MainCurrency;
    //dataArray= [NSMutableArray array];
                
    tableCheck.delegate = self;
    tableCheck.dataSource = self;
    [tableCheck setEditing:(YES) animated:(YES)];
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==Nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.tintColor=[UIColor redColor];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 3;
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
