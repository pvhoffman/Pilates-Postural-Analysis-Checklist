//
//  PACKyphosisLordosisEssentailMatworkReformerLayer.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACKyphosisLordosisEssentailMatworkReformerLayer.h"
#import "PACGlobal.h"

enum {
        tableViewSectionWarmup = 0
            , tableViewSectionExercises
            , tableViewSectionCount
};

static NSString* cell_identifier  = @"kypholodoris-layer-matworkreformer-cell";

//-----------------------------------------------------------------------------
@interface PACSKyphosisLordosisEssentailMatworkReformerLayerTableViewCell : UITableViewCell
@end

@implementation PACSKyphosisLordosisEssentailMatworkReformerLayerTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
	return self;
}
@end
//-----------------------------------------------------------------------------

@interface PACKyphosisLordosisEssentailMatworkReformerLayer ()
-(void)initLayer1;
-(void)initLayer2;
-(void)initLayer3;
-(UITableViewCell *)cellForWarmup:(UITableView*)tableView at:(NSIndexPath*)indexPath;
-(UITableViewCell *)cellForExercises:(UITableView*)tableView at:(NSIndexPath*)indexPath;
@end

@implementation PACKyphosisLordosisEssentailMatworkReformerLayer
- (void)viewDidLoad 
{
    [super viewDidLoad];

    [self.tableView registerClass:[PACSKyphosisLordosisEssentailMatworkReformerLayerTableViewCell class] forCellReuseIdentifier:cell_identifier];
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
    switch(section){
        case tableViewSectionWarmup:
            return [_warmup count];
        case tableViewSectionExercises:
            return [_exercises_matwork count] + [_exercises_reformer count] + 2;
    }
    return 0;
}
-(void) setLayer:(PACKyphosisLordosisEssentailMatworkReformerLayer_t)layer
{
    switch(layer){
        case kyphosisLordosisEssentailMatworkReformerLayer1:
            self.navigationItem.title = @"Layer 1";
            [self initLayer1];
            break;
        case kyphosisLordosisEssentailMatworkReformerLayer2:
            self.navigationItem.title = @"Layer 2";
            [self initLayer2];
            break;
        case kyphosisLordosisEssentailMatworkReformerLayer3:
            self.navigationItem.title = @"Layer 3";
            [self initLayer3];
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}
-(void)initLayer1
{
    _warmup = [NSArray arrayWithObjects:@"foo"
        , nil];

    _warmup_details = [NSArray arrayWithObjects:@"bar"
        , nil];

    _warmup_bold = [NSArray arrayWithObjects:[NSNumber numberWithInt:1]
        , nil];

    _exercises_matwork = [NSArray arrayWithObjects:@"foo"
        , nil];

    _exercises_reformer = [NSArray arrayWithObjects:@"foo"
        , nil];

    _exercises_details_matwork = [NSArray arrayWithObjects:@"bar"
        , nil];

    _exercises_details_reformer = [NSArray arrayWithObjects:@"bar"
        , nil];

    _exercises_bold_matwork = [NSArray arrayWithObjects:[NSNumber numberWithInt:1]
        , nil];

    _exercises_bold_reformer = [NSArray arrayWithObjects:[NSNumber numberWithInt:1]
        , nil];

}
-(void)initLayer2
{
    _warmup = [NSArray arrayWithObjects:@""
        , nil];

    _warmup_details = [NSArray arrayWithObjects:@""
        , nil];

    _warmup_bold = [NSArray arrayWithObjects:[NSNumber numberWithInt:0]
        , nil];

    _exercises_matwork = [NSArray arrayWithObjects:@""
        , nil];

    _exercises_reformer = [NSArray arrayWithObjects:@""
        , nil];

    _exercises_details_matwork = [NSArray arrayWithObjects:@""
        , nil];

    _exercises_details_reformer = [NSArray arrayWithObjects:@""
        , nil];

    _exercises_bold_matwork = [NSArray arrayWithObjects:[NSNumber numberWithInt:0]
        , nil];

    _exercises_bold_reformer = [NSArray arrayWithObjects:[NSNumber numberWithInt:0]
        , nil];

}
-(void)initLayer3
{
    _warmup = [NSArray arrayWithObjects:@""
        , nil];

    _warmup_details = [NSArray arrayWithObjects:@""
        , nil];

    _warmup_bold = [NSArray arrayWithObjects:[NSNumber numberWithInt:0]
        , nil];

    _exercises_matwork = [NSArray arrayWithObjects:@""
        , nil];

    _exercises_reformer = [NSArray arrayWithObjects:@""
        , nil];

    _exercises_details_matwork = [NSArray arrayWithObjects:@""
        , nil];

    _exercises_details_reformer = [NSArray arrayWithObjects:@""
        , nil];

    _exercises_bold_matwork = [NSArray arrayWithObjects:[NSNumber numberWithInt:0]
        , nil];

    _exercises_bold_reformer = [NSArray arrayWithObjects:[NSNumber numberWithInt:0]
        , nil];

}
-(UITableViewCell *)cellForWarmup:(UITableView*)tableView at:(NSIndexPath*)indexPath
{
    PACSKyphosisLordosisEssentailMatworkReformerLayerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    if([[_warmup_bold objectAtIndex:indexPath.row] intValue]){
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        cell.textLabel.text = [NSString stringWithFormat:@"➤ %@", [_warmup objectAtIndex:indexPath.row]];
    } else {
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        cell.textLabel.text = [_warmup objectAtIndex:indexPath.row];
    }
       
    cell.detailTextLabel.text = [_warmup_details objectAtIndex:indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    int indent = 0;

    if(indexPath.section == tableViewSectionExercises){
        if(indexPath.row != 0 && indexPath.row != [_exercises_matwork count] + 1){
            indent = 1;
        }
    }
    return indent;
}
-(UITableViewCell *)cellForExercises:(UITableView*)tableView at:(NSIndexPath*)indexPath
{
    PACSKyphosisLordosisEssentailMatworkReformerLayerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    if(indexPath.row == 0){
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        cell.textLabel.text = @"Matwork";
    } else if(indexPath.row <= [_exercises_matwork count]){
        if([[_exercises_bold_matwork objectAtIndex:indexPath.row - 1] intValue]){
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
            cell.textLabel.text = [NSString stringWithFormat:@"➤ %@", [_exercises_matwork objectAtIndex:indexPath.row - 1]];
        } else {
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
            cell.textLabel.text = [_exercises_matwork objectAtIndex:indexPath.row - 1];
        }
        cell.detailTextLabel.text = [_exercises_details_matwork objectAtIndex:indexPath.row - 1];
    } else if(indexPath.row == [_exercises_matwork count] + 1){
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        cell.textLabel.text = @"Reformer";
    } else {
        if([[_exercises_bold_reformer objectAtIndex:indexPath.row - 3] intValue]){
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
            cell.textLabel.text = [NSString stringWithFormat:@"➤ %@", [_exercises_reformer objectAtIndex:indexPath.row - 3]];
        } else {
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
            cell.textLabel.text = [_exercises_reformer objectAtIndex:indexPath.row - 3];
        }
        cell.detailTextLabel.text = [_exercises_details_reformer objectAtIndex:indexPath.row - 3];
    }
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    switch(indexPath.section){
        case tableViewSectionWarmup:
            return [self cellForWarmup:tableView at:indexPath];
        case tableViewSectionExercises:
            return [self cellForExercises:tableView at:indexPath];
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0f, tableView.frame.size.width, 24.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    switch(section){
        case tableViewSectionWarmup:
            label.text = NSLocalizedString(@"Warm up - Matwork", @"");
            break;
        case tableViewSectionExercises:
            label.text = NSLocalizedString(@"Exercises - Matwork & Reformer", @"");
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
@end
