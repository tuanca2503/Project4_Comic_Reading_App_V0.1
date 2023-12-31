import 'package:flutter/material.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/config/app_font_size.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/models/comic/chapter/page_chapter_item.dart';
import 'package:project4/models/comic/detail_comic.dart';
import 'package:project4/repositories/comic_repository.dart';
import 'package:project4/repositories/comment_repository.dart';
import 'package:project4/screens/comic/reading_screen.dart';
import 'package:project4/screens/comic/scroll_page_comment_widget.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/custom_date_utils.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/utils/string_utils.dart';
import 'package:project4/widgets/app/custom_app_bar.dart';
import 'package:project4/widgets/app/custom_text_form_field.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/comic/interact_comic.dart';
import 'package:project4/widgets/comic/list_widget/list_genres_horizontal.dart';
import 'package:project4/widgets/loading_dialog.dart';

class DetailsComicScreen extends StatefulWidget {
  const DetailsComicScreen({super.key, required this.id, this.showButton = 0});

  final String id;
  final int showButton;

  @override
  State<DetailsComicScreen> createState() => _DetailsComicScreenState();
}

class _DetailsComicScreenState extends State<DetailsComicScreen> {
  final TextEditingController _commentController = TextEditingController();
  bool _isNeedGetNewDataScroll = false;
  DetailComic? _detailComic;
  final List<Widget> _tabs = [
    const Align(alignment: Alignment.center, child: Text('Giới thiệu')),
    const Align(alignment: Alignment.center, child: Text('Danh sách chương')),
    const Align(alignment: Alignment.center, child: Text('Bình luận')),
  ];
  bool _isSortDesc = true;

  bool _getIsNeedGetNewDataScroll() {
    if (_isNeedGetNewDataScroll) {
      _isNeedGetNewDataScroll = false;
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    ComicRepository.instance.getDetailsComics(id: widget.id).then((value) {
      setState(() {
        _detailComic = value;
      });
    });
  }

  void _onSendComment() {
    if (_commentController.text.isHasText) {
      if (!Storages.instance.isLogin()) {
        Helper.showErrorSnackBar(context, 'Bạn phải đăng nhập để bình luận!');
        return;
      }
      showDialog(context: context, builder: (c) {
        return const LoadingDialog(message: "Đang gửi bình luận");
      });
      CommentRepository.instance.createOrUpdateComment(content: _commentController.text, mangaId: _detailComic!.id)
          .then((_) {
        Helper.dialogPop(context);
        setState(() {
          _commentController.clear();
          _isNeedGetNewDataScroll = true;
        });
      }).catchError((Object e, StackTrace stackTrace) {
        Helper.dialogPop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        selectedAppBar: AppBarEnum.back,
        color: AppColor.onOverlay,
      ),
      body: _detailComic == null
          ? BaseWidget.instance.loadingWidget()
          : Column(
              children: [
                Expanded(flex: 55, child: _coverImageContainerWidget()),
                Expanded(flex: 45, child: _tabWidget()),
              ],
            ),
    );
  }

  Widget _coverImageContainerWidget() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: BaseWidget.instance
                .setImageNetwork(link: _detailComic!.coverImage),
          ),
          Positioned.fill(
            child: Container(
              color: AppColor.overlay,
              child: _comicInfoWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _comicInfoWidget() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Container(
        padding: AppDimension.initPaddingBody(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  _detailComic!.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSize.headline1,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppDimension.dimension8,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Tác giả: ${_detailComic!.author}',
                style: TextStyle(
                  fontSize: AppFontSize.label,
                  color: AppColor.onOverlay,
                ),
              ),
            ),
            const SizedBox(
              height: AppDimension.dimension8,
            ),
            Container(
              alignment: Alignment.center,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Thời gian tải lên - ${CustomDateUtils.formatDateFromTs(_detailComic!.createdDate)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSize.label,
                    color: AppColor.onOverlay,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppDimension.dimension8,
            ),
            ListGenresHorizontal(
              genres: _detailComic!.genres,
              height: AppDimension.dimension32,
              fontSize: AppFontSize.label,
              bgColor: Theme.of(context).colorScheme.secondary,
              textColor: Theme.of(context).colorScheme.onSecondary,
            ),
            const SizedBox(
              height: AppDimension.dimension32,
            ),
            InteractComicWidget(
              bgColor: AppColor.transparent,
              borderColor: Theme.of(context).colorScheme.primary,
              iconColor: AppColor.onOverlay,
              height: AppFontSize.headline1 * 4,
              detailComic: _detailComic!,
              textColor: AppColor.onOverlay,
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabWidget() {
    return DefaultTabController(
      length: _tabs.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: AppDimension.dimension16,
                left: AppDimension.dimension16,
                right: AppDimension.dimension16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.tertiary
              ]),
            ),
            child: SizedBox(
              height: AppFontSize.headline1,
              child: TabBar(
                labelColor: Theme.of(context).colorScheme.tertiary,
                unselectedLabelColor: Theme.of(context).colorScheme.onTertiary,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColor.transparent,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                dividerColor: AppColor.transparent,
                indicator: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppDimension.dimension8),
                      topRight: Radius.circular(AppDimension.dimension8),
                    ),
                    color: Theme.of(context).colorScheme.background),
                tabs: _tabs,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: AppDimension.initPaddingBody(
                  bodyPaddingType: BodyPaddingType.horizontalTop),
              child: TabBarView(
                children: [
                  _descriptionComicWidget(),
                  _chapterListComicWidget(),
                  _commentWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionComicWidget() {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          _detailComic!.description,
          style: TextStyle(fontSize: AppFontSize.body),
        ),
      ),
    );
  }

  Widget _chapterListComicWidget() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            _toggleChapterListWidget(constraints.maxHeight * 0.25),
            _chapterList(constraints.maxHeight * 0.25),
          ],
        );
      },
    );
  }

  Widget _toggleChapterListWidget(double height) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSortDesc = !_isSortDesc;
        });
        _detailComic!.chapters = _detailComic!.chapters.reversed.toList();
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  '${Environment.apiUrl}/${_detailComic!.coverImage}'),
              fit: BoxFit.cover),
        ),
        child: Container(
          padding: const EdgeInsets.all(AppDimension.dimension8),
          color: const Color.fromARGB(200, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Danh sách chương',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          Theme.of(context).textTheme.titleMedium?.fontSize,
                      color: AppColor.onOverlay,
                    ),
                  ),
                  Text(
                    "${_detailComic!.totalChapters} chương",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          Theme.of(context).textTheme.labelLarge?.fontSize,
                      color: AppColor.onOverlay,
                    ),
                  ),
                ],
              ),
              Container(
                  child: BaseWidget.instance.setIcon(
                iconData:
                    _isSortDesc ? Icons.arrow_downward : Icons.arrow_upward,
                color: Theme.of(context).colorScheme.primary,
                size: 18,
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _commentWidget() {
    return Column(
      children: [
        CustomTextFormField(
          controller: _commentController,
          hintText: 'Nhập bình luận ...',
          prefixIcon: BaseWidget.instance.setIcon(iconData: Icons.comment),
          suffixIcon: BaseWidget.instance.setIcon(iconData: Icons.send),
          onSuffixIcon: _onSendComment,
        ),
        Expanded(child: ScrollPageCommentWidget(mangaId: _detailComic!.id, isNeedGetNewData: _getIsNeedGetNewDataScroll(),)),
      ],
    );
  }

  Widget _chapterList(double height) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < _detailComic!.chapters.length; i++)
              _chapterDetailWidget(height, _detailComic!.chapters[i], i)
          ],
        ),
      ),
    );
  }

  Widget _chapterDetailWidget(
      double height, PageChapterItem chapter, int chapterIndex) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(AppDimension.dimension8),
        height: height,
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(chapter.name),
                  Text(
                    CustomDateUtils.formatDateFromTs(chapter.lastUpdatedDate!),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 2,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppDimension.dimension4),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Helper.navigatorPush(
            context: context,
            screen: ReadingScreen(
              chapterIndex: chapterIndex,
              chapterList: _detailComic!.chapters,
            ));
      },
    );
  }
}
