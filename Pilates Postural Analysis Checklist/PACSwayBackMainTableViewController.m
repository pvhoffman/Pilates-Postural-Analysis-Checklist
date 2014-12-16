//
//  PACSwayBackMainTableViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/12/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACSwayBackMainTableViewController.h"
#import "PACSwayBackEssentialMatworkLayer.h"
#import "PACSwayBackEssentialReformerLayer.h"
/*
#import "PACSwayBackEssentailMatworkReformerLayer.h"
*/
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

static NSString* cell_identifier  = @"swayback-back-cell";

@interface PACSwayBackMainTableViewController ()

@end

@implementation PACSwayBackMainTableViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];

    self.navigationItem.title = @"Sway-Back";

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
    PACSwayBackEssentialMatworkLayer* essentail_matwork = nil;
    PACSwayBackEssentialReformerLayer* essential_reformer = nil;
/*
    PACSwayBackEssentailMatworkReformerLayer* matwork_reformer = nil;
    switch(indexPath.section){
        case tableViewSectionEssentailMatwork:
            essentail_matwork  = [[PACSwayBackEssentailMatworkLayer alloc] initWithStyle:UITableViewStyleGrouped];
            switch(indexPath.row){
                case tableViewRowLayer1:
                        [essentail_matwork setLayer:swayBackEssentailMatworkLayer1]; 
                        break;
                case tableViewRowLayer2:
                        [essentail_matwork setLayer:SwayBackEssentailMatworkLayer2]; 
                        break;
                case tableViewRowLayer3:
                        [essentail_matwork setLayer:SwayBackEssentailMatworkLayer3]; 
                        break;
            }
            [self.navigationController pushViewController:essentail_matwork animated:YES];
            break;
        case tableViewSectionEssentailReformer:
            essential_reformer  = [[PACSwayBackEssentailReformerLayer alloc] initWithStyle:UITableViewStyleGrouped];
            switch(indexPath.row){
                case tableViewRowLayer1:
                    [essential_reformer setLayer:swayBackEssentailReformerLayer1];
                    break;
                case tableViewRowLayer2:
                    [essential_reformer setLayer:swayBackEssentailReformerLayer2];
                    break;
                case tableViewRowLayer3:
                    [essential_reformer setLayer:swayBackEssentailReformerLayer3];
                    break;
            }
            [self.navigationController pushViewController:essential_reformer animated:YES];
            break;
        case tableViewSectionMatworkAndReformer:
            matwork_reformer = [[PACSwayBackEssentailMatworkReformerLayer alloc] initWithStyle:UITableViewStyleGrouped];
            switch(indexPath.row){
                case tableViewRowLayer1:
                    [matwork_reformer setLayer:swayBackEssentailMatworkReformerLayer1];
                    break;
                case tableViewRowLayer2:
                    [matwork_reformer setLayer:swayBackEssentailMatworkReformerLayer2];
                    break;
                case tableViewRowLayer3:
                    [matwork_reformer setLayer:swayBackEssentailMatworkReformerLayer3];
                    break;
            }
            [self.navigationController pushViewController:matwork_reformer animated:YES];
            break;
    }
*/
}
@end

