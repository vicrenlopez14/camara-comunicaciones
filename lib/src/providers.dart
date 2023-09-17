import 'package:camara_comunicaciones/src/App/view_models/live_streaming_view_model.dart';
import 'package:camara_comunicaciones/src/App/view_models/welcome_screen_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers () =>[
   ChangeNotifierProvider(create: (_) => WelcomeScreenViewModel()),
    ChangeNotifierProvider(create: (_) => LiveStreamingViewModel()),
];

