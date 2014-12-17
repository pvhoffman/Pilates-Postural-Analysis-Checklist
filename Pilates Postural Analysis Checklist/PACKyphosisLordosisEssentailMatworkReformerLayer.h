//
//  PACKyphosisLordosisEssentailMatworkReformerLayer.h
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    kyphosisLordosisEssentailMatworkReformerLayer1 = 0
        , kyphosisLordosisEssentailMatworkReformerLayer2 
        , kyphosisLordosisEssentailMatworkReformerLayer3 
        , kyphosisLordosisEssentailMatworkReformerLayerCount
} PACKyphosisLordosisEssentailMatworkReformerLayer_t;


@interface PACKyphosisLordosisEssentailMatworkReformerLayer : UITableViewController
{
@private
    NSArray* _warmup;
    NSArray* _exercises_matwork;
    NSArray* _exercises_reformer;

    NSArray* _warmup_details;
    NSArray* _exercises_details_matwork;
    NSArray* _exercises_details_reformer;

    NSArray* _warmup_bold;
    NSArray* _exercises_bold_matwork;
    NSArray* _exercises_bold_reformer;
}
-(void) setLayer:(PACKyphosisLordosisEssentailMatworkReformerLayer_t)layer;
@end
