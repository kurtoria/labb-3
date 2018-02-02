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
#import "SavingLists.h"

@interface TodoTableViewController ()
//@property (nonatomic) NSMutableArray *todoItems;
//@property (nonatomic) NSMutableArray *doneItems;

@property (nonatomic) ListModel *model;
@property (nonatomic) SavingLists *saving;
//@property (nonatomic) UIImageView *

@end

@implementation TodoTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[ListModel alloc] init];
    self.saving = [[SavingLists alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self initialize];
    
}

-(void)initialize {
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)refresh {
    [self.tableView reloadData];
    //[self.model saveArrays];
}

/*
//Get saved arrays from NSUserDefault
- (void)getSavedArrays {
    [self.saving getArray:@"Todo"];
    [self.saving getArray:@"Done"];
}
 */

// UIAlertController, adding items to your to do-list.
- (IBAction)addButton:(id)sender {
    
    //Instance of UIAlertController
    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"Add item" message:@"Add item to your to do-list" preferredStyle:UIAlertControllerStyleAlert];
    
    //What happens when pressing ok
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        UITextField *textField = alert.textFields[0];
        [self.model.todoItems addObject:textField.text];
        NSLog(@"text was %@", textField.text);
        //[self saveArrays];
        [self refresh];
        [self.model saveArrays];
        
    }];
    
    //What happens when pressing cancel
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"cancel btn");
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    //What happens when clicking into checkbox
    //UIAlertAction *checkbox = [UIAlertAction ]
    
    [alert addAction:ok];
    [alert addAction:cancel];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Item";
        
        //textField.keyboardType = UIKeyboardTypeDefault;
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
    //[self refresh];
    (NSLog(@"todoItems: %@", self.model.todoItems));
}

//Move between done and todo on selected row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        NSMutableArray *item = [self.model.todoItems[indexPath.row] mutableCopy];
        [self.model.doneItems addObject:item];
        [self.model.todoItems removeObject:item];
        [self.model saveArrays];
    } else {
        NSMutableArray *item = [self.model.doneItems[indexPath.row] mutableCopy];
        [self.model.todoItems addObject:item];
        [self.model.doneItems removeObject:item];
        [self.model saveArrays];
    }
    
    (NSLog(@"todoItems: %@", self.model.todoItems));
    (NSLog(@"doneItems: %@", self.model.doneItems));
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self refresh];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state != UIGestureRecognizerStateEnded) {
        UITableViewCell *cell = (UITableViewCell*) [gesture view];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSLog(@"Longpress works");
        BOOL isImportant = NO;
        if (indexPath.section == 0) {
            if (isImportant) {
                
            } else {
                isImportant = YES;
            }
        }
        
    }
    
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
    if (section == 0) {
        return self.model.todoItems.count;
    } else
        return self.model.doneItems.count;
}

//Set one section to todoItems and other section to doneItems
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell" forIndexPath:indexPath];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [cell addGestureRecognizer:longPressGesture];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.model.todoItems[indexPath.row];
        (NSLog(@"todoItems: %@", self.model.todoItems));
    } else if (indexPath.section == 1) {
        cell.textLabel.text = self.model.doneItems[indexPath.row];
        (NSLog(@"todoItems: %@", self.model.doneItems));
    }
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if (indexPath.section == 0) {
            [self.model.todoItems removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        } else {
            [self.model.doneItems removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
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
