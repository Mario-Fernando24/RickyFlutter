
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../pages/home_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {

   AppConstants.homePage: (_) => const HomePage()

};
