//
//  PACMainMenuView.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/8/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACMainMenuView.h"
#import "PACGlobal.h"

enum {
    tagContentView = 100
        , tagTableViewMain
        , tagTableViewLoad
};

enum {
        tableViewMainRowNewProfile         = 0
            , tableViewMainRowSaveProfile   = 1
            , tableViewMainRowLoadProfile   = 2
            , tableViewMainRowEmailAnalysis = 3
            , tableViewMainRowDismiss       = 4
            , tableViewMainRowCount         = 5
};

enum {
        tableViewSectionCount = 1
};

static NSString* cell_identifier = @"main-menu-cell";
static NSString* cell_identifier_load = @"load-menu-cell";



@interface PACMainMenuView()
-(void)dismissMenuSelected;
-(UITableViewCell*)cellForTableViewMain:(UITableView*)tableView at:(NSIndexPath*)indexPath;
-(UITableViewCell*)cellForTableViewLoad:(UITableView*)tableView at:(NSIndexPath*)indexPath;
-(UIView*) viewForHeaderMainInSection:(UITableView*)tableView;



-(void)didSelectRowMain:(UITableView*)tableView at:(NSIndexPath*)indexPath;
-(void)saveCurrentProfile;
-(void)loadProfile;
@end

@implementation PACMainMenuView

@synthesize menu_delegate = _menu_delegate;


- (id)initWithFrame:(CGRect)frame 
{
	if ((self = [super initWithFrame:frame])) {

            _menu_delegate = nil;

            UIView* content_view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
            content_view.tag = tagContentView;
            content_view.backgroundColor = [UIColor whiteColor];

            UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height) style:UITableViewStyleGrouped];
            tableView.tag = tagTableViewMain;
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.scrollEnabled = NO;
            [tableView registerClass:[UITableViewCell class ] forCellReuseIdentifier:cell_identifier];

            [content_view addSubview:tableView];

            [self addSubview:content_view];

            _analysis = nil;

        }
        return self;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return tableViewSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    switch(tableView.tag){
        case tagTableViewMain:
            return tableViewMainRowCount;
        case tagTableViewLoad:
            return [_analysis count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    switch(tableView.tag) {
        case tagTableViewMain:
                return [self cellForTableViewMain:tableView at:indexPath];
        case tagTableViewLoad:
                return [self cellForTableViewLoad:tableView at:indexPath];
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        switch(tableView.tag){
            case tagTableViewMain:
                return [self viewForHeaderMainInSection:tableView];
        }
        return nil;
}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    switch(tableView.tag){
        case tagTableViewMain:
            return 42.0f;
    }
    return 0.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        switch(tableView.tag){
            case tagTableViewMain:
            [self didSelectRowMain:tableView at:indexPath];
        }
}
#pragma mark -
#pragma mark Private
-(UITableViewCell*)cellForTableViewMain:(UITableView*)tableView at:(NSIndexPath*)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    switch(indexPath.row){
        case tableViewMainRowNewProfile:
            cell.textLabel.text = @"New Analysis";
            break;
        case tableViewMainRowSaveProfile:
            cell.textLabel.text = @"Save Analysis";
            break;
        case tableViewMainRowLoadProfile:
            cell.textLabel.text = @"Load Analysis";
            break;
        case tableViewMainRowEmailAnalysis:
            cell.textLabel.text = @"Email Analysis";
            break;
        case tableViewMainRowDismiss:
            cell.textLabel.text = @"Dismiss Menu";
            break;
    }
    
    return cell;
}
-(UITableViewCell*)cellForTableViewLoad:(UITableView*)tableView at:(NSIndexPath*)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier_load forIndexPath:indexPath];

    return cell;
}
-(UIView*) viewForHeaderMainInSection:(UITableView*)tableView
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 18.0f, tableView.frame.size.width, 28.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.text = NSLocalizedString(@"Menu", @"");
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;
}
-(void)didSelectRowMain:(UITableView*)tableView at:(NSIndexPath*)indexPath
{

    switch(indexPath.row){
        case tableViewMainRowNewProfile:
            pac_reset_all();
            break;
        case tableViewMainRowSaveProfile:
            [self saveCurrentProfile];
            break;
        case tableViewMainRowLoadProfile:
            [self loadProfile];
            break;
        case tableViewMainRowEmailAnalysis:
            break;
        case tableViewMainRowDismiss:
            [self dismissMenuSelected];
            break;
    }
    
}

-(void)dismissMenuSelected
{
    if(_menu_delegate && [_menu_delegate respondsToSelector:@selector(mainMenuDismiss:)]){
      [_menu_delegate mainMenuDismiss:self];
    }
}
-(void)saveCurrentProfile
{
    if(PACCurrentAnalysis < 0){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Save as"
                                                                       message:@""
                                                                preferredStyle:UIAlertControllerStyleAlert];

        [alert addTextFieldWithConfigurationHandler:NULL];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {NSString* name = ((UITextField*)[alert.textFields objectAtIndex:0]).text; if(name && [name length]) pac_save_analysis([name UTF8String], -1);[self dismissMenuSelected];}];
        UIAlertAction* cancelAction  = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];

        [alert addAction:defaultAction]; 
        [alert addAction:cancelAction]; 

        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];//(animated:YES completion:nil)];
    } else {
        pac_save_analysis(0, PACCurrentAnalysis);
    }
}

-(void)loadProfile
{
    _analysis = pac_all_analysis();

    UIView* content_view = [self vieWithTag:tagContentView];
    UITableView* table_view = (UITableView*)[content_view vieWithTag:tagTableView];

    CGRect frame = table_view.frame;

    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height) style:UITableViewStyleGrouped];
    tableView.tag = tagTableViewLoad;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollEnabled = NO;
    [tableView registerClass:[UITableViewCell class ] forCellReuseIdentifier:cell_identifier_load];

    [UIView transitionFromView:table_view toView:tableView duration:0.45 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){}];

}
@end

