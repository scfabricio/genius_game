import 'dart:async';

Future<void> awaitTime(Duration time) {
  return Future.delayed(time);
}