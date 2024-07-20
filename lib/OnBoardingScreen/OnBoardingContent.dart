class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Filter your meals",
    image: "assets/images/f354da0dff20388a4de8ad0100d6f1a7-removebg-preview.png",
    desc: "Filter out your meals based on spending limit and diet, and get personalized recommendations of meals.",
  ),
  OnboardingContents(
    title: "Get Live Outlets",
    image: "assets/images/2265bf36f4ea60ca74c665e94cc58c0c-removebg-preview.png",
    desc:
    "Get to know the live location of outlets and book your reservation.",
  ),
  OnboardingContents(
    title: "Get notified when community engage",
    image: "assets/images/5aa46c23083a60b2dd691147e8b4a98d-removebg-preview.png",
    desc:
    "Take control of notifications, collaborate live or on your own time.",
  ),
];