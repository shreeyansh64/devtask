import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color kPrimary = Color(0xFFCB4B2A);
const Color kAmber = Color(0xFFF5A623);
const Color kTextDark = Color(0xFF1A1A1A);
const Color kTextGrey = Color(0xFF9E9E9E);
const Color kSubjectGrey = Color(0xFF757575);
const Color kBorder = Color(0xFFE8E8E8);
const Color kBackground = Color(0xFFFFFFFF);

class ProjectItem {
  final String title;
  final String subject;
  final String author;
  final String grade;
  final String imageUrl;

  const ProjectItem({
    required this.title,
    required this.subject,
    required this.author,
    required this.grade,
    required this.imageUrl,
  });
}

final List<ProjectItem> kProjects = [
  const ProjectItem(
    title: 'Kemampuan Merangkum Tulisan',
    subject: 'BAHASA SUNDA',
    author: 'Al-Baiqi Samaan',
    grade: 'A',
    imageUrl: 'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=300&q=80',
  ),
  const ProjectItem(
    title: 'Kemampuan Merangkum Tulisan',
    subject: 'BAHASA SUNDA',
    author: 'Al-Baiqi Samaan',
    grade: 'A',
    imageUrl: 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=300&q=80',
  ),
  const ProjectItem(
    title: 'Kemampuan Merangkum Tulisan',
    subject: 'BAHASA SUNDA',
    author: 'Al-Baiqi Samaan',
    grade: 'A',
    imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=300&q=80',
  ),
  const ProjectItem(
    title: 'Kemampuan Merangkum Tulisan',
    subject: 'BAHASA SUNDA',
    author: 'Al-Baiqi Samaan',
    grade: 'A',
    imageUrl: 'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=300&q=80',
  ),
  const ProjectItem(
    title: 'Analisis Puisi Sunda',
    subject: 'BAHASA SUNDA',
    author: 'Al-Baiqi Samaan',
    grade: 'B',
    imageUrl: 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?w=300&q=80',
  ),
  const ProjectItem(
    title: 'Karangan Bebas Bahasa Indonesia',
    subject: 'BAHASA INDONESIA',
    author: 'Al-Baiqi Samaan',
    grade: 'A',
    imageUrl: 'https://images.unsplash.com/photo-1488190211105-8b0e65b80b4e?w=300&q=80',
  ),
];

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _searchController.addListener(
      () => setState(() => _searchQuery = _searchController.text.toLowerCase()),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<ProjectItem> get _filtered => kProjects
      .where((p) => p.title.toLowerCase().contains(_searchQuery))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildProjectTab(),
                  const SizedBox.shrink(),
                  const SizedBox.shrink(),
                  const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFilterFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
      child: Row(
        children: [
          Text(
            'Portfolio',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: kTextDark,
            ),
          ),
          const Spacer(),
          Icon(Icons.shopping_bag,color: kPrimary,size: 24,),
          SizedBox(width: 10.w),
          Icon(Icons.notifications,color: kPrimary,size: 24,),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: kPrimary,
          unselectedLabelColor: kTextGrey,
          labelStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13.sp,
            fontWeight: FontWeight.w300,
          ),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: kPrimary, width: 2.5.h),
            insets: EdgeInsets.zero,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          tabs: const [
            Tab(text: 'Project'),
            Tab(text: 'Saved'),
            Tab(text: 'Shared'),
            Tab(text: 'Achievment'),
          ],
        ),
        Divider(height: 1.h, thickness: 1, color: kBorder),
      ],
    );
  }

  Widget _buildProjectTab() {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(child: _buildList()),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 8.h),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: kBorder, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: 14.w),
            Expanded(
              child: TextField(
                controller: _searchController,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13.sp,
                  color: kTextDark,
                ),
                decoration: InputDecoration(
                  hintText: 'Search a project',
                  hintStyle: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 13.sp,
                    color: const Color(0xFFBDBDBD),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5.r),
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: kPrimary,
                borderRadius: BorderRadius.circular(9.r),
              ),
              child: Icon(Icons.search_rounded, color: Colors.white, size: 18.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    final items = _filtered;
    if (items.isEmpty) {
      return Center(
        child: Text(
          'No projects found',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13.sp,
            color: kTextGrey,
          ),
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 90.h),
      itemCount: items.length,
      itemBuilder: (_, i) => _ProjectCard(project: items[i]),
    );
  }

  Widget _buildFilterFab() {
    return SizedBox(
      height: 46.h,
      child: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: kPrimary,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        icon: _FilterLinesIcon(size: 18.sp),
        label: Text(
          'Filter',
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectItem project;
  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: kBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(12.r),
              ),
              child: Image.network(
                project.imageUrl,
                width: 108.w,
                height: 108.h,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 108.w,
                  height: 108.h,
                  color: const Color(0xFFF0F0F0),
                  child: Icon(Icons.image_outlined, color: Colors.grey, size: 26.sp),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 14.h, 8.w, 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      project.title,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w700,
                        color: kTextDark,
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      project.subject,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 9.5.sp,
                        fontWeight: FontWeight.w600,
                        color: kSubjectGrey,
                        letterSpacing: 0.4,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    RichText(
                      text: TextSpan(
                        text: 'Oleh ',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w300,
                          color: kSubjectGrey,
                        ),
                        children: [
                          TextSpan(
                            text: project.author,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: kTextDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Center(
                child: Container(
                  width: 44.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: kAmber,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    project.grade,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final Widget child;
  const _IconBtn({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38.w,
      height: 38.h,
      decoration: BoxDecoration(
        color: kPrimary,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(child: child),
    );
  }
}

class _BagIcon extends StatelessWidget {
  final double size;
  const _BagIcon({required this.size});

  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: Size(size, size), painter: _BagPainter());
}

class _BagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final fill = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final stroke = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = s.width * 0.12
      ..strokeCap = StrokeCap.round;

    final body = Path()
      ..moveTo(s.width * 0.08, s.height * 0.38)
      ..lineTo(s.width * 0.92, s.height * 0.38)
      ..lineTo(s.width * 0.84, s.height * 0.90)
      ..quadraticBezierTo(s.width * 0.82, s.height, s.width * 0.72, s.height)
      ..lineTo(s.width * 0.28, s.height)
      ..quadraticBezierTo(s.width * 0.18, s.height, s.width * 0.16, s.height * 0.90)
      ..close();
    canvas.drawPath(body, fill);

    final handle = Path()
      ..moveTo(s.width * 0.32, s.height * 0.38)
      ..cubicTo(
        s.width * 0.32, s.height * 0.08,
        s.width * 0.68, s.height * 0.08,
        s.width * 0.68, s.height * 0.38,
      );
    canvas.drawPath(handle, stroke);

    final dot = Paint()
      ..color = kPrimary
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(s.width * 0.37, s.height * 0.67), s.width * 0.065, dot);
    canvas.drawCircle(Offset(s.width * 0.63, s.height * 0.67), s.width * 0.065, dot);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _BellIcon extends StatelessWidget {
  final double size;
  const _BellIcon({required this.size});

  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: Size(size, size), painter: _BellPainter());
}

class _BellPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final fill = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final bell = Path()
      ..moveTo(s.width * 0.5, 0)
      ..cubicTo(
        s.width * 0.2, 0,
        s.width * 0.12, s.height * 0.22,
        s.width * 0.12, s.height * 0.45,
      )
      ..lineTo(s.width * 0.05, s.height * 0.76)
      ..lineTo(s.width * 0.95, s.height * 0.76)
      ..lineTo(s.width * 0.88, s.height * 0.45)
      ..cubicTo(
        s.width * 0.88, s.height * 0.22,
        s.width * 0.80, 0,
        s.width * 0.5, 0,
      )
      ..close();
    canvas.drawPath(bell, fill);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          s.width * 0.08, s.height * 0.76,
          s.width * 0.84, s.height * 0.1,
        ),
        Radius.circular(s.height * 0.05),
      ),
      fill,
    );

    canvas.drawCircle(Offset(s.width * 0.5, s.height * 0.9), s.width * 0.14, fill);

    final hole = Paint()
      ..color = kPrimary
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(s.width * 0.5, s.height * 0.9), s.width * 0.07, hole);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _FilterLinesIcon extends StatelessWidget {
  final double size;
  const _FilterLinesIcon({required this.size});

  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: Size(size, size * 0.75), painter: _FilterPainter());
}

class _FilterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final p = Paint()
      ..color = Colors.white
      ..strokeWidth = s.height * 0.2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, s.height * 0.1), Offset(s.width, s.height * 0.1), p);
    canvas.drawLine(
        Offset(s.width * 0.14, s.height * 0.5),
        Offset(s.width * 0.86, s.height * 0.5),
        p);
    canvas.drawLine(
        Offset(s.width * 0.3, s.height * 0.9),
        Offset(s.width * 0.7, s.height * 0.9),
        p);
  }

  @override
  bool shouldRepaint(_) => false;
}