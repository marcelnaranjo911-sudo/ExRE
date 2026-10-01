import 'package:flutter/material.dart';

enum ResourceCategory { flutter, android, layouts, scrollables, slivers, navegacion }
enum ResourceLevel { basico, intermedio, avanzado }
enum ResourceType { video, lectura, practica, documento }

class Resource {
  final String id;
  final String title;
  final ResourceCategory category;
  final String author;
  final int durationMinutes;
  final ResourceLevel level;
  final String description;
  final ResourceType type;
  final Color color;

  const Resource({
    required this.id,
    required this.title,
    required this.category,
    required this.author,
    required this.durationMinutes,
    required this.level,
    required this.description,
    required this.type,
    required this.color,
  });

  String get categoryName => category.name[0].toUpperCase() + category.name.substring(1);
  String get levelName {
    switch (level) {
      case ResourceLevel.basico: return 'Básico';
      case ResourceLevel.intermedio: return 'Intermedio';
      case ResourceLevel.avanzado: return 'Avanzado';
    }
  }
  String get typeName => type.name[0].toUpperCase() + type.name.substring(1);

  IconData get typeIcon {
    switch (type) {
      case ResourceType.video: return Icons.play_arrow;
      case ResourceType.lectura: return Icons.book;
      case ResourceType.practica: return Icons.code;
      case ResourceType.documento: return Icons.insert_drive_file;
    }
  }
}