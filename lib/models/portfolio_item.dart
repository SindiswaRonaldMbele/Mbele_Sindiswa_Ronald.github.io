class PortfolioItem {
  const PortfolioItem({required this.id, required this.title, required this.description, required this.mainCategory, required this.subCategory, required this.tags, this.longDescription = '', this.technologies = const [], this.status = 'Published', this.date = '', this.link = ''});

  final String id;
  final String title;
  final String description;
  final String mainCategory;
  final String subCategory;
  final List<String> tags;
  final String longDescription;
  final List<String> technologies;
  final String status;
  final String date;
  final String link;

  factory PortfolioItem.fromMap(String id, Map<String, dynamic> map) => PortfolioItem(
        id: id,
        title: map['title'] as String? ?? '',
        description: map['description'] as String? ?? '',
        mainCategory: map['mainCategory'] as String? ?? '',
        subCategory: map['subCategory'] as String? ?? '',
        tags: List<String>.from(map['tags'] as List? ?? const []),
        longDescription: map['longDescription'] as String? ?? '',
        technologies: List<String>.from(map['technologies'] as List? ?? const []),
        status: map['status'] as String? ?? 'Published',
        date: map['date'] as String? ?? '',
        link: map['link'] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'mainCategory': mainCategory,
        'subCategory': subCategory,
        'tags': tags,
        'longDescription': longDescription,
        'technologies': technologies,
        'status': status,
        'date': date,
        'link': link,
        'updatedAt': DateTime.now().toIso8601String(),
      };
}
