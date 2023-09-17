import 'package:camara_comunicaciones/src/App/model/post_frame_mixin.dart';
import 'package:camara_comunicaciones/src/App/view_models/live_streaming_view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:provider/provider.dart';

class LiveStreamingScreen extends StatefulWidget {
  const LiveStreamingScreen({super.key});

  @override
  State<LiveStreamingScreen> createState() => _LiveStreamingScreenState();
}

class _LiveStreamingScreenState extends State<LiveStreamingScreen>
    with PostFrameMixin {
  List<CameraDescription>? cameras;
  CameraController? controller;
  XFile? imageFile;

  void initializeCameras({String? name}) async {
    cameras = await availableCameras();
    if (cameras == null) {
      print("No cameras available");
      return;
    }

    final toUseCamera = name == null
        ? cameras![0]
        : cameras!.where((element) => element.name == name).first;

    controller = CameraController(toUseCamera, ResolutionPreset.ultraHigh);

    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    initializeCameras();
    Provider.of<LiveStreamingViewModel>(context, listen: false).connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Controles de transmisión",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),

                      // Tranmission controls
                      tranmissionControlsWidget(context),

                      // Connection controls
                      connectionControlsWidget(context),
                    ]
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: e,
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (controller != null)
                    Container(
                      child: CameraPreview(
                        controller!,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column tranmissionControlsWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Cámara activa:",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold)),
        Text(
            "Selecciona la cámara que quieres usar para transmitir, de preferencia la cámara trasera."),
        const SizedBox(height: 8),
        if (cameras != null)
          DropdownMenu<String>(
            initialSelection: cameras!.first.name,
            dropdownMenuEntries: cameras!
                .map(
                  (e) => DropdownMenuEntry(
                      value: e.name,
                      label:
                          e.lensDirection.name.substring(0, 1).toUpperCase() +
                              e.lensDirection.name.substring(1)),
                )
                .toList(),
            onSelected: (name) => initializeCameras(name: name),
          ),
      ],
    );
  }

  Widget cameraNumControls(BuildContext context) {
    return Consumer<LiveStreamingViewModel>(
      builder: (context, viewModel, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Número de cámara:",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold)),
            Text(
                "Introduce el número de cámara proporcionado por tu administrador."),
            const SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: viewModel.cameraNum),
              decoration: InputDecoration(
                hintText: "1",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                controller?.startImageStream((CameraImage image) {
                  Provider.of<LiveStreamingViewModel>(context, listen: false)
                    ..sendImageToServer(image);
                });
              },
              child: Text("Iniciar transmisión"),
            ),
          ],
        );
      },
    );
  }

  Widget connectionControlsWidget(BuildContext context) {
    return Consumer<LiveStreamingViewModel>(
      builder: (context, viewModel, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("IP del Servidor:",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold)),
            Text(
                "Por favor introduce la dirección IP proporcionada por tu administrador."),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: viewModel.serverAddress),
              decoration: InputDecoration(
                hintText: "192.168.1.2",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                controller?.startImageStream((CameraImage image) {
                  Provider.of<LiveStreamingViewModel>(context, listen: false)
                    ..sendImageToServer(image);
                });
              },
              child: Text("Iniciar transmisión"),
            ),
          ],
        );
      },
    );
  }


}
