import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding =[
    BoardingModel(
        image: 'assets/images/online shopping.jpg',
        title: 'Title 1',
        body: 'Body 1'),
    BoardingModel(
        image: 'assets/images/7010823_3255317.jpg',
        title: 'Title 2',
        body: 'Body 2'),
    BoardingModel(
        image: 'assets/images/11637990_4788942.jpg',
        title: 'Title 3',
        body: 'Body 3'),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                submit();
              },
              child: const Text('SKIP',),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged:(int index) {
                    if( index == boarding.length-1 )
                    {
                      setState(() {
                        isLast = true;
                      });
                    }
                    else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context,index)
                  => buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children:
              [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      activeDotColor: primaryColor,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast)
                      {
                        submit();
                      }
                    else
                      {
                        boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn
                        );
                      }
                  },
                  child: const Icon(
                      Icons.arrow_forward_ios
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value) navigateAndFinish(context, LoginScreen());
    });
  }
  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage(model.image))),
      const SizedBox(
        height: 20.0,
      ),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 24.0,
        ),
      ),
      const SizedBox(
        height: 20.0,
      ),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 18.0,
        ),
      ),
      const SizedBox(
        height: 20.0,
      ),
    ],
  );
}
