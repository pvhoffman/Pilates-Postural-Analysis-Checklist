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
        tableViewRowSaveProfile         = 0
            , tableViewRowLoadProfile   = 1
            , tableViewRowEmailAnalysis = 2
            , tableViewRowDismiss       = 3
            , tableViewRowCount         = 4
};

enum {
        tableViewSectionCount = 1
};

static NSString* cell_identifier = @"main-menu-cell";

@interface PACMainMenuViewController ()

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
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 16.0f, tableView.frame.size.width, 28.0f)];
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
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
