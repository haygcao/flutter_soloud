import 'all_instances_finished.dart' as all_instances_finished;
import 'async_multi_load.dart' as async_multi_load;
import 'asynchronous_deinit.dart' as asynchronous_deinit;
import 'auto_dispose.dart' as auto_dispose;
import 'buffer_stream_small_mp3.dart' as buffer_stream_small_mp3;
import 'create_notes.dart' as create_notes;
import 'global_filters.dart' as global_filters;
import 'handles.dart' as handles;
import 'looping.dart' as looping;
import 'pan.dart' as pan;
import 'play_seek_pause.dart' as play_seek_pause;
import 'protect_voice.dart' as protect_voice;
import 'sound_filters.dart' as sound_filters;
import 'stop_futures.dart' as stop_futures;
import 'synchronous_deinit.dart' as synchronous_deinit;
import 'test_3d_audio.dart' as test_3d_audio;
import 'test_advanced_pan.dart' as test_advanced_pan;
import 'test_buffer_stream_extended.dart' as test_buffer_stream_extended;
import 'test_compressor_filter.dart' as test_compressor_filter;
import 'test_equalizer_filter.dart' as test_equalizer_filter;
import 'test_limiter_filter.dart' as test_limiter_filter;
import 'test_load_mem.dart' as test_load_mem;
import 'test_pitch_shifter_filter.dart' as test_pitch_shifter_filter;
import 'test_playback_devices.dart' as test_playback_devices;
import 'test_playback_speed.dart' as test_playback_speed;
import 'test_read_samples.dart' as test_read_samples;
import 'test_speech_text.dart' as test_speech_text;
import 'test_visualization.dart' as test_visualization;
import 'test_volume_controls.dart' as test_volume_controls;
import 'test_waveform_controls.dart' as test_waveform_controls;
import 'voice_groups.dart' as voice_groups;

/// A single test entry.
class TestEntry {
  const TestEntry({
    required this.name,
    required this.run,
  });

  final String name;
  final Future<StringBuffer> Function() run;
}

/// The list of all available tests.
///
/// Add new tests here to make them available in the test runner UI.
final List<TestEntry> allTests = [
  // Phase 1: Core Functionality
  const TestEntry(
    name: 'test3dAudio',
    run: test_3d_audio.test3dAudio,
  ),
  const TestEntry(
    name: 'testVolumeControls',
    run: test_volume_controls.testVolumeControls,
  ),
  const TestEntry(
    name: 'testVisualization',
    run: test_visualization.testVisualization,
  ),
  const TestEntry(
    name: 'testLoadMem',
    run: test_load_mem.testLoadMem,
  ),
  const TestEntry(
    name: 'testSpeechText',
    run: test_speech_text.testSpeechText,
  ),

  // Phase 2: Advanced Features - Filters (Single + Global)
  const TestEntry(
    name: 'testEqualizerFilterSingle',
    run: test_equalizer_filter.testEqualizerFilterSingle,
  ),
  const TestEntry(
    name: 'testEqualizerFilterGlobal',
    run: test_equalizer_filter.testEqualizerFilterGlobal,
  ),
  const TestEntry(
    name: 'testPitchShifterFilterSingle',
    run: test_pitch_shifter_filter.testPitchShifterFilterSingle,
  ),
  const TestEntry(
    name: 'testPitchShifterFilterGlobal',
    run: test_pitch_shifter_filter.testPitchShifterFilterGlobal,
  ),
  const TestEntry(
    name: 'testCompressorFilterSingle',
    run: test_compressor_filter.testCompressorFilterSingle,
  ),
  const TestEntry(
    name: 'testCompressorFilterGlobal',
    run: test_compressor_filter.testCompressorFilterGlobal,
  ),
  const TestEntry(
    name: 'testLimiterFilterSingle',
    run: test_limiter_filter.testLimiterFilterSingle,
  ),
  const TestEntry(
    name: 'testLimiterFilterGlobal',
    run: test_limiter_filter.testLimiterFilterGlobal,
  ),

  // Phase 2: Other Advanced Features
  const TestEntry(
    name: 'testWaveformControls',
    run: test_waveform_controls.testWaveformControls,
  ),
  const TestEntry(
    name: 'testPlaybackSpeed',
    run: test_playback_speed.testPlaybackSpeed,
  ),
  const TestEntry(
    name: 'testBufferStreamExtended',
    run: test_buffer_stream_extended.testBufferStreamExtended,
  ),

  // Phase 3: Platform/Edge Cases
  const TestEntry(
    name: 'testPlaybackDevices',
    run: test_playback_devices.testPlaybackDevices,
  ),
  const TestEntry(
    name: 'testReadSamples',
    run: test_read_samples.testReadSamples,
  ),
  const TestEntry(
    name: 'testAdvancedPan',
    run: test_advanced_pan.testAdvancedPan,
  ),

  // Existing tests
  const TestEntry(
    name: 'testProtectVoice',
    run: protect_voice.testProtectVoice,
  ),
  const TestEntry(
    name: 'testAllInstancesFinished',
    run: all_instances_finished.testAllInstancesFinished,
  ),
  const TestEntry(
    name: 'testCreateNotes',
    run: create_notes.testCreateNotes,
  ),
  const TestEntry(
    name: 'testPlaySeekPause',
    run: play_seek_pause.testPlaySeekPause,
  ),
  const TestEntry(
    name: 'testPan',
    run: pan.testPan,
  ),
  const TestEntry(
    name: 'testHandles',
    run: handles.testHandles,
  ),
  const TestEntry(
    name: 'testStopFutures',
    run: stop_futures.testStopFutures,
  ),
  const TestEntry(
    name: 'loopingTests',
    run: looping.loopingTests,
  ),
  const TestEntry(
    name: 'testSynchronousDeinit',
    run: synchronous_deinit.testSynchronousDeinit,
  ),
  const TestEntry(
    name: 'testAsynchronousDeinit',
    run: asynchronous_deinit.testAsynchronousDeinit,
  ),
  const TestEntry(
    name: 'testVoiceGroups',
    run: voice_groups.testVoiceGroups,
  ),
  const TestEntry(
    name: 'testSoundFilters',
    run: sound_filters.testSoundFilters,
  ),
  const TestEntry(
    name: 'testGlobalFilters',
    run: global_filters.testGlobalFilters,
  ),
  const TestEntry(
    name: 'testAsyncMultiLoad',
    run: async_multi_load.testAsyncMultiLoad,
  ),
  const TestEntry(
    name: 'testAutoDispose',
    run: auto_dispose.testAutoDispose,
  ),
  const TestEntry(
    name: 'testBufferStreamSmallMp3',
    run: buffer_stream_small_mp3.testBufferStreamSmallMp3,
  ),
];
