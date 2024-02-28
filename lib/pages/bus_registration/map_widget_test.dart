import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 各ルートのマップウィジェット
class RouteMap extends ConsumerWidget {
  // バスのルートを取得する引数を追加する
  const RouteMap({super.key, required this.text, required this.busStops});

  final String text;
  final List<String> busStops;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: Text(text, style: const TextStyle(fontSize: 16)));
  }
}