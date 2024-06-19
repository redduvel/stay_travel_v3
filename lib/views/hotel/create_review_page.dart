import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:stay_travel_v3/bloc/auth/auth_bloc.dart';
import 'package:stay_travel_v3/bloc/review/review_bloc.dart';
import 'package:stay_travel_v3/bloc/review/review_event.dart';
import 'package:stay_travel_v3/bloc/review/review_state.dart';
import 'package:stay_travel_v3/models/review.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/widgets/custom_button.dart';

class CreateReviewPage extends StatefulWidget {
  final String hotelId;
  const CreateReviewPage({super.key, required this.hotelId});

  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  TextEditingController _controller = TextEditingController();
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewBloc, ReviewState>(
      listener: (context, state) {
        if (state is ReviewCreated) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Отзыв успешно отправлен.🎉'))
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Оставить отзыв'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(7.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Напишите отзыв:',
                style: AppTextStyles.subheaderStyle,
              ),
              const SizedBox(height: 5),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                    hintText: 'Текст отзыва...',
                    labelStyle: TextStyle(color: AppColors.orange2),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.orange2)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.orange2)),
                    contentPadding: EdgeInsets.all(7.5)),
                maxLines: 5,
              ),
              const SizedBox(height: 5),
              const Text(
                'Выберете оценку:',
                style: AppTextStyles.subheaderStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              RatingBar.builder(
                allowHalfRating: true,
                initialRating: rating,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const Icon(
                    Icons.star,
                    color: AppColors.orange,
                  );
                },
                onRatingUpdate: (value) {
                  setState(() {
                    rating = value;
                  });
                },
              )
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(7.5),
          child: BlocBuilder<ReviewBloc, ReviewState>(builder: (context, state) {
            return CustomButton.load(
              widget: state is ReviewsLoading ? const LoadingIndicator(indicatorType: Indicator.ballSpinFadeLoader) : const Text('Отправить'),
              mainAxisAlignment: MainAxisAlignment.center,
              onPressed: () {
                Review review = Review(
                  userId: context.read<AuthBloc>().currentUser!.id,
                  hotelId: widget.hotelId,
                  text: _controller.text,
                  rating: rating,
                );
      
                context
                  .read<ReviewBloc>()
                  .add(CreateReview(review: review, hotelId: widget.hotelId));
              },
            );
          }),
        ),
      ),
    );
  }
}
