//
//  PACGlobal.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 10/22/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PACGlobal.h"



unsigned int PACChecklistMain = 0;
unsigned int PACPlumbLineAlignment = 0;
unsigned int PACChecklistSideView = 0;

int PACAnkleAlignmentLeft = -1;
int PACAnkleAlignmentRight = -1;

const char* PACCheckListMainDidChange = "PACCheckListMainDidChange";
const char* PACCheckListSideViewDidChange = "PACCheckListSideViewDidChange";


int PACKneeAlignmentSideLeft = -1;
int PACKneeAlignmentSideRight = -1;