//
//  TodoTableViewController.m
//  Labb3
//
//  Created by Victoria Grönqvist on 2018-02-01.
//  Copyright © 2018 Victoria Grönqvist. All rights reserved.
//

#import "TodoTableViewController.h"
#import "ListModel.h"
#import "AddItemViewController.h"

@interface TodoTableViewController ()
@property (nonatomic) ListModel *model;
@end

@implementation TodoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.model = [[ListModel alloc] init];
    [self initialize];
}

-(void)initialize {
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)refresh {
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self refresh];
}
 
//Move between done, todo and important on selected row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NSMutableArray *item = [self.model.todoItems[indexPath.row] mutableCopy];
        [self.model moveFrom:self.model.todoItems to:self.model.doneItems withItem:item];
    } else if (indexPath.section == 1) {
        NSMutableArray *item = [self.model.importantItems[indexPath.row] mutableCopy];
        [self.model moveFrom:self.model.importantItems to:self.model.doneItems withItem:item];
    } else {
        NSMutableArray *item = [self.model.doneItems[indexPath.row] mutableCopy];
        [self.model moveFrom:self.model.doneItems to:self.model.todoItems withItem:item];
    }
    [self.model saveArrays];
    (NSLog(@"todoItems: %@", self.model.todoItems));
    (NSLog(@"doneItems: %@", self.model.doneItems));
    (NSLog(@"importantItems: %@", self.model.importantItems));
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//Shows number of sections, 1 if we have nothing in doneItems
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

//Gives the two different sections names
- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"To do";
    } else if (section == 1) {
        return @"Important";
    } else {
        return @"Done";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.model.todoItems.count;
    } else if (section == 1) {
        return self.model.importantItems.count;
    } else {
        return self.model.doneItems.count;
    }
}

//Set one section to todoItems and other section to doneItems
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        [self setCellText:cell ToArray:self.model.todoItems atIndex:indexPath.row];
        (NSLog(@"todoItems: %@", self.model.todoItems));
    } else if (indexPath.section == 1) {
        [self setCellText:cell ToArray:self.model.importantItems atIndex:indexPath.row];
        (NSLog(@"importantItems: %@", self.model.importantItems));
    } else if (indexPath.section == 2) {
        [self setCellText:cell ToArray:self.model.doneItems atIndex:indexPath.row];
        (NSLog(@"todoItems: %@", self.model.doneItems));
    }
    return cell;
}

- (void) setCellText:(UITableViewCell*)cell ToArray:(NSMutableArray*)array atIndex:(long)index {
    cell.textLabel.text = array[index];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        if (indexPath.section == 0) {
            [self.model deleteFromArray:self.model.todoItems atRow:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        } else if (indexPath.section == 1) {
            [self.model deleteFromArray:self.model.importantItems atRow:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        } else {
            [self.model deleteFromArray:self.model.doneItems atRow:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Add"]) {
        AddItemViewController *add = [segue destinationViewController];
        add.model = self.model;
    }
}


@end
