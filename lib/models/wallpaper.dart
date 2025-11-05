class Wallpaper {
  final String title;
  final String subtitle;
  final String? imagePath;
  final String? category;
  final int? totalNo;

  const Wallpaper({
    required this.title,
    required this.subtitle,
    this.imagePath,
    this.category,
    this.totalNo,
    required List<String> tags,
  });

  get tags => null;
}
