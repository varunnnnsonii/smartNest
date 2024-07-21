---

# SmartNest

*SmartNest* is an advanced home automation system that leverages machine learning and deep learning models to enhance comfort, security, and sustainability in modern homes. This project integrates multiple smart features, including human detection, carbon emission evaluation, and face recognition, to provide a seamless and personalized living experience.

## Features

- *Human Detection Model:* Monitors live CCTV footage to detect human presence. Sends alerts if movement is detected when the house is locked, adding an extra layer of security.
- *Carbon Emission Evaluation Model:* Analyzes and visualizes electricity usage data to compare carbon emissions before and after smart automation. Helps track usage and its social impact.
- *Face Recognition Model:* Identifies household members through facial recognition and adjusts home settings based on individual preferences stored in Firebase.

## Getting Started

### Prerequisites

- Python 3.x
- Flask
- Flutter
- TensorFlow/Keras
- OpenCV
- Firebase
- Google Cloud Firestore
- Streamlit

### Installation

1. *Clone the repository:*

    bash
    [git clone https://github.com/yourusername/smartnest.git](https://github.com/varunnnnsonii/smartNest.git
    cd smartnest
    

2. *Install required Python packages:*

    bash
    pip install -r requirements.txt
    

3. *Set up Firebase:*

    - Create a Firebase project and set up Firestore.
    - Download the Firebase configuration file and add it to your project.

4. *Run the Flask server:*

    bash
    python object2.py
    

5. *Run the Flutter app:*

    bash
    flutter run
    

    

## Usage

1. *Human Detection:*
   - Ensure CCTV cameras are connected and streaming live footage.
   - The model will detect any human presence and alert the admin if the house is locked.

2. *Carbon Emission Tracking:*
   - The system will automatically track and visualize electricity usage data.
   - Access the Streamlit dashboard to view detailed reports and comparisons.

3. *Face Recognition:*
   - Ensure cameras are set up to capture and recognize household members.
   - The model will adjust home settings based on recognized individuals’ preferences.

