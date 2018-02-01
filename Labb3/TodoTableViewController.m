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
#import "ListModel.h"

@interface TodoTableViewController ()
//@property (nonatomic) NSMutableArray *todoItems;
//@property (nonatomic) NSMutableArray *doneItems;

@property (nonatomic) ListModel *model;

@end

@implementation TodoTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[ListModel alloc] init];
    
    //ListModel array
    self.model.todoItems = @[@{@"todo": @"some things", @"category": @"work"},
                             @{@"todo": @"other things", @"category": @"home"}].mutableCopy;
    self.model.doneItems = @[@{@"todo": @"nothing", @"category": @"home"}].mutableCopy;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//Move between done and todo on selected row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NSMutableArray *item = [self.model.todoItems[indexPath.row] mutableCopy];
        //UITableViewCellAccessoryCheckmark;
        [self.model.doneItems addObject:item];
        [self.model.todoItems removeObject:item];
    } else {
        NSMutableArray *item = [self.model.doneItems[indexPath.row] mutableCopy];
        //UITableViewCellAccessoryNone;
        [self.model.todoItems addObject:item];
        [self.model.doneItems removeObject:item];
    }
    
    (NSLog(@"todoItems: %@", self.model.todoItems));
    (NSLog(@"todoItems: %@", self.model.doneItems));
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self refresh];
}

-(void)refresh {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//Shows number of sections, 1 if we have nothing in doneItems
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return 2;
    
    if (self.model.doneItems != nil) {
        return 2;
    } else {
        return 1;
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
        return self.model.todoItems.count;
    } else
        return self.model.doneItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.section == 0) {
        cell.textLabel.text = self.model.todoItems[indexPath.row][@"todo"];
        (NSLog(@"todoItems: %@", self.model.todoItems));
    } else if (indexPath.section == 1) {
        cell.textLabel.text = self.model.doneItems[indexPath.row][@"todo"];
        (NSLog(@"todoItems: %@", self.model.doneItems));
    }
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)doneWithItem {
    //[self.model.todoItems moveFromArray:self.todoItems toArray:self.doneItems];
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if (indexPath.section == 0) {
            [self.model.todoItems removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self refresh];
        } else {
            [self.model.doneItems removeObjectAtIndex:indexPath.row];
            [self refresh];
        }
        
        
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
