import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import '../visualizer/round_visualizer_painter.dart';
import '../visualizer/audio_player_task.dart';

class RoundVisualizerScreen extends StatefulWidget {
  const RoundVisualizerScreen({super.key});

  @override
  State<RoundVisualizerScreen> createState() => _RoundVisualizerScreenState();
}

class _RoundVisualizerScreenState extends State<RoundVisualizerScreen> 
  with SingleTickerProviderStateMixin {
    late AnimationController animationController;
    List<double> barsHeight = [];
    late AudioPlayer audioPlayer;

    @override
    void initState() {
      super.initState();
      animationController = AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      )..addListener(() {
        setState(() {});
      });

      audioPlayer = AudioPlayer();
      audioPlayer.playbackEventStream.listen((event) {
        final data = event.processingState == ProcessingState.ready ? event.updatePosition : null;
        if (data == ProcessingState.ready || data == ProcessingState.completed) {
          final rms = event.playbackEvent?.processData?.peakLevel ?? 0.0;
          final normalizedRms = rms.clamp(0.0, 1.0);
          updateBars(normalizedRms);
        }
      });
    }

    @override
    void dispose() {
      animationController.dispose();
      audioPlayer.dispose();
      super.dispose();
    }

    void updateBars(double rms) {
      setState(() {
        barsHeight.add(rms);
        if(barsHeight.length > 360) {
          barsHeight.removeAt(0);
        }
      });
    }

    Future<void> loadAndPlayAudio() async {
      try {
        await AudioService.start(backgroundTaskEntrypoint: audioPlayerTaskEntrypoint);
        await AudioService.connect();
        await AudioService.loadMediaItem(MediaItem(
          id: 'assets/sample.mp3',
          album: 'Sample Album',
          title: 'Sample Title',
          artUri: Uri.parse('https://example.com/albumart.jpg'),
        ));
        await AudioService.play();
      } catch (e) {
        // handle error loading or playing audio
      }
    }
    
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Audio Visualizer"),
        ),
        body: Container(
          color: Colors.black,
          child: Center(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final radius = min(constraints.maxWidth, constraints.maxHeight) / 2;
                return CustomPaint(
                  painter: RoundVisualizerPainter(
                    barsHeight: barsHeight,
                    animationValue: animationController.value,
                    radius: radius,
                  ),
                  child: Container(),
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: loadAndPlayAudio,
          child: const Icon(Icons.play_arrow_outlined),
        ),
      );
    }
}