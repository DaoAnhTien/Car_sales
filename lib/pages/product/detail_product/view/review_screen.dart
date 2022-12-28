import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/product/detail_product/widget/custom_check_box.dart';
import 'package:oke_car_flutter/pages/product/detail_product/widget/item_review.dart';
import 'package:oke_car_flutter/widgets/custom_rating.dart';

class ReviewProductScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Scaffold(
        body: Container(
          color: Theme
              .of(context)
              .scaffoldBackgroundColor,
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: _buildContent(context),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: _buildFooter(context),
              ), Container(
                alignment: Alignment.bottomCenter,
                // child: _buildProductReviewItem(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: false,
          pinned: true,
          expandedHeight: 120.0,
          centerTitle: false,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: _buildTitle(context),
          ),
        ),
        // BlocProvider<ProductReviewBloc>(
        //   create: (context) {
        //     return ProductReviewBloc(ProductReviewRepository())
        //       ..add(ProductReviewStartEvent(widget.product.id, false));
        //   },
        //   child: ProductReviewWrapper(
        //     product: widget.product,
        //   ),
        // ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Ratings&Reviews',
      // style: Theme.of(context).textTheme.title,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          height: 100.0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white12,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          child: Text(
            'Write a review',
          ),
        ),
      ],
    );
  }

  Widget _buildProductReviewItem() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16.0,
      ),
      child: OpenFlutterProductReviewItem(
        rating: 3,
        writerName: "hoan",
        isHelpfulMarked: true,
        comment: "productReview.comment",
        avatarUrl: 'productReview.authorPhotoUrl',
        withPhotos: true,
        photos: null,
      ),
    );
  }

  Widget _buildTitleCommentAndFilter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '5 reviews',
            style: Theme
                .of(context)
                .textTheme
                .caption,
          ),
          Expanded(
            child: CustomCheckBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.5,
              mainAxisAlignment: MainAxisAlignment.end,
              checked: false,
              title: 'with photos',

            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSummary(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: OpenFlutterRatingSummary(
        barColor: Theme.of(context).accentColor,
        ratingQuantity:7,
        rating: 9,
      ),
    );
  }
}
