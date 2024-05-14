// Hotel Page
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/widgets/custom_button.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали отеля', style: AppTextStyles.subheaderStyle,),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Image.network(
                  'https://mykaleidoscope.ru/x/uploads/posts/2022-09/1663154968_6-mykaleidoscope-ru-p-buenos-aires-argentina-krasivo-6.jpg'),
            ),
            SliverToBoxAdapter(
              child: Text(
                'The Ritz-Carlton',
                style: AppTextStyles.headerStyle.copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                '1 Miramontes Point Rd, Half Moon Bay',
                style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 5)
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey3, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('4.5', style: AppTextStyles.headerStyle,),
                            Text('rating', style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 18),)
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey3, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('8.6K', style: AppTextStyles.headerStyle,),
                            Text('people rated', style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 18),)
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey3, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('2.3K', style: AppTextStyles.headerStyle,),
                        Text('poeple saved', style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 18),)
                      ],
                    ),
                  )
                ],
              )
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Фотографии', style: AppTextStyles.headerStyle, textAlign: TextAlign.left,),
                  SizedBox(
                    height: 400,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        SliverToBoxAdapter(
                          child: Image.network('https://mykaleidoscope.ru/x/uploads/posts/2022-09/1663154968_6-mykaleidoscope-ru-p-buenos-aires-argentina-krasivo-6.jpg'),
                        ),
                        SliverToBoxAdapter(
                          child: Image.network('https://mykaleidoscope.ru/x/uploads/posts/2022-09/1663154968_6-mykaleidoscope-ru-p-buenos-aires-argentina-krasivo-6.jpg'),
                        ),
                        SliverToBoxAdapter(
                          child: Image.network('https://mykaleidoscope.ru/x/uploads/posts/2022-09/1663154968_6-mykaleidoscope-ru-p-buenos-aires-argentina-krasivo-6.jpg'),
                        ),
                        SliverToBoxAdapter(
                          child: Image.network('https://mykaleidoscope.ru/x/uploads/posts/2022-09/1663154968_6-mykaleidoscope-ru-p-buenos-aires-argentina-krasivo-6.jpg'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        child: CustomButton.normal(text: 'Посетить', mainAxisAlignment: MainAxisAlignment.center, onPressed: () {},),
      ),
    );
  }
}
