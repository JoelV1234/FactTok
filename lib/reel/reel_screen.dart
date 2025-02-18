import 'package:biblereels/facts/more_info_dialog.dart';
import 'package:biblereels/reel/read_more_button.dart';
import 'package:biblereels/widgets/custom_text.dart';
import 'package:biblereels/facts/fact.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';



class ReelScreen extends StatefulWidget {
  final void Function(Fact fact , int index)? onNewFact;
  final int? initialIndex;
  final List<Fact> facts;
  const ReelScreen({super.key, 
    this.initialIndex,
    required this.facts, 
    this.onNewFact});

  @override
  State<ReelScreen> createState() => _ReelScreenState();
}

class _ReelScreenState extends State<ReelScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    currentIndex = widget.initialIndex ?? 0;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ReelScreen oldWidget) {
    if (widget.initialIndex != oldWidget.initialIndex) {
      currentIndex = widget.initialIndex ?? 0;
    }
    super.didUpdateWidget(oldWidget);
  }

  void nextFact(int indexChange ) {
    int length = widget.facts.length;
    setState(() {
      currentIndex = (currentIndex + indexChange).abs() % (length);
      widget.onNewFact?.call(widget.facts[currentIndex], currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final tp = TextPainter(
          text: TextSpan(
            text: widget.facts[currentIndex].description,
            style: const TextStyle(fontSize: 18),
          ),
          textDirection: TextDirection.ltr,
        );
        tp.layout(maxWidth: constraints.maxWidth);
        bool isOverflowing = tp.computeLineMetrics().length > 3;
        return Scaffold(
          body: GestureDetector(
              supportedDevices: <PointerDeviceKind>{ 
                PointerDeviceKind.touch ,
                PointerDeviceKind.mouse
              },
              behavior: HitTestBehavior.opaque,
              onVerticalDragEnd: (DragEndDetails details) {
                if (details.velocity.pixelsPerSecond.dy > 0) {
                  nextFact(-1);
                } else {
                  nextFact(1);
                }
              },
            
              child: Center(
                child: Stack(
                  children: [
                    Image.network(
                      widget.facts[currentIndex].photourl ?? '',
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                     Align(
                      alignment: Alignment.bottomCenter,
                       child: FractionallySizedBox(
                        alignment: Alignment.bottomCenter,
                        heightFactor: 0.5,
                         child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black,
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                       ),
                     ),
                    
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              widget.facts[currentIndex].title,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              maxLines: 3,
                              widget.facts[currentIndex].description,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 18,
                              )
                            ),
                            if (isOverflowing)
                            ReadMoreButton(
                              onPress: () => showMoreInfo(
                                context, widget.facts[currentIndex]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        );
      }
    );
  }
}