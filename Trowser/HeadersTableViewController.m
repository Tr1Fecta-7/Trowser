//
//  HeadersTableViewController.m
//  Trowser
//
//  Created by Tr1Fecta on 19/12/2019.
//  Copyright © 2019 Tr1Fecta. All rights reserved.
//

#import "HeadersTableViewController.h"

@interface HeadersTableViewController ()

@end

@implementation HeadersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissVC)];
    self.navigationItem.rightBarButtonItem = doneItem;
    self.navigationItem.title = @"Headers";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;


}

-(void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.headersDictionary.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   NSString* cellIdentifier = @"cellid";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSArray* allHeaderKeys = [self.headersDictionary allKeys];
    
    cell.textLabel.text = allHeaderKeys[indexPath.row];
    cell.detailTextLabel.text = [self.headersDictionary objectForKey:allHeaderKeys[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.headersDictionary.count > 0) {
        NSArray* allHeaderKeys = [self.headersDictionary allKeys];
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Header"
        message:[NSString stringWithFormat:@"%@: %@", allHeaderKeys[indexPath.row], [self.headersDictionary objectForKey:allHeaderKeys[indexPath.row]]]
            preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
             handler:^(UIAlertAction * action) {}];
        
        UIAlertAction* closeHeadersViewAction = [UIAlertAction actionWithTitle:@"Exit Headers Viewer" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self dismissVC];
        }];
        
        [alert addAction:defaultAction];
        [alert addAction:closeHeadersViewAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
