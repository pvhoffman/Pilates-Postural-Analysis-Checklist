//
//  PACKyphosisLordosisEssentailMatworkLayer.h
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kyphosisLordosisEssentailMatworkLayer1 = 0
        , kyphosisLordosisEssentailMatworkLayer2 
        , kyphosisLordosisEssentailMatworkLayer3 
        , kyphosisLordosisEssentailMatworkLayerCount
} PACKyphosisLordosisEssentailMatworkLayer_t;

@interface PACKyphosisLordosisEssentailMatworkLayer : UITableViewController
{
@private
        NSArray* _warmup;
        NSArray* _exercises;

        NSArray* _warmup_details;
        NSArray* _exercises_details;

        NSArray* _warmup_bold;
        NSArray* _exercises_bold;
}

-(void) setLayer:(PACKyphosisLordosisEssentailMatworkLayer_t)layer;
@end
