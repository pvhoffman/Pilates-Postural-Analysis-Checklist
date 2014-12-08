//
//  PACMainMenuViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/4/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACMainMenuViewController.h"
#import "PACGlobal.h"

enum {
        tableViewRowNewProfile         = 0
            , tableViewRowSaveProfile   = 1
            , tableViewRowLoadProfile   = 2
            , tableViewRowEmailAnalysis = 3
            , tableViewRowDismiss       = 4
            , tableViewRowCount         = 5
};

enum {
        tableViewSectionCount = 1
};

static NSString* cell_identifier = @"main-menu-cell";

@interface PACMainMenuViewController ()
-(void) saveProfile;
-(void) loadProfile;
@end

@implementation PACMainMenuViewController

- (void) loadView
{
    [super loadView];
    [self.tableView registerClass:[UITableViewCell class ] forCellReuseIdentifier:cell_identifier];
}
- (void)viewDidLoad 
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return tableViewSectionCount ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return tableViewRowCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    switch(indexPath.row){
        case tableViewRowNewProfile:
            cell.textLabel.text = @"New Analysis";
            break;
        case tableViewRowSaveProfile:
            cell.textLabel.text = @"Save Analysis";
            break;
        case tableViewRowLoadProfile:
            cell.textLabel.text = @"Load Analysis";
            break;
        case tableViewRowEmailAnalysis:
            cell.textLabel.text = @"Email Analysis";
            break;
        case tableViewRowDismiss:
            cell.textLabel.text = @"Dismiss Menu";
            break;
    }
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 18.0f, tableView.frame.size.width, 28.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.text = NSLocalizedString(@"Menu", @"");
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;
}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
	return 42.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{  
    switch(indexPath.row){
        case tableViewRowNewProfile:
            pac_reset_all(); 
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListMainDidChange] object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListSideViewDidChange] object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListFrontViewDidChange] object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListBackViewDidChange] object:nil];
            break;
        case tableViewRowSaveProfile:
            [self saveProfile];
            break;
        case tableViewRowLoadProfile:
            [self loadProfile];
            break;
    }

    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void) saveProfile
{
    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@"Save as" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    dialog.alertViewStyle = UIAlertViewStylePlainTextInput;

    [dialog show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString* name = [[alertView textFieldAtIndex:0] text];
        pac_save_analysis([name UTF8String]);
    }
}

@end
