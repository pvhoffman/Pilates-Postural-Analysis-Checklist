//
//  PACSwayBackEssentailReformerLayer.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACSwayBackEssentialReformerLayer.h"
#import "PACGlobal.h"

enum {
        tableViewSectionWarmup = 0
            , tableViewSectionExercises
            , tableViewSectionCount
};

static NSString* cell_identifier  = @"swayback-layer-reformer-cell";

//-----------------------------------------------------------------------------
@interface PACSwayBackEssentialReformerLayerTableViewCell : UITableViewCell
@end

@implementation PACSwayBackEssentialReformerLayerTableViewCell 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
	return self;
}
@end
//-----------------------------------------------------------------------------
@interface PACSwayBackEssentialReformerLayer ()
-(void)initLayer1;
-(void)initLayer2;
-(void)initLayer3;
- (UITableViewCell *)cellForWarmup:(UITableView*)tableView at:(NSIndexPath*)indexPath;
- (UITableViewCell *)cellForExercises:(UITableView*)tableView at:(NSIndexPath*)indexPath;
@end

@implementation PACSwayBackEssentialReformerLayer

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[PACSwayBackEssentialReformerLayerTableViewCell class] forCellReuseIdentifier:cell_identifier];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

-(void)initLayer1
{
    _warmup = [NSArray arrayWithObjects:@""
       , nil];

    _warmup_details = [NSArray arrayWithObjects:@""
        , nil];

    _warmup_bold = [NSArray arrayWithObjects:[NSNumber numberWithInt:1]
        , nil];

    _exercises = [NSArray arrayWithObjects:@""
        , nil];

    _exercises_details = [NSArray arrayWithObjects:@""
        , nil];

    _exercises_bold = [NSArray arrayWithObjects:[NSNumber numberWithInt:1]
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

    _exercises = [NSArray arrayWithObjects:@""
        , nil];

    _exercises_details = [NSArray arrayWithObjects:@""
        , nil];

    _exercises_bold = [NSArray arrayWithObjects:[NSNumber numberWithInt:0]
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

    _exercises = [NSArray arrayWithObjects:@""
        , nil];

    _exercises_details = [NSArray arrayWithObjects:@""
        , nil];

    _exercises_bold = [NSArray arrayWithObjects:[NSNumber numberWithInt:1]
        , nil];

}

-(void) setLayer:(PACSwayBackEssentialReformerLayer_t)layer
{
    switch(layer){
        case swayBackEssentialReformerLayer1:
            self.navigationItem.title = @"Layer 1";
            [self initLayer1];
            break;
        case swayBackEssentialReformerLayer2:
            self.navigationItem.title = @"Layer 2";
            [self initLayer2];
            break;
        case swayBackEssentialReformerLayer3:
            self.navigationItem.title = @"Layer 3";
            [self initLayer3];
            break;
        default:
            break;
    }
    [self.tableView reloadData];
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
            return [_exercises count];
    }
    return 0;
}
- (UITableViewCell *)cellForWarmup:(UITableView*)tableView at:(NSIndexPath*)indexPath
{
    PACSwayBackEssentialReformerLayerTableViewCell* cell = (PACSwayBackEssentialReformerLayerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

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
- (UITableViewCell *)cellForExercises:(UITableView*)tableView at:(NSIndexPath*)indexPath
{
    PACSwayBackEssentialReformerLayerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    if([[_exercises_bold objectAtIndex:indexPath.row] intValue]){
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        cell.textLabel.text = [NSString stringWithFormat:@"➤ %@", [_exercises objectAtIndex:indexPath.row]];
    } else {
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        cell.textLabel.text = [_exercises objectAtIndex:indexPath.row];
    }
    cell.detailTextLabel.text = [_exercises_details objectAtIndex:indexPath.row];
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    switch(indexPath.section){
        case tableViewSectionWarmup:
            return [self cellForWarmup:tableView at:indexPath];
        case tableViewSectionExercises:
            return [self cellForExercises:tableView at:indexPath];
            break;
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
            label.text = NSLocalizedString(@"Warm up", @"");
            break;
        case tableViewSectionExercises:
            label.text = NSLocalizedString(@"Exercises", @"");
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
