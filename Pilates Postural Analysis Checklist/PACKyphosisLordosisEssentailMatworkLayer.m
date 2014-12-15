//
//  PACKyphosisLordosisEssentailMatworkLayer.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACKyphosisLordosisEssentailMatworkLayer.h"
#import "PACGlobal.h"

enum {
        tableViewSectionWarmup = 0
            , tableViewSectionExercises
            , tableViewSectionCount
};

static NSString* cell_identifier  = @"kypholodoris-layer-matwork-cell";

//-----------------------------------------------------------------------------
@interface PACSKyphosisLordosisEssentailMatworkLayerTableViewCell : UITableViewCell
@end

@implementation PACSKyphosisLordosisEssentailMatworkLayerTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
	return self;
}
@end
//-----------------------------------------------------------------------------
@interface PACKyphosisLordosisEssentailMatworkLayer ()
-(void)initLayer1;
-(void)initLayer2;
-(void)initLayer3;
- (UITableViewCell *)cellForWarmup:(UITableView*)tableView at:(NSIndexPath*)indexPath;
- (UITableViewCell *)cellForExercises:(UITableView*)tableView at:(NSIndexPath*)indexPath;
@end

@implementation PACKyphosisLordosisEssentailMatworkLayer

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[PACSKyphosisLordosisEssentailMatworkLayerTableViewCell class] forCellReuseIdentifier:cell_identifier];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

-(void)initLayer1
{
    _warmup = [NSArray arrayWithObjects:@"Breathing"
        , @"Imprint & Release"
        , @"Hip Release"
        , @"Supine Spinal Rotation"
        , @"Cat Stretch"
        , @"Hip Rolls"
        , @"Scapulae Isolation"
        , @"Arm Circles"
        , @"Head Nods"
        , @"Scapulae Elevatation & Depression"
        , nil];

    _warmup_details = [NSArray arrayWithObjects:@""
        , @""
        , @""
        , @"careful not to exaggerate lordosis, emphasize pec stretch"
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


    _exercises = [NSArray arrayWithObjects:@"Ab Prep"
        , @"Breast Stroke Prep 1 2"
        , @"Shell Stretch"
        , @"Half Roll Back"
        , @"One Leg Circle"
        , @"Spine Twist"
        , @"Obliques"
        , @"Spine Stretch Forward"
        , nil];

    _exercises_details = [NSArray arrayWithObjects:@"hands behind head, legs over arc barrel, imprinted"
        , @"over arc barrel"
        , @""
        , @""
        , @"both knees bent"
        , @"on a pillow, cross-legged, or pillow or arc"
        , @"prep, legs over arc barell, imprinted or prep, tabletop legs"
        , @"against wall"
        , nil];

    _exercises_bold = [NSArray arrayWithObjects:[NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
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
        , @"Supine Spinal Rotatioin"
        , @"Cat Stretch"
        , @"Hip Rolls"
        , @"Scapulae Isolation"
        , @"Arm Circles"
        , @"Head Nods"
        , @"Scapulae Elevatation & Depression"
        , nil];

    _warmup_details = [NSArray arrayWithObjects:@""
        , @""
        , @""
        , @"careful not to exaggerate lordosis, emphasize pec stretch"
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

    _exercises = [NSArray arrayWithObjects:@"Ab Prep"
        , @"Breast Stroke Prep 1 2"
        , @"Shell Stretch"
        , @"Hundred"
        , @"Half Roll Back"
        , @"One Leg Circle"
        , @"Spine Twist"
        , @"Rolling Like A Ball Prep"
        , @"Single Leg Stretch"
        , @"Obliques"
        , @"Heel Squeeze"
        , @"One Leg Kick Prep"
        , @"Obliques Roll Back"
        , @"Spine Stretch Forward"
        , @"Single Leg Extension"
        , @"Swimming Prep"
        , nil];

    _exercises_details = [NSArray arrayWithObjects:@"hands behind head, legs over arc barrel, imprinted"
        , @"over arc barrel"
        , @""
        , @"head down, legs over arc barrel, imprinted"
        , @""
        , @"both knees bent"
        , @"on a pillow, cross-legged, or pillow/arc"
        , @""
        , @"head down"
        , @"prep, legs over arc barrel, imprinted, or prep, tabletop legs"
        , @"pad under ASIS"
        , @"pad under ASIS"
        , @""
        , @"against wall"
        , @"pad under ASIS or over arc barrel"
        , @"on all fours kneeling"
        , nil];

    _exercises_bold = [NSArray arrayWithObjects:[NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , nil];

}
-(void)initLayer3
{
    _warmup = [NSArray arrayWithObjects:@"Breathing"
        , @"Imprint & Release"
        , @"Hip Release"
        , @"Supine Spinal Rotatioin"
        , @"Cat Stretch"
        , @"Hip Rolls"
        , @"Scapulae Isolation"
        , @"Arm Circles"
        , @"Head Nods"
        , @"Scapulae Elevatation & Depression"
        , nil];

    _warmup_details = [NSArray arrayWithObjects:@""
        , @""
        , @""
        , @"careful not to exaggerate lordosis, emphasize pec stretch"
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


    _exercises = [NSArray arrayWithObjects:@"Ab Prep"
        , @"Breast Stroke Prep 1 2"
        , @"Shell Stretch"
        , @"Hundred"
        , @"Half Roll Back"
        , @"One Leg Circle"
        , @"Spine Twist"
        , @"Rolling Like A Ball Prep"
        , @"Single Leg Stretch"
        , @"Obliques"
        , @"Shoulder Bridge Prep"
        , @"Heel Squeeze"
        , @"One Leg Kick Prep"
        , @"Saw"
        , @"Neck Pull Prep"
        , @"Obliques Roll Back"
        , @"Side Kicks"
        , @"Side Leg Lift Series"
        , @"Spine Stretch Forward"
        , @"Single Leg Extension"
        , @"Swan Dive Prep"
        , @"Shell Stretch"
        , @"Swimming Prep"
        , nil];


    _exercises_details = [NSArray arrayWithObjects:@"arms reaching, no barrel"
        , @"over arc barrel"
        , @""
        , @"head down, tabletop legs"
        , @""
        , @"both knees bent"
        , @"on a pillow, cross-legged, or pillow or arc"
        , @"full"
        , @"full"
        , @"prep, tabletop legs"
        , @""
        , @"pad under ASIS"
        , @"pad under ASIS"
        , @"on a pillow, or pillow or arc"
        , @"knees bent"
        , @""
        , @"bottom leg bent"
        , @"bottom leg bent"
        , @"against wall"
        , @"pad under ASIS or over arc barrel"
        , @"pad under ASIS"
        , @"arms back"
        , @"on all fours kneeling"
        , nil];

    _exercises_bold = [NSArray arrayWithObjects:[NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , nil];

}

-(void) setLayer:(PACKyphosisLordosisEssentailMatworkLayer_t)layer
{
    switch(layer){
        case kyphosisLordosisEssentailMatworkLayer1:
            self.navigationItem.title = @"Layer 1";
            [self initLayer1];
            break;
        case kyphosisLordosisEssentailMatworkLayer2:
            self.navigationItem.title = @"Layer 2";
            [self initLayer2];
            break;
        case kyphosisLordosisEssentailMatworkLayer3:
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
    PACSKyphosisLordosisEssentailMatworkLayerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

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
    PACSKyphosisLordosisEssentailMatworkLayerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

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
