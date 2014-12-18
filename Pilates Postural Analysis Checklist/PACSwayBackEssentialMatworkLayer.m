//
//  PACSwayBackEssentailMatworkLayer.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACSwayBackEssentialMatworkLayer.h"
#import "PACGlobal.h"

enum {
        tableViewSectionWarmup = 0
            , tableViewSectionExercises
            , tableViewSectionCount
};

static NSString* cell_identifier  = @"swayback-layer-matwork-cell";

//-----------------------------------------------------------------------------
typedef struct pac_swayback_essential_matwork_s {
    const char* name;
    const char* details;
    int is_bold;
}pac_swayback_essential_matwork_t;

static pac_swayback_essential_matwork_t pac_swayback_essential_matwork_layer1_warmup[] = {
        {"", "", 1}
      , {0, 0, -1}
};
static pac_swayback_essential_matwork_t pac_swayback_essential_matwork_layer1_exercises[] = {
        {"", "", 1}
      , {0, 0, -1}
};

static pac_swayback_essential_matwork_t pac_swayback_essential_matwork_layer2_warmup[] = {
        {"", "", 1}
      , {0, 0, -1}
};
static pac_swayback_essential_matwork_t pac_swayback_essential_matwork_layer2_exercises[] = {
        {"", "", 1}
      , {0, 0, -1}
};

static pac_swayback_essential_matwork_t pac_swayback_essential_matwork_layer3_warmup[] = {
        {"", "", 1}
      , {0, 0, -1}
};
static pac_swayback_essential_matwork_t pac_swayback_essential_matwork_layer3_exercises[] = {
        {"", "", 1}
      , {0, 0, -1}
};

static pac_swayback_essential_matwork_t* _current_warmup_layer = 0;
static pac_swayback_essential_matwork_t* _current_exercise_layer = 0;
static int _row_count_warmup = 0;
static int _row_count_exercises = 0;
//-----------------------------------------------------------------------------
@interface PACSwayBackEssentialMatworkLayerTableViewCell : UITableViewCell
@end

@implementation PACSwayBackEssentialMatworkLayerTableViewCell 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
	return self;
}
@end
//-----------------------------------------------------------------------------
@interface PACSwayBackEssentialMatworkLayer ()
-(void)initLayer1;
-(void)initLayer2;
-(void)initLayer3;
- (UITableViewCell *)cellForWarmup:(UITableView*)tableView at:(NSIndexPath*)indexPath;
- (UITableViewCell *)cellForExercises:(UITableView*)tableView at:(NSIndexPath*)indexPath;
@end

@implementation PACSwayBackEssentialMatworkLayer

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[PACSwayBackEssentialMatworkLayerTableViewCell class] forCellReuseIdentifier:cell_identifier];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

-(void)initLayer1
{
    _current_warmup_layer   = pac_swayback_essential_matwork_layer1_warmup;
    _current_exercise_layer = pac_swayback_essential_matwork_layer1_exercises;

    _row_count_warmup     = (sizeof(pac_swayback_essential_matwork_layer1_warmup) / sizeof(pac_swayback_essential_matwork_layer1_warmup[0])) - 1;
    _row_count_exercises  = (sizeof(pac_swayback_essential_matwork_layer1_exercises) / sizeof(pac_swayback_essential_matwork_layer1_exercises[0])) - 1;
}
-(void)initLayer2
{
    _current_warmup_layer   = pac_swayback_essential_matwork_layer2_warmup;
    _current_exercise_layer = pac_swayback_essential_matwork_layer2_exercises;

    _row_count_warmup     = (sizeof(pac_swayback_essential_matwork_layer2_warmup) / sizeof(pac_swayback_essential_matwork_layer2_warmup[0])) - 1;
    _row_count_exercises  = (sizeof(pac_swayback_essential_matwork_layer2_exercises) / sizeof(pac_swayback_essential_matwork_layer2_exercises[0])) - 1;
}
-(void)initLayer3
{
    _current_warmup_layer   = pac_swayback_essential_matwork_layer3_warmup;
    _current_exercise_layer = pac_swayback_essential_matwork_layer3_exercises;

    _row_count_warmup     = (sizeof(pac_swayback_essential_matwork_layer3_warmup) / sizeof(pac_swayback_essential_matwork_layer3_warmup[0])) - 1;
    _row_count_exercises  = (sizeof(pac_swayback_essential_matwork_layer3_exercises) / sizeof(pac_swayback_essential_matwork_layer3_exercises[0])) - 1;
}

-(void) setLayer:(PACSwayBackEssentialMatworkLayer_t)layer
{
    switch(layer){
        case swayBackEssentialMatworkLayer1:
            self.navigationItem.title = @"Layer 1";
            [self initLayer1];
            break;
        case swayBackEssentialMatworkLayer2:
            self.navigationItem.title = @"Layer 2";
            [self initLayer2];
            break;
        case swayBackEssentialMatworkLayer3:
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
    PACSwayBackEssentialMatworkLayerTableViewCell* cell = (PACSwayBackEssentialMatworkLayerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

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
    PACSwayBackEssentialMatworkLayerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

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

