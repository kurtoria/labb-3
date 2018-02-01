//
//  TodoTableViewController.m
//  Labb3
//
//  Created by Victoria Grönqvist on 2018-02-01.
//  Copyright © 2018 Victoria Grönqvist. All rights reserved.
//

#import "TodoTableViewController.h"
#import "ListModel.h"
#import "alterMutableArray.h"

@interface TodoTableViewController ()
@property (nonatomic) NSMutableArray *todoItems;
@property (nonatomic) NSMutableArray *doneItems;

@end

@implementation TodoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.todoItems = @[@"first thing", @"second thing", @"third thing"].mutableCopy;
    self.doneItems = @[].mutableCopy;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//Do something at selected row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//Shows number of sections, 1 if we have nothing in doneItems
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return 2;
    
    if (self.doneItems != nil) {
        return 1;
    } else {
        return 0;
    }
    
}

//Gives the two different sections names
- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"To do";
    } else {
        return @"Done";
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.todoItems.count;
    
    if (section == 0) {
        return self.todoItems.count;
    } else
        return self.doneItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.section == 0) {
        cell.textLabel.text = self.todoItems[indexPath.row];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = self.doneItems[indexPath.row];
    }
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)doneWithItem {
    [self.todoItems moveFromArray:self.todoItems toArray:self.doneItems];
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.todoItems removeObject:indexPath];
        
        /*
        id object = [[[self.todoItems objectAtIndex:index] retain] autorelease];
        [self.todoItems removeObject:indexPath.row];
        [self.doneItems insertObject:object atIndex:0];
        
        [self.array removeObjectAtIndex:index];
        [self.array insertObject:object atIndex:newIndex];
         */
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
