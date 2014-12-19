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
            tableViewSectionExercises = 0
            , tableViewSectionCount
};

static NSString* cell_identifier  = @"swayback-layer-reformer-cell";

//-----------------------------------------------------------------------------
typedef struct pac_swayback_essential_reformer_s {
    const char* name;
    const char* details;
    int is_bold;
} pac_swayback_essential_reformer_t;

static pac_swayback_essential_reformer_t pac_swayback_essential_reformer_layer1[] = { 
    {"Footwork 1 2 3 4 5", "", 1}
        , {"Second Position 1", "", 1}
        , {"Bend & Stretch 1 2", "", 1}
        , {"Lift & Lower 1 2", "", 1}
        , {"Midback Series 1 2 3 4 5", "", 1}
        , {"Back Rowing Preps 1 2 3 4 5", "on a pillow", 1}
        , {"Side Arm Preps Sitting 1 2 3 4", "on a pillow", 1}
        , {"Side Twist Sitting", "on a pillow", 1}
        , {"Front Rowing Preps 1 3", "on a pillow", 1}
        , {"Stomach Massage Preps 1 2", "", 1}
        , {"Mermaid", "", 1}
        , {"Leg Circles 1 2", "", 1}
        , {"Knee Stretches Prep 1", "", 1}
        , {"Running", "", 1}
        , {"Hip Rolls Prep", "", 1}
        , {0, 0, -1}
};
static pac_swayback_essential_reformer_t pac_swayback_essential_reformer_layer2[] = { 
    {"Footwork 1 2 3 4 5", "", 0}
        , {"Second Position 1 2 3", "", 1}
        , {"Single Leg 1", "", 1}
        , {"Hundred", "tabletop legs", 1}
        , {"Bend & Stretch 1 2", "", 0}
        , {"Lift & Lower 1 2", "", 0}
        , {"Short Spine Prep", "", 1}
        , {"Back Rowing Preps 1 2 3 4 5 6 7 8", "on a pillow", 1}
        , {"Side Arm Preps Sitting 1 2 3 4", "on a pillow", 0}
        , {"Side Twist Sitting", "on a pillow", 0}
        , {"Front Rowing Preps 1 2 3", "on a pillow", 1}
        , {"Stomach Massage Prep 1 2", "", 0}
        , {"LB Arms Pulling Straps 1 2 3", "", 1}
        , {"SB Round Back", "", 1}
        , {"SB Straight Back", "", 1}
        , {"SB Twist", "", 1}
        , {"SB Tree", "", 1}
        , {"Elephant 1", "", 1}
        , {"Mermaid", "", 0}
        , {"Leg Circles 1 2", "", 0}
        , {"Knee Stretches Prep 1 2", "", 1}
        , {"Running", "", 0}
        , {"Hip Rolls Prep", "full", 1}
        , {0, 0, -1}
};
static pac_swayback_essential_reformer_t pac_swayback_essential_reformer_layer3[] = { 
    {"Footwork 1 2 3 4 5", "", 0}
        , {"Second Position 1 2 3", "", 0}
        , {"Single Leg 1 2", "", 1}
        , {"Hundred", "tabletop legs", 0}
        , {"Bend & Stretch", "", 0}
        , {"Short Spine", "full", 1}
        , {"Back Rowing Preps 1 2 3 4 5 6 7 8", "on a pillow", 0}
        , {"Side Arm Preps Sitting 1 2 3 4", "on a pillow", 0}
        , {"Side Twist Sitting", "on a pillow", 0}
        , {"Front Rowing Preps 1 2 3", "on a pillow", 0}
        , {"Stomach Massage Prep 1 2", "", 0}
        , {"LB Arms Pulling Straps 1 2 3", "", 0}
        , {"SB Round Back", "", 0}
        , {"SB Straight Back", "", 0}
        , {"SB Twist", "", 0}
        , {"SB Tree", "", 0}
        , {"Elephant 1 2", "", 1}
        , {"Mermaid", "", 0}
        , {"Leg Circles 1 2", "", 0}
        , {"Knee Stretches Prep 1 2", "", 0}
        , {"Running", "", 0}
        , {"Hip Rolls", "", 0}
        , {0, 0, -1}
};
static pac_swayback_essential_reformer_t* _current_layer = 0;
static int _row_count_exercises = 0;
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
    _current_layer = pac_swayback_essential_reformer_layer1;
    _row_count_exercises  = (sizeof(pac_swayback_essential_reformer_layer1) / sizeof(pac_swayback_essential_reformer_layer1[0])) - 1;
}
-(void)initLayer2
{
    _current_layer = pac_swayback_essential_reformer_layer2;
    _row_count_exercises  = (sizeof(pac_swayback_essential_reformer_layer2) / sizeof(pac_swayback_essential_reformer_layer2[0])) - 1;
}
-(void)initLayer3
{
    _current_layer = pac_swayback_essential_reformer_layer3;
    _row_count_exercises  = (sizeof(pac_swayback_essential_reformer_layer3) / sizeof(pac_swayback_essential_reformer_layer3[0])) - 1;
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
    return _row_count_exercises;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    PACSwayBackEssentialReformerLayerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    if(_current_layer[indexPath.row].is_bold){
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        cell.textLabel.text = [NSString stringWithFormat:@"➤ %s", _current_layer[indexPath.row].name];
    } else {
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        cell.textLabel.text = [NSString stringWithUTF8String:_current_layer[indexPath.row].name];
    }
    cell.detailTextLabel.text = [NSString stringWithUTF8String:_current_layer[indexPath.row].details];
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
