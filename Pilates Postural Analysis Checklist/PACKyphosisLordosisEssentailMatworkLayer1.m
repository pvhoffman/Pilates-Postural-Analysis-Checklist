//
//  PACKyphosisLordosisEssentailMatworkLayer1.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/12/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACKyphosisLordosisEssentailMatworkLayer1.h"

enum {
        tableViewSectionWarmup = 0
            , tableViewSectionExercises
            , tableViewSectionCount
};


static NSArray* _warmup    = nil;
static NSArray* _exercises = nil;

static int _bold_warmup[] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
static int _bold_exercises[] = {1, 1, 1, 1, 1, 1, 1, 1};

static NSString* cell_identifier  = @"kypholodoris-layer1-matwork-cell";

//-----------------------------------------------------------------------------
@interface PACSKyphosisLordosisEssentailMatworkLayer1TableViewCell : UITableViewCell
@end

@implementation PACSKyphosisLordosisEssentailMatworkLayer1TableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
	return self;
}
@end
//-----------------------------------------------------------------------------



@interface PACKyphosisLordosisEssentailMatworkLayer1 ()

@end

@implementation PACKyphosisLordosisEssentailMatworkLayer1

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
        , @"Half Roll Back"
        , @"One Leg Circle"
        , @"Spine Twist"
        , @"Obliques"
        , @"Spine Stretch Forward"
        , nil];
    
    self.navigationItem.title = @"Layer 1";

    [self.tableView registerClass:[PACSKyphosisLordosisEssentailMatworkLayer1TableViewCell class] forCellReuseIdentifier:cell_identifier];
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
            if(_bold_warmup[indexPath.row]){
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
            }
            switch(indexPath.row){
                case 3:
                    cell.detailTextLabel.text = @"careful not to exaggerate lordosis, emphasize pec strech";
                    break;
            }
            cell.textLabel.text = [_warmup objectAtIndex:indexPath.row];
            break;
        case tableViewSectionExercises:
            if(_bold_exercises[indexPath.row]){
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
            }
            cell.textLabel.text = [_exercises objectAtIndex:indexPath.row];
            switch(indexPath.row){
                case 0:
                    cell.detailTextLabel.text = @"hands behind head, legs over arc barrel, imprinted";
                    break;
                case 4:
                    cell.detailTextLabel.text = @"both knees bent";
                    break;
                case 5:
                    cell.detailTextLabel.text = @"on pillow, cross-legged, or pillow or arc";
                    break;

            }
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
