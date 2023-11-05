import 'dart:io';

import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService {
  PermissionStatus? _permissionStatus;
  CameraController? _cameraController;
  final textRecognizer = TextRecognizer();

  CameraController? get cameraController => _cameraController;
  bool get isPermissionGranted => _permissionStatus == PermissionStatus.granted;

  Future<void> requestCameraPermission() async {
    _permissionStatus = await Permission.camera.request();
    if (_permissionStatus != PermissionStatus.granted) {
      throw Exception('Camera permission not granted');
    }
  }

  Future<void> initCameraController() async {
    if (_cameraController != null) return;

    if (_permissionStatus != PermissionStatus.granted) {
      throw Exception('Camera permission not granted');
    }
    List<CameraDescription> cameras = await availableCameras();

    /// Select the first rear camera.
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        await _startCamera(current);
        break;
      }
    }
  }

  Future<void> _startCamera(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await _cameraController!.initialize();
  }

  void stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  Future<String?> scanPicture() async {
    if (_cameraController == null) throw Exception('Camera not initialized');

    try {
      final pictureFile = await _cameraController!.takePicture();

      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file);
      final recognizedText = await textRecognizer.processImage(inputImage);

      return recognizedText.text;
    } catch (e) {
      throw Exception('An error occurred when scanning text');
    }
  }
}
