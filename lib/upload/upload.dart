import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'filters.dart';
import 'upload_server.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final GlobalKey _globalKey = GlobalKey();
  File _selectedFile;
  var _ready = false;
  var _mainIndex = 0;

  //Lista de filtros
  final List<List<double>> filters = [
    NATURAL_MATRIX,
    SEPIA_MATRIX,
    GREYSCALE_MATRIX,
    VINTAGE_MATRIX,
    SWEET_MATRIX
  ];

  void convertWidgetToImage() async {
    RenderRepaintBoundary repaintBoundary =
        _globalKey.currentContext.findRenderObject();
    ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 2);
    ByteData byteData =
        await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData.buffer.asUint8List();
    Navigator.of(_globalKey.currentContext).push(MaterialPageRoute(
        builder: (context) => UploadServer(
              imageData: uint8list,
            )));
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(_selectedFile);
    } else {
      return Image.asset('assets/images/placeholder-image.png');
    }
  }

  final picker = ImagePicker();

  _getImage() async {
    PickedFile image = await picker.getImage(source: ImageSource.camera);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxHeight: 610,
          maxWidth: 610,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Cortar imagen",
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: true,
          ));
      print("SI SE eligió imagen.");
      setState(() {
        _selectedFile = cropped;
        _ready = true;
      });
    } else {
      print("No se eligió imagen.");
    }
  }

  _getImageGallery() async {
    PickedFile image = await picker.getImage(source: ImageSource.gallery);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          //aspectRatio: CropAspectRatioPreset.square
          compressQuality: 100,
          maxHeight: 614,
          maxWidth: 614,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Seleccionar imagen",
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: true,
          ));
      print("SI SE eligió imagen.");
      setState(() {
        _selectedFile = cropped;
        _ready = true;
      });
    } else {
      print("No se eligió imagen.");
    }
  }

  PageController pageController =
      PageController(viewportFraction: 0.35, initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 26.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Publicación",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: _ready ? convertWidgetToImage : null,
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.space,
        children: [
          RepaintBoundary(
            key: _globalKey,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.matrix(filters[_mainIndex]),
                child: getImageWidget(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.folder_open, color: Colors.blueGrey),
                  onPressed: _getImageGallery,
                ),
                IconButton(
                  icon: Icon(Icons.camera, color: Colors.blueGrey),
                  onPressed: _getImage,
                ),
              ],
            ),
          ),
          if (_ready)
            Expanded(
              child: Container(
                height: 100,
                width: 350,
                // decoration: BoxDecoration(color: Colors.red),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(8.0), child: Text("Filtros")),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 100,
                          child: PageView.builder(
                              controller: pageController,
                              itemCount: filters.length,
                              itemBuilder: (context, index) {
                                return ColorFiltered(
                                  colorFilter:
                                      ColorFilter.matrix(filters[index]),
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _mainIndex = index;
                                        });
                                      },
                                      child: ClipOval(child: getImageWidget())),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
