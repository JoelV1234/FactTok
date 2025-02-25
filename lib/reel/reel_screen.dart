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
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.initialIndex ?? 0);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ReelScreen oldWidget) {
    if (widget.initialIndex != oldWidget.initialIndex
      && widget.initialIndex != currentIndex
    ) {
      animateToPage(widget.initialIndex ?? 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  void animateToPage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tp = TextPainter(
            text: TextSpan(
              text: widget.facts[currentIndex].description,
              style: const TextStyle(fontSize: 18),
            ),
            textDirection: TextDirection.ltr,
          );
          tp.layout(maxWidth: constraints.maxWidth - 80);
          bool isOverflowing = tp.computeLineMetrics().length > 3;
          return PageView(
            scrollDirection: Axis.vertical,
            controller: pageController,
            onPageChanged: (index) => setState(() { 
              currentIndex = index;
              widget.onNewFact!(widget.facts[index], index);
            }),
            children: widget.facts.map((fact) {
              return Center(
                child: Stack(
                  children: [
                    Image.network(
                      fact.photourl ?? '',
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        alignment: Alignment.bottomCenter,
                        heightFactor: 0.7,
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
                              fact.title,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              maxLines: 3,
                              fact.description,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 18,
                              )
                            ),
                            if (isOverflowing)
                            ReadMoreButton(
                              onPress: () => showMoreInfo(
                                  context, fact),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                );}
              ).toList(),
            );
        }
      ),
      )
    );
  }
}