//
//  PACKyphosisLordosisMainTableViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/12/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACKyphosisLordosisMainTableViewController.h"
#import "PACKyphosisLordosisEssentailMatworkLayer1.h"
#import "PACKyphosisLordosisEssentailMatworkLayer2.h"
#import "PACKyphosisLordosisEssentailMatworkLayer3.h"
#import "PACGlobal.h"

enum {
    tableViewSectionEssentailMatwork = 0
        , tableViewSectionEssentailReformer
        , tableViewSectionMatworkAndReformer
        , tableViewSectionCount
};

enum {
    tableViewRowLayer1 = 0
        , tableViewRowLayer2
        , tableViewRowLayer3
        , tableViewRowCount
};

static NSString* cell_identifier  = @"kypholodoris-back-cell";


@interface PACKyphosisLordosisMainTableViewController ()

@end

@implementation PACKyphosisLordosisMainTableViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];

    self.navigationItem.title = @"Kyphosis-Lordosis";

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_identifier];
    
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return tableViewSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return tableViewRowCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    cell.accessoryType   = UITableViewCellAccessoryDisclosureIndicator;

    switch(indexPath.row){
        case tableViewRowLayer1:
            cell.textLabel.text = @"Layer 1";
            break;
        case tableViewRowLayer2:
            cell.textLabel.text = @"Layer 2";
            break;
        case tableViewRowLayer3:
            cell.textLabel.text = @"Layer 3";
            break;
    }

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0f, tableView.frame.size.width, 24.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    switch(section){
        case tableViewSectionEssentailMatwork:
            label.text = NSLocalizedString(@"Essential Matwork", @"");
            break;
        case tableViewSectionEssentailReformer:
            label.text = NSLocalizedString(@"Essential Reformer", @"");
            break;
        case tableViewSectionMatworkAndReformer:
            label.text = NSLocalizedString(@"Matwork & Reformer", @"");
            break;
    }
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;

}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
	return 26.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        switch(indexPath.section){
            case tableViewSectionEssentailMatwork:
                switch(indexPath.row){
                    case tableViewRowLayer1:
                        [self.navigationController pushViewController:[[PACKyphosisLordosisEssentailMatworkLayer1 alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
                        break;
                    case tableViewRowLayer2:
                        [self.navigationController pushViewController:[[PACKyphosisLordosisEssentailMatworkLayer2 alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
                        break;
                    case tableViewRowLayer3:
                        [self.navigationController pushViewController:[[PACKyphosisLordosisEssentailMatworkLayer3 alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
                        break;
                }
            break;
            case tableViewSectionEssentailReformer:
            break;
            case tableViewSectionMatworkAndReformer:
            break;
        }
}
@end

