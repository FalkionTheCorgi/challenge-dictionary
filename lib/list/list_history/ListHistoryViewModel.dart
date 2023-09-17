import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listHistoryViewModel = ChangeNotifierProvider((ref) => ListHistoryViewModel());

class ListHistoryViewModel extends ChangeNotifier {}