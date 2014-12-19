//
//  PACFlatBackMainTableViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/12/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACFlatBackMainTableViewController.h"
#import "PACFlatBackEssentialMatworkLayer.h"
#import "PACFlatBackEssentialReformerLayer.h"
/*
#import "PACSwayBackMatworkReformerLayer.h"
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

static NSString* cell_identifier  = @"flatback-back-cell";

@interface PACFlatBackMainTableViewController ()

@end

@implementation PACFlatBackMainTableViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];

    self.navigationItem.title = @"Flat-Back";

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
    PACFlatBackEssentialMatworkLayer* essentail_matwork = nil;
    PACFlatBackEssentialReformerLayer* essential_reformer = nil;
/*
    PACSwayBackMatworkReformerLayer* matwork_reformer = nil;
*/
    switch(indexPath.section){
        case tableViewSectionEssentailMatwork:
            essentail_matwork  = [[PACFlatBackEssentialMatworkLayer alloc] initWithStyle:UITableViewStyleGrouped];
            switch(indexPath.row){
                case tableViewRowLayer1:
                        [essentail_matwork setLayer:flatBackEssentialMatworkLayer1]; 
                        break;
                case tableViewRowLayer2:
                        [essentail_matwork setLayer:flatBackEssentialMatworkLayer2]; 
                        break;
                case tableViewRowLayer3:
                        [essentail_matwork setLayer:flatBackEssentialMatworkLayer3]; 
                        break;
            }
            [self.navigationController pushViewController:essentail_matwork animated:YES];
            break;
        case tableViewSectionEssentailReformer:
            essential_reformer  = [[PACFlatBackEssentialReformerLayer alloc] initWithStyle:UITableViewStyleGrouped];
            switch(indexPath.row){
                case tableViewRowLayer1:
                    [essential_reformer setLayer:flatBackEssentialReformerLayer1];
                    break;
                case tableViewRowLayer2:
                    [essential_reformer setLayer:flatBackEssentialReformerLayer2];
                    break;
                case tableViewRowLayer3:
                    [essential_reformer setLayer:flatBackEssentialReformerLayer3];
                    break;
            }
            [self.navigationController pushViewController:essential_reformer animated:YES];
            break;
        case tableViewSectionMatworkAndReformer:
/*
            matwork_reformer = [[PACSwayBackMatworkReformerLayer alloc] initWithStyle:UITableViewStyleGrouped];
            switch(indexPath.row){
                case tableViewRowLayer1:
                    [matwork_reformer setLayer:swayBackMatworkReformerLayer1];
                    break;
                case tableViewRowLayer2:
                    [matwork_reformer setLayer:swayBackMatworkReformerLayer2];
                    break;
                case tableViewRowLayer3:
                    [matwork_reformer setLayer:swayBackMatworkReformerLayer3];
                    break;
            }
            [self.navigationController pushViewController:matwork_reformer animated:YES];
*/
            break;
    }
}
@end

