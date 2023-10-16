import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int currentPage = 0;

  final List<OnBoard> demoData = [
    OnBoard(
      image: "lib/assets/image/p1.jpg",
      title: "Free game",
      description: "This game is free and both available on Play store and Google play",
    ),
    OnBoard(
      image: "lib/assets/image/p2.jpg",
      title: "A lot of characters",
      description: "There are a lot of characters to choose to play",
    ),
    OnBoard(
      image: "lib/assets/image/p3.jpg",
      title: "Challenge",
      description: "You can challenge with friend",
    ),
        OnBoard(
      image: "lib/assets/image/p4.jpg",
      title: " Quest ",
      description: " While you playing it Game with have quest for you to challenge ",
    ),
        OnBoard(
      image: "lib/assets/image/p5.jpg",
      title: " Always having someone chasing you ",
      description: " The only one who always chasing you is Police",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentPage < demoData.length - 1) {
      setState(() {
        currentPage++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subway Surfers", style: TextStyle(color: Color.fromARGB(255, 246, 221, 98), fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 7, 7, 7),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Expanded(
                flex: 3,
                child: PageView.builder(
                  itemCount: demoData.length,
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) => OnboardingWidget(
                    image: demoData[index].image,
                    title: demoData[index].title,
                    description: demoData[index].description,
                    nextPage: nextPage,
                    previousPage: previousPage,
                    isLastPage: index == demoData.length - 1, // Pass whether it's the last page
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < demoData.length; i++)
                      DotIndicator(isActive: i == currentPage),
                  ],
                ),
              ),
              // SizedBox(height: 20),
              // const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 5,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.red : Colors.red.withOpacity(0.4),
      ),
    );
  }
}

class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingWidget extends StatelessWidget {
  final String image, title, description;
  final VoidCallback nextPage;
  final VoidCallback previousPage;
  final bool isLastPage; // Add a flag for the last page

  const OnboardingWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.nextPage,
    required this.previousPage,
    required this.isLastPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Expanded(
            flex: 3,
            child: Image.asset(image, height: 290),
          ),
          const SizedBox(height: 20),
          
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          // const SizedBox(height: 60),
          // Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isLastPage) // Show the "Skip" button if it's not the last page
                ElevatedButton(
                  onPressed: nextPage,
                  child: Text("Skip"),
                ),
              IconButton(
                onPressed: previousPage,
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              SizedBox(width: 20),
              IconButton(
                onPressed: isLastPage ? () {} : nextPage, // Prevent going to the next page on the last page
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
    );
  }
}



