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
    _warmup = [NSArray arrayWithObjects:@"Breathing"
        , @"Imprint & Release"
        , @"Hip Release"
        , @"Supine Spinal Rotation"
        , @"Cat Stretch"
        , @"Hip Rolls"
        , @"Scapulae Isolatioin"
        , @"Arm Circles"
        , @"Head Nods"
        , @"Scapulae Elevation & Depression"
        , nil];

    _warmup_details = [NSArray arrayWithObjects:@""
        , @""
        , @""
        , @"don't exaggerate lordosis, emphasize pec stretch"
        , @""
        , @""
        , @""
        , @""
        , @""
        , @""
        , nil];

    _warmup_bold = [NSArray arrayWithObjects:[NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , nil];

    _exercises_matwork = [NSArray arrayWithObjects:@"Ab Prep"
        , @"Breast Stroke Preps 1 2"
        , @"Shell Stretch"
        , @"Half Roll Back"
        , @"One Leg Circle"
        , @"Spine Twist"
        , @"Obliques"
        , @"Spine Stretch Forward"
        , nil];

    _exercises_reformer = [NSArray arrayWithObjects:@"Footwork 1 2 3 4 5"
        , @"Midback Series 1 2 3 4"
        , @"Mermaid"
        , @"Hip Rolls Prep"
        , @"Single Thigh Stretch"
        , nil];

    _exercises_details_matwork = [NSArray arrayWithObjects:@"head supported, legs over arc barrel, imprinted"
        , @"over arc barrel"
        , @""
        , @""
        , @"both knees bent"
        , @"on a pillow, cross-legged, or raised mat"
        , @"prep, legs over arc barrel imprinted, or tabletop legs"
        , @"against wall"
        , nil];

    _exercises_details_reformer = [NSArray arrayWithObjects:@""
        , @""
        , @""
        , @""
        , @"standing"
        , nil];

    _exercises_bold_matwork = [NSArray arrayWithObjects:[NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , nil];

    _exercises_bold_reformer = [NSArray arrayWithObjects:[NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , nil];

}
-(void)initLayer2
{
    _warmup = [NSArray arrayWithObjects:@"Breathing"
        , @"Imprint & Release"
        , @"Hip Release"
        , @"Supine Spinal Rotation"
        , @"Cat Stretch"
        , @"Hip Rolls"
        , @"Scapulae Isolatioin"
        , @"Arm Circles"
        , @"Head Nods"
        , @"Scapulae Elevation & Depression"
        , nil];

    _warmup_details = [NSArray arrayWithObjects:@""
        , @""
        , @""
        , @"don't exaggerate lordosis, emphasize pec stretch"
        , @""
        , @""
        , @""
        , @""
        , @""
        , @""
        , nil];

    _warmup_bold = [NSArray arrayWithObjects:[NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , nil];

    _exercises_matwork = [NSArray arrayWithObjects:@"Ab Prep"
        , @"Breast Stroke Preps 1 2"
        , @"Shell Stretch"
        , @"Hundred"
        , @"Half Roll Back"
        , @"One Leg Circle"
        , @"Spine Twist"
        , @"Rolling Like a Ball Prep"
        , @"Obliques"
        , @"Spine Stretch Forward"
        , @"Single Leg Extension"
        , @"Swimming Prep"
        , nil];

    _exercises_reformer = [NSArray arrayWithObjects:@"Footwork 1 2 3 4 5"
        , @"Second Position 1 3"
        , @"Bend & Stretch"
        , @"Lift & Lower 1 2"
        , @"Midback Series 1 2 3 4 5"
        , @"Side Arm Preps Sitting"
        , @"Stomach Massage Prep 2"
        , @"Mermaid"
        , @"Knee Stretches Prep 1 2"
        , @"Hip Rolls Prep"
        , @"Single Thigh Stretch"
        , nil];

    _exercises_details_matwork = [NSArray arrayWithObjects:@"head supported, legs over arc barrel, imprinted"
        , @"over arc barrel"
        , @""
        , @"head down, legs over arch barrel, imprinted"
        , @""
        , @"both knees bent"
        , @"on a pillow, cross-legged, or raised mat"
        , @""
        , @"prep, legs over arc barrel imprinted, or tabletop legs"
        , @"against wall"
        , @"pad under ASIS over arc barrel"
        , @""
        , nil];

    _exercises_details_reformer = [NSArray arrayWithObjects:@""
        , @""
        , @""
        , @""
        , @""
        , @""
        , @"on a pillow"
        , @"on a pillow"
        , @""
        , @""
        , @""
        , @""
        , @"standing"
        , nil];


    _exercises_bold_matwork = [NSArray arrayWithObjects:[NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , nil];

    _exercises_bold_reformer = [NSArray arrayWithObjects:[NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , nil];
}
-(void)initLayer3
{
    _warmup = [NSArray arrayWithObjects:@"Breathing"
        , @"Imprint & Release"
        , @"Hip Release"
        , @"Supine Spinal Rotation"
        , @"Cat Stretch"
        , @"Hip Rolls"
        , @"Scapulae Isolatioin"
        , @"Arm Circles"
        , @"Head Nods"
        , @"Scapulae Elevation & Depression"
        , nil];

    _warmup_details = [NSArray arrayWithObjects:@""
        , @""
        , @""
        , @"don't exaggerate lordosis, emphasize pec stretch"
        , @""
        , @""
        , @""
        , @""
        , @""
        , @""
        , nil];

    _warmup_bold = [NSArray arrayWithObjects:[NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , nil];

    _exercises_matwork = [NSArray arrayWithObjects:@"Ab Prep"
        , @"Breast Stroke Preps 1 2"
        , @"Shell Stretch"
        , @"Half Roll Back"
        , @"One Leg Circle"
        , @"Spine Twist"
        , @"Rolling Like a Ball Prep"
        , @"Single Leg Stretch"
        , @"Obliques"
        , @"Shoulder Bridge Prep"
        , @"Swan Dive Prep"
        , @"Shell Stretch"
        , @"Side Kicks"
        , @"Side Leg Lift Series"
        , nil];

    _exercises_reformer = [NSArray arrayWithObjects:@"Footwork 1 2 3 4 5"
        , @"Single Leg 1 4"
        , @"Hundred"
        , @"Back Rowing Preps 1 2 3 4 5"
        , @"Side Arm Preps Sitting"
        , @"Side Twist Sitting"
        , @"Front Rowing Preps 1 3"
        , @"LB Arms Pulling Straps 1 2"
        , @"Stomach Massage Prep 2"
        , @"SB Tree"
        , @"Elephant 1 2"
        , @"Mermaid"
        , @"Leg Circles 1"
        , @"Hip Rolls Prep"
        , @"Single Thigh Stretch"
        , nil];

    _exercises_details_matwork = [NSArray arrayWithObjects:@"arms reaching, no barrel"
        , @"over arc barrel"
        , @""
        , @""
        , @"both knees bent"
        , @"on a pillow, cross-legged, or raised mat"
        , @"full"
        , @"head down on a pillow"
        , @"prep, tabletop legs"
        , @""
        , @"pad under ASIS"
        , @""
        , @"bottom leg bent"
        , @"bottom leg bent"
        , @"on all fours, or kneeling"
        , nil];

    _exercises_details_reformer = [NSArray arrayWithObjects:@""
        , @""
        , @"tabletop legs, head down"
        , @"on a pillow"
        , @"on a pillow"
        , @"on a pillow"
        , @"on a pillow"
        , @"light resistance, instructor holding feet"
        , @""
        , @"half roll back"
        , @""
        , @""
        , @""
        , @"full"
        , @"standing"
        , nil];

    _exercises_bold_matwork = [NSArray arrayWithObjects:[NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , nil];

    _exercises_bold_reformer = [NSArray arrayWithObjects:[NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
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
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
        cell.textLabel.text = @"Matwork";
        cell.detailTextLabel.text = @"";
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
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
        cell.textLabel.text = @"Reformer";
        cell.detailTextLabel.text = @"";
    } else {
        if([[_exercises_bold_reformer objectAtIndex:indexPath.row - ([_exercises_matwork count] + 2)] intValue]){
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
            cell.textLabel.text = [NSString stringWithFormat:@"➤ %@", [_exercises_reformer objectAtIndex:indexPath.row - ([_exercises_matwork count] + 2)]];
        } else {
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
            cell.textLabel.text = [_exercises_reformer objectAtIndex:indexPath.row - ([_exercises_matwork count] + 2)];
        }
        cell.detailTextLabel.text = [_exercises_details_reformer objectAtIndex:indexPath.row - ([_exercises_matwork count] + 2)];
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
            label.text = NSLocalizedString(@"Warm up: Matwork", @"");
            break;
        case tableViewSectionExercises:
            label.text = NSLocalizedString(@"Exercises: Matwork & Reformer", @"");
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
