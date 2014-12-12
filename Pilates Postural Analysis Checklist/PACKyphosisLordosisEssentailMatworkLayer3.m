//
//  PACKyphosisLordosisEssentailMatworkLayer3.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/12/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACKyphosisLordosisEssentailMatworkLayer3.h"

enum {
        tableViewSectionWarmup = 0
            , tableViewSectionExercises
            , tableViewSectionCount
};


static NSArray* _warmup    = nil;
static NSArray* _exercises = nil;


static NSString* cell_identifier  = @"kypholodoris-layer3-matwork-cell";


@interface PACKyphosisLordosisEssentailMatworkLayer3 ()

@end

@implementation PACKyphosisLordosisEssentailMatworkLayer3

- (void)viewDidLoad 
{
    [super viewDidLoad];

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
 

    self.navigationItem.title = @"Layer 3";

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
    switch(section){
        case tableViewSectionWarmup:
            return [_warmup count];
        case tableViewSectionExercises:
            return [_exercises count];
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    switch(indexPath.section){
        case tableViewSectionWarmup:
            cell.textLabel.text = [_warmup objectAtIndex:indexPath.row];
            break;
        case tableViewSectionExercises:
            cell.textLabel.text = [_exercises objectAtIndex:indexPath.row];
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