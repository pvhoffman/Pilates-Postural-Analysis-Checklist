//
//  PACSwayBackMatworkReformerLayer.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACSwayBackMatworkReformerLayer.h"
#import "PACGlobal.h"

enum {
        tableViewSectionWarmup = 0
            , tableViewSectionExercises
            , tableViewSectionCount
};

static NSString* cell_identifier  = @"swayback-layer-matwork-reformer-cell";
//-----------------------------------------------------------------------------
typedef struct pac_swayback_matwork_reformer_s {
    const char* name;
    const char* details;
    int is_bold;
} pac_swayback_matwork_reformer_t;

pac_swayback_matwork_reformer_t pac_swayback_matwork_reformer_layer1_warmup[] = {
     {"Breathing", "", 1}
        , {"Imprint & Release", "", 1}
        , {"Hip Release", "", 1}
        , {"Suping Spinal Rotation", "", 1}
        , {"Cat Stretch", "", 1}
        , {"Hip Rolls", "", 1}
        , {"Scapulae Isolation", "", 1}
        , {"Arm Circles", "", 1}
        , {"Head Nods", "", 1}
        , {"Elevation & Depression of Scapulae", "", 1}
        , {0, 0, -1}
};
pac_swayback_matwork_reformer_t pac_swayback_matwork_reformer_layer1_exercises[] = {
        {"Matwork", "", -1}
        , {"Ab Prep", "hands behind head", 1}
        , {"Breast Stroke Preps 1 2", "", 1}
        , {"Shell Stretch", "", 1}
        , {"Half Roll Back", "", 1}
        , {"One Leg Circle", "both knees bent", 1}
        , {"Single Leg Stretch", "", 1}
        , {"Obliques", "prep, tabletop legs less than 90°", 1}
        , {"Spine Stretch Forward", "on pillow, cross-legged or pillow or arc", 1}
      , {"Reformer", "", -1}
        , {"Footwork 1 2 3 4 5", "", 1}
        , {"Bend & Stretch 1 2", "", 1}
        , {"Midback Series 1 2 3 4 5", "", 1}
        , {"Side Arm Preps Sitting 1 2 3 4", "on a pillow", 1}
        , {"Side Twist Sitting", "on a pillow", 1}
        , {"Mermaid", "", 1}
      , {0, 0, -1}
};
pac_swayback_matwork_reformer_t pac_swayback_matwork_reformer_layer2_warmup[] = { 
     {"Breathing", "", 1}
        , {"Imprint & Release", "", 1}
        , {"Hip Release", "", 1}
        , {"Suping Spinal Rotation", "", 1}
        , {"Cat Stretch", "", 1}
        , {"Hip Rolls", "", 1}
        , {"Scapulae Isolation", "", 1}
        , {"Arm Circles", "", 1}
        , {"Head Nods", "", 1}
        , {"Elevation & Depression of Scapulae", "", 1}
        , {0, 0, -1}
};
pac_swayback_matwork_reformer_t pac_swayback_matwork_reformer_layer2_exercises[] = {
        {"Matwork", "", -1}
        , {"Ab Prep", "arms reaching", 1}
        , {"Breast Stroke Preps 1 2", "", 0}
        , {"Shell Stretch", "", 0}
        , {"Hundred", "tabletop legs less than 90°", 1}
        , {"One Leg Circle", "bottom leg straight", 1}
        , {"Rolling Like a Ball Prep", "", 1}
        , {"Single Leg Stretch", "", 0}
        , {"Obliques", "prep, table top legs, less than 90°", 0}
        , {"Spine Stretch Forward", "on a pillow, cross-legged or pillow or arc", 0}
        , {"Single Leg Extension", "", 1}
        , {"Swan Dive Prep", "", 1}
      , {"Reformer", "", -1}
        , {"Footwork 1 2 3 4 5", "", 0}
        , {"Second Position 1 2 3", "", 1}
        , {"Bend & Stretch 1 2", "", 0}
        , {"Lift & Lower 1 2", "", 1}
        , {"Back Rowing Preps 1 2 3 4 5 6 7 8", "on a pillow", 1}
        , {"Front Rowing Preps 1 2 3", "on a pillow", 1}
        , {"Mermaid", "", 0}
        , {"Leg Circles 1 2", "", 1}
        , {"Knee Stretches Prep 2", "", 1}
        , {"Hip Rolls Prep", "full", 1}
        , {0, 0, -1}
};
pac_swayback_matwork_reformer_t pac_swayback_matwork_reformer_layer3_warmup[] = {
     {"Breathing", "", 1}
        , {"Imprint & Release", "", 1}
        , {"Hip Release", "", 1}
        , {"Suping Spinal Rotation", "", 1}
        , {"Cat Stretch", "", 1}
        , {"Hip Rolls", "", 1}
        , {"Scapulae Isolation", "", 1}
        , {"Arm Circles", "", 1}
        , {"Head Nods", "", 1}
        , {"Elevation & Depression of Scapulae", "", 1}
        , {0, 0, -1}
};
pac_swayback_matwork_reformer_t pac_swayback_matwork_reformer_layer3_exercises[] = {
        {"Matwork", "", -1}
        , {"Ab Prep", "", 0}
        , {"Hundred", "feet down, neutral pelvis", 1}
        , {"Roll Up", "half", 1}
        , {"Rolling Line a Ball Prep", "full", 1}
        , {"Single Leg Stretch", "", 0}
        , {"Obliques", "feet down, neutral pelvis", 1}
        , {"Double Leg Stretch", "", 1}
        , {"Breast Stroke", "", 1}
        , {"Shell Stretch", "", 1}
        , {"Side Kicks", "", 1}
        , {"Side Leg Lift Series", "", 1}
        , {"Spine Stretch Forward", "on a pillow, cross-legged or pillow or arc", 0}
        , {"Swan Dive", "with legs", 1}
      , {"Reformer", "", -1}
        , {"Footwork 1 2 3 4 5", "", 0}
        , {"Second Position 1 2 3", "", 0}
        , {"Single Leg 1 2", "", 1}
        , {"Hundred", "tabletop legs", 1}
        , {"Bend & Stretch 1 2", "", 0}
        , {"Short Spine Prep", "full", 1}
        , {"Back Rowing Preps 1 2 3 4 5 6 7 8", "on a pillow", 0}
        , {"Front Rowing Preps 1 2 3", "on a pillow", 0}
        , {"LB Arms Pulling Straps 1 2 3", "", 1}
        , {"SB Round Back", "", 1}
        , {"SB Straight Back", "", 1}
        , {"SB Twist", "", 1}
        , {"SB Tree", "", 1}
        , {"Elephant 2", "", 1}
        , {"Mermaid", "", 0}
        , {"Leg Circles 1 2", "", 0}
        , {"Knee Stretches 2", "", 0}
        , {"Hip Rolls", "", 0}
        , {0, 0, -1}
};

static pac_swayback_matwork_reformer_t* _current_warmup_layer = 0;
static pac_swayback_matwork_reformer_t* _current_exercises_layer = 0;

static int _warmup_layer_rowcount = 0;
static int _exercises_layer_rowcount = 0;
//-----------------------------------------------------------------------------
@interface PACSwayBackMatworkReformerLayerTableViewCell : UITableViewCell
@end

@implementation PACSwayBackMatworkReformerLayerTableViewCell 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
	return self;
}
@end
//-----------------------------------------------------------------------------
@interface PACSwayBackMatworkReformerLayer ()
-(void)initLayer1;
-(void)initLayer2;
-(void)initLayer3;
- (UITableViewCell *)cellForWarmup:(UITableView*)tableView at:(NSIndexPath*)indexPath;
- (UITableViewCell *)cellForExercises:(UITableView*)tableView at:(NSIndexPath*)indexPath;
@end

@implementation PACSwayBackMatworkReformerLayer

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[PACSwayBackMatworkReformerLayerTableViewCell class] forCellReuseIdentifier:cell_identifier];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

-(void)initLayer1
{
    _current_warmup_layer    = pac_swayback_matwork_reformer_layer1_warmup;
    _current_exercises_layer = pac_swayback_matwork_reformer_layer1_exercises;

    _warmup_layer_rowcount    = (sizeof(pac_swayback_matwork_reformer_layer1_warmup) / sizeof(pac_swayback_matwork_reformer_layer1_warmup[0])) - 1;
    _exercises_layer_rowcount = (sizeof(pac_swayback_matwork_reformer_layer1_exercises) / sizeof(pac_swayback_matwork_reformer_layer1_exercises[0])) - 1;
}
-(void)initLayer2
{
    _current_warmup_layer    = pac_swayback_matwork_reformer_layer2_warmup;
    _current_exercises_layer = pac_swayback_matwork_reformer_layer2_exercises;

    _warmup_layer_rowcount    = (sizeof(pac_swayback_matwork_reformer_layer2_warmup) / sizeof(pac_swayback_matwork_reformer_layer2_warmup[0])) - 1;
    _exercises_layer_rowcount = (sizeof(pac_swayback_matwork_reformer_layer2_exercises) / sizeof(pac_swayback_matwork_reformer_layer2_exercises[0])) - 1;
}
-(void)initLayer3
{
    _current_warmup_layer    = pac_swayback_matwork_reformer_layer3_warmup;
    _current_exercises_layer = pac_swayback_matwork_reformer_layer3_exercises;

    _warmup_layer_rowcount    = (sizeof(pac_swayback_matwork_reformer_layer3_warmup) / sizeof(pac_swayback_matwork_reformer_layer3_warmup[0])) - 1;
    _exercises_layer_rowcount = (sizeof(pac_swayback_matwork_reformer_layer3_exercises) / sizeof(pac_swayback_matwork_reformer_layer3_exercises[0])) - 1;
}

-(void) setLayer:(PACSwayBackMatworkReformerLayer_t)layer
{
    switch(layer){
        case swayBackMatworkReformerLayer1:
            self.navigationItem.title = @"Layer 1";
            [self initLayer1];
            break;
        case swayBackMatworkReformerLayer2:
            self.navigationItem.title = @"Layer 2";
            [self initLayer2];
            break;
        case swayBackMatworkReformerLayer3:
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
            return _warmup_layer_rowcount;
        case tableViewSectionExercises:
            return _exercises_layer_rowcount;
    }
    return 0;
}
- (UITableViewCell *)cellForWarmup:(UITableView*)tableView at:(NSIndexPath*)indexPath
{
    PACSwayBackMatworkReformerLayerTableViewCell* cell = (PACSwayBackMatworkReformerLayerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    if(_current_warmup_layer[indexPath.row].is_bold){
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        cell.textLabel.text = [NSString stringWithFormat:@"➤ %s", _current_warmup_layer[indexPath.row].name];
    } else {
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        cell.textLabel.text = [NSString stringWithUTF8String:_current_warmup_layer[indexPath.row].name];
    }
    cell.detailTextLabel.text = [NSString stringWithUTF8String:_current_warmup_layer[indexPath.row].details];
    return cell;
}
- (UITableViewCell *)cellForExercises:(UITableView*)tableView at:(NSIndexPath*)indexPath
{
    PACSwayBackMatworkReformerLayerTableViewCell* cell = (PACSwayBackMatworkReformerLayerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    if(_current_exercises_layer[indexPath.row].is_bold){
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        cell.textLabel.text = [NSString stringWithFormat:@"➤ %s", _current_exercises_layer[indexPath.row].name];
    } else {
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        cell.textLabel.text = [NSString stringWithUTF8String:_current_exercises_layer[indexPath.row].name];
    }
    cell.detailTextLabel.text = [NSString stringWithUTF8String:_current_exercises_layer[indexPath.row].details];
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
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    int indent = 0;

    if(indexPath.section == tableViewSectionExercises){
        indent = ((0 == strcmp(_current_exercises_layer[indexPath.row].name, "Matwork") || 0 == strcmp(_current_exercises_layer[indexPath.row].name, "Reformer")) ? 0 : 1); 
    }
    return indent;
}
@end

