# cropper_and_trimmer

A new Flutter project.

## Screenshot
![Simulator Screen Shot - iPhone 12 Pro Max - 2021-11-12 at 15 52 31](https://user-images.githubusercontent.com/82141553/141454259-8b581c4a-ef0a-4c2d-95c7-b2c8805c7da9.png)
![Simulator Screen Shot - iPhone 12 Pro Max - 2021-11-12 at 15 52 15](https://user-images.githubusercontent.com/82141553/141454284-0e9fae71-0ad4-4144-ab27-85fa4719f880.png)
![Simulator Screen Shot - iPhone 12 Pro Max - 2021-11-12 at 15 51 52](https://user-images.githubusercontent.com/82141553/141454290-aac8d3fd-b356-4441-bd59-537b8ade6b8e.png)
![Simulator Screen Shot - iPhone 12 Pro Max - 2021-11-12 at 15 51 38](https://user-images.githubusercontent.com/82141553/141454293-78a8cfb1-d98a-4634-b0a6-9920c458639d.png)



## Getting Started

With this package you can crop/trim your photos and videos.

## iOS Target

This package will work for iOS 13 or later versions.

## iOS plist config

Because the album is a privacy privilege, you need user permission to access it. You must to modify the Info.plist file in Runner project.

``` 
    <key>NSCameraUsageDescription</key>
    <string>Use</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>Use</string>
    <key>NSAppleMusicUsageDescription</key>
    <string>Use</string>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>Use</string>
    
``` 

## 1.  Add in pubspec.yaml file under

dependencies:
``` 
 cropper_and_trimmer:  
   git:  
     url: https://github.com/dinkerkis/cropper_and_trimmer.git
``` 

## 2. Add package

``` 
import 'package:cropper_and_trimmer/cropper_and_trimmer.dart';

``` 


## 3.  Use in the code like this:

1. For image

``` 
CropperAndTrimmer(file: <galleryImagePicked> as File,
                shouldPreview: true,
                fileType: FileType.image,
                onImageUpdated: (file) {
                  if (mounted) {
                    setState(() {

                    });
                  }
                },
              ),

``` 
2. For video

``` 
CropperAndTrimmer(file: <galleryVideoPicked> as File,
                  shouldPreview: true,
                  fileType: FileType.video,
                  onVideoUpdated: (file) {
                    _controller = VideoPlayerController.file(file)
                      ..initialize().then((_) {
                        _controller.pause();
                        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                        setState(() {});
                      });
                  },
                ),

``` 

##4. Description of arguments and Other benefits

``` 
1. File file :
    You need to pass the file image/video which you want to edit.
2. FileType fileType :
    In this, you need to pass the type of file i.e. image or video.
3. VideoUpdated? onVideoUpdated :
    In this function, you will get callback on done button click and get the final video edited.
4. ImageUpdated? onImageUpdated :
    In this function, you will get callback on done button click and get the final image edited.
5. CancelPressed? onCancelPressed  :
    In this function, you will get calback on cancel button click. 
6. bool shouldPreview :
    If want to preview your file, then pass true. default is false.
7. bool saveToGallery :
    If want to save the returned file to gallery, then pass true. default is false.
8. Color? backgroundColor :
    If want to change the background color, default is black.
9. Color? primaryColor :
    If want to change the primary color, default is black.
10. Color? secondaryColor :
    If want to change the secondary color, default is white.
``` 
