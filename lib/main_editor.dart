import 'dart:io';

import 'package:cropper_and_trimmer/video_editor.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:video_player/video_player.dart';


typedef UpdatedVideo = void Function(File file);
typedef UpdatedImage = void Function(File file);
typedef CancelPressed = void Function();

enum Type {
  video,
  image
}

class CropperAndTrimmer extends StatefulWidget {
  final UpdatedVideo? onUpdatedVideo;
  final UpdatedImage? onUpdatedImage;
  final Type type;
  final bool shouldPreview;
  final File file;

  const CropperAndTrimmer({Key? key, this.onUpdatedVideo, this.onUpdatedImage, required this.type, required this.file, this.shouldPreview = false}) : super(key: key);

  @override
  _CropperAndTrimmerState createState() => _CropperAndTrimmerState();
}

class _CropperAndTrimmerState extends State<CropperAndTrimmer> {

  File? imageSelected;
  File? videoSelected;
  VideoPlayerController _controller = VideoPlayerController.network('');

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      // Add Your Code here.
      updateScreen();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // updateScreen();
  }

  Future updateScreen() async{

    if (widget.type == Type.image) {
      imageSelected = widget.file;
      _cropImage(widget.file);
    }
    else {
      videoSelected = widget.file;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              VideoEditor(file: File(widget.file.path),
                onCancelPressed: () {
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                onUpdatedVideo: (file) {
                  if (mounted) {
                    videoSelected = file;
                    imageSelected = null;

                    if (widget.shouldPreview) {
                      _updateVideoFile(file);
                      setState(() {

                      });
                    }
                    else {
                      _doneEdit();
                    }
                  }
                },
              ),
        ),
      ).then((value) {
        setState(() {

        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future _cropImage(File imageFile) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).primaryColorDark,
            toolbarWidgetColor: Theme.of(context).primaryColorLight,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));

    if (croppedFile != null) {

      videoSelected = null;
      imageSelected = croppedFile;

      if (widget.shouldPreview) {
        setState(() {

        });
      }
      else {
        _doneEdit();
      }
    }
  }

  _doneEdit() {
    if (widget.type == Type.image) {
      if (widget.onUpdatedImage != null && imageSelected != null) {
        widget.onUpdatedImage!(imageSelected as File);
      }

    }
    else
    {
      if (widget.onUpdatedVideo != null && videoSelected != null) {
        widget.onUpdatedVideo!(videoSelected as File);
      }
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        leading: Container(),
        title: widget.shouldPreview ? Text('Preview') : Text(''),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
            height: double.infinity,
            width: double.infinity,
            child: imageSelected == null && videoSelected == null ?
            Center(child:
            Text(
              'Found nothing to Preview',
            )):
            imageSelected != null ?
            Image.file(imageSelected as File, fit: BoxFit.contain,) :

            videoSelected != null ? Stack(
                children: <Widget>[
                  Center(
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                        : Container(),
                  ),
                  Center(
                    child: _controller.value.isInitialized
                        ? FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      child: Icon(
                        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                    ) : Container(),
                  ),
                ]
            ) : SizedBox(height: 0,)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _doneEdit();
        },
        child: const Icon(Icons.navigate_next_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _updateVideoFile(File file) {
    _controller = VideoPlayerController.file(
        file)
      ..initialize().then((_) {
        // _controller.pause();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }
}