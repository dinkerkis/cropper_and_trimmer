# cropper_and_trimmer

A new Flutter project.

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
                type: Type.image,
                onUpdatedImage: (file) {
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
                  type: Type.video,
                  onUpdatedVideo: (file) {
                    _controller = VideoPlayerController.file(file)
                      ..initialize().then((_) {
                        _controller.pause();
                        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                        setState(() {});
                      });
                  },
                ),

``` 