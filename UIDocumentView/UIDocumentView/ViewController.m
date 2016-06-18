//
//  ViewController.m
//  UIDocumentView
//
//  Created by Pradeep Yadav on 11/08/15.
//  Copyright (c) 2015 iOSBucket.blogspot.in. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()<UIDocumentPickerDelegate,UIDocumentMenuDelegate>
{
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 // Do any additional setup after loading the view, typically from a nib.
}


/**
 *  This function is used to upload the files from the application to a destination(iCloud,Dropbox)
 *
 *  @param sender button object on which user has clicked
 */


-(IBAction)tapUploadFile:(id)sender
{
    //Create the file path of the document to upload
    NSURL *filePathToUpload = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"testing" ofType:@"doc"]]  ;
    //Create a object of document picker view and set the mode to Export
    UIDocumentPickerViewController *docPicker = [[UIDocumentPickerViewController alloc] initWithURL:filePathToUpload inMode:UIDocumentPickerModeExportToService];
    //Set the delegate
    docPicker.delegate = self;
    //present the document picker
    [self presentViewController:docPicker animated:YES completion:nil];
    
}

/**
 *  This function is used to download the files from a destination(iCloud,Dropbox)
 *
 *  @param sender button object on which user has clicked
 */

- (IBAction)tapDownloadFile:(id)sender
{
    /** Create the array of UTIType that you want to support
     * Pass the array of UTIType that application wants to support. Add more UTType if you want to support more other than listed
     */
    NSArray *types = @[(NSString*)kUTTypeImage,(NSString*)kUTTypeSpreadsheet,(NSString*)kUTTypePresentation,(NSString*)kUTTypeDatabase,(NSString*)kUTTypeFolder,(NSString*)kUTTypeZipArchive,(NSString*)kUTTypeVideo];
    //Create a object of document picker view and set the mode to Import
    UIDocumentPickerViewController *docPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:types inMode:UIDocumentPickerModeImport];
    //Set the delegate
    docPicker.delegate = self;
    //present the document picker
    [self presentViewController:docPicker animated:YES completion:nil];

}

- (IBAction)tapDocumentMenuView:(id)sender
{
    /** Create the array of UTIType that you want to support
     * Pass the array of UTIType that application wants to support. Add more UTIType if you want to support more other than listed
     */
     NSArray *types = @[(NSString*)kUTTypeImage,(NSString*)kUTTypeSpreadsheet,(NSString*)kUTTypePresentation,(NSString*)kUTTypeDatabase,(NSString*)kUTTypeFolder,(NSString*)kUTTypeZipArchive,(NSString*)kUTTypeVideo];
    //Create a object of document menu view and set the mode to Import
    UIDocumentMenuViewController *objMenuView = [[UIDocumentMenuViewController alloc]initWithDocumentTypes:types inMode:UIDocumentPickerModeImport];
   
    //Create Custom option to display
    [objMenuView addOptionWithTitle:@"My Custom option" image:nil order:UIDocumentMenuOrderFirst handler:^{
        //Call when user select the option
        
    }];
    //Set the delegate
    objMenuView.delegate = self;
    //present the document menu view
    [self presentViewController:objMenuView animated:YES completion:nil];

}

- (void)documentMenu:(UIDocumentMenuViewController *)documentMenu didPickDocumentPicker:(UIDocumentPickerViewController *)documentPicker {
    documentPicker.delegate = self;
    [self presentViewController:documentPicker animated:YES completion:nil];
}


#pragma mark Delegate-UIDocumentPickerViewController

/**
 *  This delegate method is called when user will either upload or download the file.
 *
 *  @param controller UIDocumentPickerViewController object
 *  @param url        url of the file
 */

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url
{
    if (controller.documentPickerMode == UIDocumentPickerModeImport)
    {
      
        // Condition called when user download the file
        NSData *fileData = [NSData dataWithContentsOfURL:url];
        // NSData of the content that was downloaded - Use this to upload on the server or save locally in directory
        
        //Showing alert for success
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *alertMessage = [NSString stringWithFormat:@"Successfully downloaded file %@", [url lastPathComponent]];
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"UIDocumentView"
                                                  message:alertMessage
                                                  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        });
    }else  if (controller.documentPickerMode == UIDocumentPickerModeExportToService)
    {
        // Called when user uploaded the file - Display success alert
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *alertMessage = [NSString stringWithFormat:@"Successfully uploaded file %@", [url lastPathComponent]];
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"UIDocumentView"
                                                  message:alertMessage
                                                  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        });
    }
    
}

/**
 *  Delegate called when user cancel the document picker
 *
 *  @param controller - document picker object
 */
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
