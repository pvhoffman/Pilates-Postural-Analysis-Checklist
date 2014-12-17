//
//  PACKyphosisLordosisEssentailReformerLayer.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACKyphosisLordosisEssentailReformerLayer.h"
#import "PACGlobal.h"

enum {
        tableViewSectionWarmup = 0
            , tableViewSectionCount
};

static NSString* cell_identifier  = @"kypholodoris-layer-reformer-cell";

//-----------------------------------------------------------------------------
@interface PACSKyphosisLordosisEssentailReformerLayerTableViewCell : UITableViewCell
@end

@implementation PACSKyphosisLordosisEssentailReformerLayerTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
	return self;
}
@end
//-----------------------------------------------------------------------------

@interface PACKyphosisLordosisEssentailReformerLayer ()
-(void)initLayer1;
-(void)initLayer2;
-(void)initLayer3;
@end

@implementation PACKyphosisLordosisEssentailReformerLayer
- (void)viewDidLoad 
{
    [super viewDidLoad];

    [self.tableView registerClass:[PACSKyphosisLordosisEssentailReformerLayerTableViewCell class] forCellReuseIdentifier:cell_identifier];
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
    return [_exercises count];
}
-(void) setLayer:(PACKyphosisLordosisEssentailReformerLayer_t)layer
{
    switch(layer){
        case kyphosisLordosisEssentailReformerLayer1:
            self.navigationItem.title = @"Layer 1";
            [self initLayer1];
            break;
        case kyphosisLordosisEssentailReformerLayer2:
            self.navigationItem.title = @"Layer 2";
            [self initLayer2];
            break;
        case kyphosisLordosisEssentailReformerLayer3:
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
    _exercises = [NSArray arrayWithObjects:@"Footwork 1 2 3 4 5"
        , @"Second Position 1"
        , @"Midback Series 1 2 3 4"
        , @"Stomach Massage Prep"
        , @"Mermaid"
        , @"Knee Stretches Prep"
        , @"Hip Rolls Prep"
        , @"Single Thigh Stretch"
        , nil];

    _exercises_details = [NSArray arrayWithObjects:@""
        , @""
        , @""
        , @""
        , @""
        , @""
        , @""
        , @"standing"
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
    _exercises = [NSArray arrayWithObjects:@"Footwork 1 2 3 4 5"
        , @"Second Position 1 2"
        , @"Hundred"
        , @"Bend & Stretch 1 2"
        , @"Lift & Lower 1 2"
        , @"Adductor Stretch"
        , @"Midback Series 1 2 3 4 5"
        , @"Back Rowing Preps 1 2 3 5"
        , @"Side Arm Preps Setting 1 2 3 4"
        , @"Side Twist Sitting"
        , @"Front Row Preps 1 3"
        , @"Stomach Massage Prep 2"
        , @"LB Arms Pulling Straps 1 2"
        , @"SB Round Back"
        , @"Mermaid"
        , @"Knee Stretches Prep 1 2"
        , @"Running"
        , @"Hip Rolls Prep"
        , @"Single Thigh Stretch"
        , nil];

    _exercises_details = [NSArray arrayWithObjects:@""
        , @""
        , @"tabletop legs, head down"
        , @""
        , @""
        , @""
        , @""
        , @"on a pillow"
        , @"on a pillow"
        , @"on a pillow"
        , @"on a pillow"
        , @""
        , @""
        , @"light resistance, instructor holding feet"
        , @""
        , @""
        , @""
        , @""
        , @""
        , @"standing"
        , nil];

    _exercises_bold = [NSArray arrayWithObjects:[NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
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
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , nil];
}
-(void)initLayer3
{
    _exercises = [NSArray arrayWithObjects:@"Footwork 1 2 3 4 5"
        , @"Second Position 1 2"
        , @"Single Leg 1 3"
        , @"Hundred"
        , @"Bend & Stretch 1 2"
        , @"Short Spine Prep"
        , @"Back Rowing Preps 1 2 3 5"
        , @"Side Arm Preps Sitting 1 2 3 4"
        , @"Side Twist Sitting"
        , @"Front Rowing Preps 1 3"
        , @"Stomach Massage Prep 2"
        , @"LB Arms Pulling Straps 1 2"
        , @"SB Round Back"
        , @"SB Twist"
        , @"SB Tree"
        , @"Elephant 1 2"
        , @"Mermaid"
        , @"Leg Circles 1"
        , @"Knee Stretches 1 2"
        , @"Running"
        , @"Hip Rolls Prep"
        , @"Single Thight Stretch"
        , @"Side Splits 1 2"
        , nil];

    _exercises_details = [NSArray arrayWithObjects:@""
        , @""
        , @""
        , @"tabletop legs, head lifted"
        , @""
        , @""
        , @"on a pillow"
        , @"on a pillow"
        , @"on a pillow"
        , @"on a pillow"
        , @""
        , @"light resistance, instructor holding feet"
        , @""
        , @""
        , @"half roll back"
        , @""
        , @""
        , @""
        , @""
        , @""
        , @""
        , @"standing"
        , @""
        , nil];

    _exercises_bold = [NSArray arrayWithObjects:[NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:0]
        , [NSNumber numberWithInt:1]
        , nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    PACSKyphosisLordosisEssentailReformerLayerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    if([[_exercises_bold objectAtIndex:indexPath.row] intValue]){
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        cell.textLabel.text = [NSString stringWithFormat:@"➤ %@", [_exercises objectAtIndex:indexPath.row]];
    } else {
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        cell.textLabel.text = [_exercises objectAtIndex:indexPath.row];
    }

    cell.detailTextLabel.text= [_exercises_details objectAtIndex:indexPath.row];

    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0f, tableView.frame.size.width, 24.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = NSLocalizedString(@"Exercises", @"");
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;

}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
	return 26.0f;
}
@end
