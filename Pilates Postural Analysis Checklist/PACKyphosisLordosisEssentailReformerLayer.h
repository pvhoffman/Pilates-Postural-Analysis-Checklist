//
//  PACKyphosisLordosisEssentailReformerLayer.h
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    kyphosisLordosisEssentailReformerLayer1 = 0
        , kyphosisLordosisEssentailReformerLayer2 
        , kyphosisLordosisEssentailReformerLayer3 
        , kyphosisLordosisEssentailReformerLayerCount
} PACKyphosisLordosisEssentailReformerLayer_t;


@interface PACKyphosisLordosisEssentailReformerLayer : UITableViewController
{
@private
    NSArray* _warmup;
    NSArray* _exercises;

    NSArray* _warmup_details;
    NSArray* _exercises_details;

    NSArray* _warmup_bold;
    NSArray* _exercises_bold;
}
-(void) setLayer:(PACKyphosisLordosisEssentailReformerLayer_t)layer;
@end
