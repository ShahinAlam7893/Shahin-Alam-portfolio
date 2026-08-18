import 'dart:math';
import 'package:flutter/material.dart';

/// Text that "decodes" from random glyphs into the final string, left to right
/// (the effect seen on anindya.pro's nav). Plays on hover by default; can also
/// auto-play once on mount.
class ScrambleText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;
  final bool playOnHover;
  final bool autoPlay;
  final TextAlign? textAlign;

  const ScrambleText(
    this.text, {
    super.key,
    this.style,
    this.duration = const Duration(milliseconds: 650),
    this.playOnHover = true,
    this.autoPlay = false,
    this.textAlign,
  });

  @override
  State<ScrambleText> createState() => _ScrambleTextState();
}

class _ScrambleTextState extends State<ScrambleText>
    with SingleTickerProviderStateMixin {
  static const _glyphs = '!<>-_\\/[]{}=+*^?#ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final _rand = Random();
  late final AnimationController _controller;
  late String _display;

  @override
  void initState() {
    super.initState();
    _display = widget.text;
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(_onTick);
    if (widget.autoPlay) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _play());
    }
  }

  @override
  void didUpdateWidget(covariant ScrambleText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text && !_controller.isAnimating) {
      _display = widget.text;
    }
  }

  void _onTick() {
    final text = widget.text;
    final t = _controller.value;
    final buffer = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      final reveal = i / text.length;
      if (t >= reveal || text[i] == ' ') {
        buffer.write(text[i]);
      } else {
        buffer.write(_glyphs[_rand.nextInt(_glyphs.length)]);
      }
    }
    setState(() => _display = buffer.toString());
  }

  void _play() {
    if (!mounted) return;
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Text(_display, style: widget.style, textAlign: widget.textAlign);
    if (!widget.playOnHover) return text;
    return MouseRegion(onEnter: (_) => _play(), child: text);
  }
}
