import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../models/models.dart';
import '../../widgets/shared_widgets.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  NewsArticle get _featured => mockNews.firstWhere((a) => a.isFeatured);

  List<NewsArticle> get _listNews =>
      mockNews.where((a) => !a.isFeatured).toList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _WelcomeHeader(),
          const SizedBox(height: 16),
          Row(
            children: [
              _GpaCard(gpa: mockStatus.gpa),
              const SizedBox(width: 12),
              _NextClassCard(status: mockStatus),
            ],
          ),
          const SizedBox(height: 24),
          SectionHeader(title: 'Campus News', onViewAll: () {}),
          const SizedBox(height: 12),
          _FeaturedNewsCard(article: _featured),
          const SizedBox(height: 12),
          ..._listNews.map((a) => _NewsListItem(article: a)),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

// ── Welcome Header ─────────────────────────────
class _WelcomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            text: 'Welcome, ',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark),
            children: [
              TextSpan(
                  text: 'Qaseem',
                  style: TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Text('Your academic and career dashboard is ready.',
            style: TextStyle(fontSize: 13, color: AppColors.textMuted)),
      ],
    );
  }
}

// ── GPA Card ───────────────────────────────────
class _GpaCard extends StatelessWidget {
  final String gpa;
  const _GpaCard({required this.gpa});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('CURRENT GPA',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 0.5)),
            const SizedBox(height: 6),
            Text(gpa,
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
            const SizedBox(height: 4),
            const Text('Out of 4.0',
                style: TextStyle(fontSize: 11, color: Colors.white60)),
          ],
        ),
      ),
    );
  }
}

// ── Next Class Card ────────────────────────────
class _NextClassCard extends StatelessWidget {
  final StudentStatus status;
  const _NextClassCard({required this.status});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('NEXT CLASS',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMuted,
                    letterSpacing: 0.5)),
            const SizedBox(height: 6),
            Text(status.nextClass,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary)),
            const SizedBox(height: 4),
            Row(children: [
              const Icon(Icons.access_time,
                  size: 11, color: AppColors.textMuted),
              const SizedBox(width: 3),
              Text(status.classTime, style: AppTextStyles.muted),
            ]),
            const SizedBox(height: 2),
            Row(children: [
              const Icon(Icons.room_outlined,
                  size: 11, color: AppColors.textMuted),
              const SizedBox(width: 3),
              Text(status.classRoom, style: AppTextStyles.muted),
            ]),
          ],
        ),
      ),
    );
  }
}

// ── Featured News Card ─────────────────────────
class _FeaturedNewsCard extends StatelessWidget {
  final NewsArticle article;
  const _FeaturedNewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(article.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                          color: AppColors.primaryLight,
                          child: const Center(
                              child: Icon(Icons.image_outlined,
                                  color: AppColors.primary, size: 40)),
                        )),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Text('FEATURED',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.category,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        letterSpacing: 0.5)),
                const SizedBox(height: 5),
                Text(article.title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                        height: 1.4)),
                const SizedBox(height: 6),
                Text(article.date, style: AppTextStyles.muted),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── News List Item ─────────────────────────────
class _NewsListItem extends StatelessWidget {
  final NewsArticle article;
  const _NewsListItem({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderColor.withOpacity(0.6)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 62,
              height: 62,
              child: Image.network(article.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                        color: AppColors.primaryLight,
                        child: const Icon(Icons.image_outlined,
                            color: AppColors.primary, size: 24),
                      )),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(article.category,
                      style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                          letterSpacing: 0.4)),
                ),
                const SizedBox(height: 5),
                Text(article.title,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                        height: 1.35),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(article.date, style: AppTextStyles.muted),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 18),
        ],
      ),
    );
  }
}
