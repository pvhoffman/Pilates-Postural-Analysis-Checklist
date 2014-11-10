//
//  PACGlobal.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 10/22/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PACGlobal.h"



unsigned int PACChecklistMain      = 0;
unsigned int PACPlumbLineAlignment = 0;
unsigned int PACChecklistSideView  = 0;

int PACAnkleAlignmentLeft  = -1;
int PACAnkleAlignmentRight = -1;

const char* PACCheckListMainDidChange      = "PACCheckListMainDidChange";
const char* PACCheckListSideViewDidChange  = "PACCheckListSideViewDidChange";
const char* PACCheckListFrontViewDidChange = "PACCheckListFrontViewDidChange";
const char* PACCheckListBackViewDidChange  = "PACCheckListBackViewDidChange";


int PACKneeAlignmentSideLeft  = -1;
int PACKneeAlignmentSideRight = -1;

int PACHipAlignmentLeft  = -1;
int PACHipAlignmentRight = -1;


int PACPelvisSideAlignmentLeft  = -1;
int PACPelvisSideAlignmentRight = -1;


int PACLumbarAlignment = -1;

int PACLowerThoracicAlignment = -1;
int PACUpperThoracicAlignment = -1;
int PACCervicalSpineAlignment = -1;

int PACHeadSideAlignment = -1;

unsigned int PACChecklistFrontView = 0;

int PACFeetFrontAlignmentLeft  = -1;
int PACFeetFrontAlignmentRight = -1;

int PACKneeFrontAlignmentLeft  = -1;
int PACKneeFrontAlignmentRight = -1;

int PACPelvisFrontAlignment = -1;

int PACRibCageFrontAlignment = -1;

int PACShouldersFrontAlignment = 0;

int PACHeadFrontAlignment = 0;


unsigned int PACChecklistBackView = 0;

extern int PACFeetBackAlignmentLeft  = -1;
extern int PACFeetBackAlignmentRight = -1;

