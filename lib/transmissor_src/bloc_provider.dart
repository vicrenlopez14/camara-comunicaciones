import 'package:camara_comunicaciones/transmissor_src/bloc/camera_bloc/camera_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';


final blocProviders = <SingleChildWidget>[
 BlocProvider(create: (_) => CameraBloc())
];