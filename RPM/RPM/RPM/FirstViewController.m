//
//  FirstViewController.m
//  RPM
//
//  Created by Jordan Zucker on 1/24/15.
//  Copyright (c) 2015 Jordan Zucker. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UIButton *cameraButton;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

- (IBAction)cameraButtonAction:(id)sender;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Camera";
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.allowsEditing = YES;
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
//    self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraButtonAction:(id)sender
{
    if (!self.imagePickerController) {
        return;
    }
    [self presentViewController:self.imagePickerController animated:YES completion:^{
        NSLog(@"camera presentation completed");
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"info is %@", info);
    
    UIImage *editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    
    
    
    [self.imagePickerController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"finished!");
        UIImageWriteToSavedPhotosAlbum(editedImage, nil, nil, nil);
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePickerController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"cancel!");
    }];
}

@end
