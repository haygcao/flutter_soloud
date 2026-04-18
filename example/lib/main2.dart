import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:logging/logging.dart';

void main() async {
  Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;
  Logger.root.onRecord.listen((record) {
    dev.log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });

  WidgetsFlutterBinding.ensureInitialized();
  await SoLoud.instance.init();

  runApp(
    const MaterialApp(
      home: ReproIssue446(),
    ),
  );
}

class ReproIssue446 extends StatefulWidget {
  const ReproIssue446({super.key});

  @override
  State<ReproIssue446> createState() => _ReproIssue446State();
}

class _ReproIssue446State extends State<ReproIssue446> {
  final soloud = SoLoud.instance;

  final List<AudioSource> _loadedSounds = [];
  final Map<int, SoundHandle> _activeByIndex = {};

  bool _loading = false;

  @override
  void dispose() {
    soloud.deinit();
    super.dispose();
  }

  Future<void> _loadSounds() async {
    setState(() => _loading = true);
    await soloud.disposeAllSources();
    _loadedSounds.clear();
    _activeByIndex.clear();

    final assets = [
      'assets/audio/8_bit_mentality.mp3',
      'assets/audio/explosion.mp3',
      'assets/audio/tic-1.wav',
    ];

    for (final asset in assets) {
      final source = kIsWeb
          ? await soloud.loadAsset(asset, mode: LoadMode.disk)
          : await soloud.loadAsset(asset);
      _loadedSounds.add(source);
    }

    setState(() => _loading = false);
  }

  Future<void> _toggleSound(int index, {required bool looping}) async {
    if (index >= _loadedSounds.length) return;

    final source = _loadedSounds[index];
    final existing = _activeByIndex[index];

    if (existing != null) {
      if (soloud.getIsValidVoiceHandle(existing) &&
          soloud.getLooping(existing)) {
        await soloud.stop(existing);
        _activeByIndex.remove(index);
        setState(() {});
        return;
      }
      _activeByIndex.remove(index);
    }

    final handle = soloud.play(source, looping: looping);
    _activeByIndex[index] = handle;
    setState(() {});
  }

  Future<void> _stopAll() async {
    for (final entry in _activeByIndex.entries.toList()) {
      await soloud.stop(entry.value);
    }
    _activeByIndex.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!soloud.isInitialized) return const SizedBox.shrink();

    return Scaffold(
      appBar: AppBar(title: const Text('Issue #446 Repro')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              if (_loading) const CircularProgressIndicator(),
              ElevatedButton(
                onPressed: _loadSounds,
                child: const Text('1. Load Sounds'),
              ),
              const Divider(),
              for (var i = 0; i < _loadedSounds.length; i++)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () => _toggleSound(i, looping: true),
                      child: Text(
                        _activeByIndex.containsKey(i)
                            ? 'Stop sound $i'
                            : 'Play sound $i (loop)',
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _toggleSound(i, looping: false),
                      child: const Text('Play once'),
                    ),
                  ],
                ),
              const Divider(),
              ElevatedButton(
                onPressed: _stopAll,
                child: const Text('Stop All'),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Repro steps:\n'
                  '1. Load Sounds\n'
                  '2. Play sound 0 (loop)\n'
                  '3. Stop sound 0\n'
                  '4. Play sound 0 or sound 1\n'
                  'Expected: clean start\n'
                  'Actual (bug): ~0.5s of old audio plays first',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
