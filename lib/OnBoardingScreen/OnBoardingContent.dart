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
    title: "Automate Home ",
    image: "assets/images/board1.jpg",
    desc: "Smart Nest seamlessly integrates with your household devices",
  ),
  OnboardingContents(
    title: "Anamoly Identify ",
    image: "assets/images/board2.jpg",
    desc:
    "Smart Nest leverages advanced anomaly detection algorithms to monitor home activity in real-time. When no one is home, the app intelligently ",
  ),
  OnboardingContents(
    title: "Environment Friendly",
    image: "assets/images/WhatsApp Image 2024-07-21 at 01.47.53.jpeg",
    desc:"Smart Nest helps you understand your environmental impact , contributing to a greener society."
  ),
];