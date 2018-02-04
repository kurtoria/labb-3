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
    self.textLabel.borderStyle = [UIColor blackColor];
    self.textLabel.layer.borderWidth = 1.5f;
}

- (IBAction)addButton:(id)sender {
    [self.model.todoItems addObject:self.textLabel.text];
    NSLog(@"Todo addView: %@", self.model.todoItems);
    [self.model saveArrays];

    //Jumps back to TodoTableView
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
