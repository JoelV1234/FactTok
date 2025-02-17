import 'package:flutter/material.dart';

class FutureWidget<T> extends StatelessWidget {
  final Future<T> future;
  final Widget? loading;
  final Widget Function(T data) onComplete;
  final Widget Function(Error e)? onError;
  const FutureWidget({super.key,
    required this.future,
    required this.onComplete,
    this.onError, 
    this.loading
  });

  @override
  Widget build(BuildContext context) {
    final Widget loadingWidget = loading ?? CircularProgressIndicator();
    return FutureBuilder<T>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget; // Loading state
        } else if (snapshot.hasError) {
          return onError?.call(snapshot.error as Error) ?? Center(
            child: Text('Error: ${snapshot.error}'),
          ); // Error state
        } else if (snapshot.hasData) {
          return onComplete(snapshot.data!); // Success state
        }
        return loadingWidget; // Default case
      },
    );
  }
}