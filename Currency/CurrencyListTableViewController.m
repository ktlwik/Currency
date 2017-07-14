//
//  CurrencyListTableViewController.m
//  Currency
//
//  Created by Admin on 7/13/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "CurrencyListTableViewController.h"
#import "EditViewController.h"

@interface CurrencyListTableViewController ()
{
    NSArray *devices;
}

@end

@implementation CurrencyListTableViewController

@synthesize MainCurrency;
@synthesize curs;
@synthesize prices;
@synthesize newprices;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //devices = @[@"iPhone", @"iPad", @"iMac"];
    curs = [NSMutableArray array];
    prices =  [NSMutableArray array];
    newprices = [NSMutableArray array];
    NSLog(@"String:%@", MainCurrency.text);
    
    if ([MainCurrency.text isEqualToString:@"Label"]) {
        
        NSLog(@"String:%@", MainCurrency.text);

        MainCurrency.text = @"USD";
    }
    
    NSLog(@"String:%@", MainCurrency.text);
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    
    NSMutableDictionary *s = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSMutableArray *list = [[s objectForKey:@"list"] objectForKey:@"resources"];
    
  //  NSLog(@"json: %@", list);
    for (int i = 0; i < [list count]; i++)
    {
        NSDictionary *dict = [list objectAtIndex:i];
        NSString *name =[[[dict objectForKey:@"resource"] objectForKey:@"fields"] objectForKey: @"name"];
        NSString *price =[[[dict objectForKey:@"resource"] objectForKey:@"fields"]
            objectForKey: @"price"];
        if (name.length == 3) {
            name = [name stringByAppendingString:@"/USD"];
        }
        if([name hasPrefix:@"USD"]) {
            NSString *output = [name substringFromIndex:4];
            NSLog(@"OUTPUT:%@", output);
            NSLog(@"PRICE:%@", price);
            [curs addObject:[NSString stringWithString: output]];
            [prices addObject:[NSString stringWithString: price]];
          //  [prices addObject:price];
            
        }
    }
    double coef = 0.0;
    
    for (int i = 0; i < [prices count]; i++) {
        NSString *current = [curs objectAtIndex:i];
        if (current == MainCurrency.text) {
            coef =1.0 / [[prices objectAtIndex:i] doubleValue];
            break;
        }
    }
    for (int i = 0; i < [prices count]; i++) {
        double a =[[prices objectAtIndex:i] doubleValue] * coef;
        
        [newprices addObject: [NSString stringWithString: @(a).stringValue]];
    }
    
    /*
    NSMutableDictionary *s = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSString *list =[s objectForKey:@"list"];
    NSLog(@"%@", list);*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"MSg:%d",[curs count]);
  return [curs count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
   // NSLog(curs[indexPath.row]);
    cell.textLabel.text = [curs objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [newprices objectAtIndex: indexPath.row];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"AnotherCurrency"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        EditViewController *destViewController = segue.destinationViewController;
        destViewController.MainCurrency = [curs objectAtIndex:indexPath.row];
        destViewController.delegate = self;
        destViewController.dataArray = curs;
        
        [[self navigationController] pushViewController:destViewController animated:YES];
        
    }
}

- (void)addItemViewController:(EditViewController*)controller didFinishEnteringItem:(NSString *)item
{
    NSLog(@"This was returned from ViewControllerB %@",item);
}

@end
