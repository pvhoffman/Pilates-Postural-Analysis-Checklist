//
//  PACFlatBackEssentailMatworkLayer.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACFlatBackEssentialMatworkLayer.h"
#import "PACGlobal.h"

enum {
        tableViewSectionWarmup = 0
            , tableViewSectionExercises
            , tableViewSectionCount
};

static NSString* cell_identifier  = @"flatback-layer-matwork-cell";

//-----------------------------------------------------------------------------
typedef struct pac_flatback_essential_matwork_s {
    const char* name;
    const char* details;
    int is_bold;
}pac_flatback_essential_matwork_t;

static pac_flatback_essential_matwork_t pac_flatback_essential_matwork_layer1_warmup[] = { 
    {"Breathing", "", 1}
      , {"Imprint & Release", "", 1}
      , {"Hip Release", "", 1}
      , {"Supine Spinal Rotation", "", 1}
      , {"Cat Stretch", "", 1}
      , {"Hip Rolls", "", 1}
      , {"Scapula Isolation", "", 1}
      , {"Arm Circles", "", 1}
      , {"Head Nods", "", 1}
      , {"Elevation & Depression of Scapulae", "", 1}
      , {0, 0, -1}
};

static pac_flatback_essential_matwork_t pac_flatback_essential_matwork_layer1_exercises[] = { 
    {"Ab Prep", "", 1}
      , {"Breast Stroke Preps 1 2", "", 1}
      , {"Shell Stretch", "", 1}
      , {"Roll Up", "half", 1}
      , {"One Leg Circle", "both knees bent", 1}
      , {"Spine Twist", "one a pillow, cross-legged, or pillow or arc", 1}
      , {"Rolling Like a Ball Prep", "", 1}
      , {"Single Leg Stretch", "", 1}
      , {"Obliques", "prep, feet down", 1}
      , {"Spine Stretch Forward", "on a pillow, cross-legged, or pillow or arc", 1}
      , {"Single Leg Extension", "", 1}
      , {"Swan Dive Prep", "", 1}
      , {"Shell Stretch", "", 1}
      , {0, 0, -1}
};

static pac_flatback_essential_matwork_t pac_flatback_essential_matwork_layer2_warmup[]    = {
    {"Breathing", "", 0}
      , {"Imprint & Release", "", 0}
      , {"Hip Release", "", 0}
      , {"Supine Spinal Rotation", "", 0}
      , {"Cat Stretch", "", 0}
      , {"Hip Rolls", "", 0}
      , {"Scapula Isolation", "", 0}
      , {"Arm Circles", "", 0}
      , {"Head Nods", "", 0}
      , {"Elevation & Depression of Scapulae", "", 0}
      , {0, 0, -1}
};
static pac_flatback_essential_matwork_t pac_flatback_essential_matwork_layer2_exercises[] = { 
    {"Ab Prep", "arms reaching", 0}
      , {"Breast Stroke Preps 1 2", "", 0}
      , {"Shell Stretch", "", 0}
      , {"Hundred", "feet down", 1}
      , {"Roll Up", "half", 0}
      , {"One Leg Circle", "bottom leg straight", 1}
      , {"Spine Twist", "on a pillow, cross-legged, or pillow or arc", 0}
      , {"Rolling Like a Ball Prep", "", 0}
      , {"Single Leg Stretch", "", 0}
      , {"Obliques", "prep, feet down", 0}
      , {"Saw", "on a pillow or pillow or arc", 1}
      , {"Spine Stretch Forward", "on a pillow, cross-legged, or pillow or arc", 0}
      , {"Single Leg Extension", "", 0}
      , {"Swan Dive Prep", "", 0}
      , {"Shell Stretch", "", 0}
      , {"Leg Pull Front Prep", "", 1}
      , {0, 0, -1}
};

static pac_flatback_essential_matwork_t pac_flatback_essential_matwork_layer3_warmup[] = {
    {"Breathing", "", 0}
      , {"Imprint & Release", "", 0}
      , {"Hip Release", "", 0}
      , {"Supine Spinal Rotation", "", 0}
      , {"Cat Stretch", "", 0}
      , {"Hip Rolls", "", 0}
      , {"Scapula Isolation", "", 0}
      , {"Arm Circles", "", 0}
      , {"Head Nods", "", 0}
      , {"Elevation & Depression of Scapulae", "", 0}
      , {0, 0, -1}
};
static pac_flatback_essential_matwork_t pac_flatback_essential_matwork_layer3_exercises[] = { 
    {"Ab Prep", "", 0}
      , {"Breast Stroke Preps 1 2", "", 0}
      , {"Shell Stretch", "", 0}
      , {"Hundred", "feet down", 0}
      , {"Roll Up", "half", 0}
      , {"One Leg Circle", "bottom leg straight", 0}
      , {"Spine Twist", "on a pillow, cross legged, or pillow or arc", 0}
      , {"Rolling Like a Ball", "full", 1}
      , {"Single Leg Stretch", "", 0}
      , {"Obliques", "tabletop legs", 1}
      , {"Double Leg Stretch", "", 1}
      , {"Shell Stretch", "", 1}
      , {"Saw", "on a pillow or pillow or arc", 0}
      , {"Side Leg Lift Series", "", 1}
      , {"Spine Stretch Forward", "on a pillow, cross-legged, on pillow or arc", 0}
      , {"Single Leg Extension", "", 0}
      , {"Swan Dive Prep", "", 0}
      , {"Swimming Prep", "", 1}
      , {"Shell Stretch", "", 0}
      , {"Leg Pull Front Prep", "", 0}
      , {"Side Bend Prep", "", 1}
      , {"Push Up Prep", "", 1}
      , {0, 0, -1}
};

static pac_flatback_essential_matwork_t* _current_warmup_layer = 0;
static pac_flatback_essential_matwork_t* _current_exercise_layer = 0;
static int _row_count_warmup = 0;
static int _row_count_exercises = 0;
//-----------------------------------------------------------------------------
@interface PACFlatBackEssentialMatworkLayerTableViewCell : UITableViewCell
@end

@implementation PACFlatBackEssentialMatworkLayerTableViewCell 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
	return self;
}
@end
//-----------------------------------------------------------------------------
@interface PACFlatBackEssentialMatworkLayer ()
-(void)initLayer1;
-(void)initLayer2;
-(void)initLayer3;
- (UITableViewCell *)cellForWarmup:(UITableView*)tableView at:(NSIndexPath*)indexPath;
- (UITableViewCell *)cellForExercises:(UITableView*)tableView at:(NSIndexPath*)indexPath;
@end

@implementation PACFlatBackEssentialMatworkLayer

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[PACFlatBackEssentialMatworkLayerTableViewCell class] forCellReuseIdentifier:cell_identifier];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

-(void)initLayer1
{
    _current_warmup_layer   = pac_flatback_essential_matwork_layer1_warmup;
    _current_exercise_layer = pac_flatback_essential_matwork_layer1_exercises;

    _row_count_warmup     = (sizeof(pac_flatback_essential_matwork_layer1_warmup) / sizeof(pac_flatback_essential_matwork_layer1_warmup[0])) - 1;
    _row_count_exercises  = (sizeof(pac_flatback_essential_matwork_layer1_exercises) / sizeof(pac_flatback_essential_matwork_layer1_exercises[0])) - 1;
}
-(void)initLayer2
{
    _current_warmup_layer   = pac_flatback_essential_matwork_layer2_warmup;
    _current_exercise_layer = pac_flatback_essential_matwork_layer2_exercises;

    _row_count_warmup     = (sizeof(pac_flatback_essential_matwork_layer2_warmup) / sizeof(pac_flatback_essential_matwork_layer2_warmup[0])) - 1;
    _row_count_exercises  = (sizeof(pac_flatback_essential_matwork_layer2_exercises) / sizeof(pac_flatback_essential_matwork_layer2_exercises[0])) - 1;
}
-(void)initLayer3
{
    _current_warmup_layer   = pac_flatback_essential_matwork_layer3_warmup;
    _current_exercise_layer = pac_flatback_essential_matwork_layer3_exercises;

    _row_count_warmup     = (sizeof(pac_flatback_essential_matwork_layer3_warmup) / sizeof(pac_flatback_essential_matwork_layer3_warmup[0])) - 1;
    _row_count_exercises  = (sizeof(pac_flatback_essential_matwork_layer3_exercises) / sizeof(pac_flatback_essential_matwork_layer3_exercises[0])) - 1;
}

-(void) setLayer:(PACFlatBackEssentialMatworkLayer_t)layer
{
    switch(layer){
        case flatBackEssentialMatworkLayer1:
            self.navigationItem.title = @"Layer 1";
            [self initLayer1];
            break;
        case flatBackEssentialMatworkLayer2:
            self.navigationItem.title = @"Layer 2";
            [self initLayer2];
            break;
        case flatBackEssentialMatworkLayer3:
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
            return _row_count_warmup;
        case tableViewSectionExercises:
            return _row_count_exercises;
    }
    return 0;
}
- (UITableViewCell *)cellForWarmup:(UITableView*)tableView at:(NSIndexPath*)indexPath
{
    PACFlatBackEssentialMatworkLayerTableViewCell* cell = (PACFlatBackEssentialMatworkLayerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

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
    PACFlatBackEssentialMatworkLayerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    if(_current_exercise_layer[indexPath.row].is_bold){
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        cell.textLabel.text = [NSString stringWithFormat:@"➤ %s", _current_exercise_layer[indexPath.row].name];
    } else {
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        cell.textLabel.text = [NSString stringWithUTF8String:_current_exercise_layer[indexPath.row].name];
    }
    cell.detailTextLabel.text = [NSString stringWithUTF8String:_current_exercise_layer[indexPath.row].details];
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

