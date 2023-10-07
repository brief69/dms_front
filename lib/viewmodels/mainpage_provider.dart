

// lib/providers/main_page_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bennu_app/viewmodels/mainpage_viewmodel.dart';

final mainPageViewModelProvider = ChangeNotifierProvider<MainPageViewModel>((ref) {
  return MainPageViewModel();
});
