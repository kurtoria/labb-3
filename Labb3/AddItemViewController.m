//
//  AddItemViewController.m
//  Labb3
//
//  Created by Victoria Grönqvist on 2018-02-02.
//  Copyright © 2018 Victoria Grönqvist. All rights reserved.
//

#import "AddItemViewController.h"
#import "ListModel.h"

@interface AddItemViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textLabel;
@property (weak, nonatomic) IBOutlet UISwitch *importantSwitch;

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textLabel.layer.borderWidth = 1.5f;
}

- (IBAction)addButton:(id)sender {
    if (self.importantSwitch.isOn) {
        [self.model.importantItems addObject:self.textLabel.text];
        NSLog(@"Todo addView: %@", self.model.todoItems);
        [self.model saveArrays];
    } else {
        [self.model.todoItems addObject:self.textLabel.text];
        NSLog(@"Todo addView: %@", self.model.todoItems);
        [self.model saveArrays];
    }
    /*
    [self.model.todoItems addObject:self.textLabel.text];
    NSLog(@"Todo addView: %@", self.model.todoItems);
    [self.model saveArrays];
    */
     
    //Jumps back to TodoTableView
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
