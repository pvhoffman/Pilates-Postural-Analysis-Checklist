//
//  PACGlobal.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 10/22/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PACGlobal.h"

static const char* source_pdf = "Postural-Analysis-Guide.pdf";

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

int PACFeetBackAlignmentLeft  = -1;
int PACFeetBackAlignmentRight = -1;


int PACFemurBackAlignmentLeft  = -1;
int PACFemurBackAlignmentRight = -1;

int PACPelvisBackAlignment = 0;


int PACScapulaeBackAlignmentLeft  = -1;
int PACScapulaeBackAlignmentRight = -1;

int PACHumeriBackAlignmentLeft  = -1;
int PACHumeriBackAlignmentRight = -1;

int PACSpineSequencing = 0;
int PACSpineImbalance  = 0;
#if 0

void create_document()
{
    NSString* source_path = [[NSBundle mainBundle] pathForResource:@"Postural-Analysis-Guide" ofType:@"pdf"];

    if(source_path){
        NSURL* source_url = [NSURL fileURLWithPath:source_path];
        CGPDFDocumentRef source_doc = CGPDFDocumentCreateWithURL((__bridge CFURLRef)source_url);
        if(source_doc){
            CGPDFDocumentRelease(source_doc);
        }
    }
}




- (void)helloWorldPDF {
    // Open the source pdf
    NSURL               *sourceURL      = [NSURL fileURLWithPath:@"path to original pdf"];
    CGPDFDocumentRef    sourceDoc       = CGPDFDocumentCreateWithURL((__bridge CFURLRef)sourceURL);

    // Create the new destination pdf & set the font
    NSURL               *destURL        = [NSURL fileURLWithPath:@"path to new pdf"];
    CGContextRef        destPDFContext  = CGPDFContextCreateWithURL((__bridge CFURLRef)destURL, NULL, NULL);
    CGContextSelectFont(destPDFContext, "CourierNewPS-BoldMT", 12.0, kCGEncodingFontSpecific);

    // Copy the first page of the source pdf into the destination pdf
    CGPDFPageRef        pdfPage         = CGPDFDocumentGetPage(sourceDoc, 1);
    CGRect              pdfCropBoxRect  = CGPDFPageGetBoxRect(pdfPage, kCGPDFMediaBox);
    CGContextBeginPage  (destPDFContext, &pdfCropBoxRect);
    CGContextDrawPDFPage(destPDFContext, pdfPage);

    // Close the source file
    CGPDFDocumentRelease(sourceDoc);

    // Draw the text
    const char *text = "second line!";
    CGContextShowTextAtPoint(destPDFContext, 10.0, 30.0, text, strlen(text));

    // Close the destination file
    CGContextRelease(destPDFContext);
}

#endif
