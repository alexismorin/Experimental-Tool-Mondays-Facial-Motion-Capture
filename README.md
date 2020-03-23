# Kinect Utilities
## Kinect Utilities for Windows By Rumen Filkov - Do Not Redistribute


How to integrate KinectExtras with KinectManager:
To integrate the KinectExtras with the KinectManager (from ‘Kinect with MS-SDK’-asset), do the following:
1. Open KinectScripts/KinectWrapper.cs and near its start uncomment: #define USE_KINECT_INTERACTION_OR_FACETRACKING.
2. To integrate Kinect speech recognition with the KinectManager as well, uncomment also: #define USE_SPEECH_RECOGNITION.
3. Open KinectScripts/InteractionWrapper.cs and near its start uncomment: #define USE_KINECT_MANAGER.
4. Open KinectScripts/FacetrackingWrapper.cs and near its start uncomment: #define USE_KINECT_MANAGER. If you plan to use face-tracking in the scene, don’t forget to enable the ‘Compute color map’-setting of KinectManager-component. It is needed for the face-tracking to work.
5. If you have uncommented ‘USE_SPEECH_RECOGNITION’, open KinectScripts/SpeechWrapper.cs and near its start uncomment: #define USE_KINECT_MANAGER.
6. Make sure that both KinectManager and the Extras’ managers, like the InteractionManager, FacetrackingManager or SpeechManager are components of the MainCamera (or other persistent game object).
7. Open KinectScripts/KinectManager.cs and at the start of its Awake()-method add this line: ‘WrapperTools.EnsureKinectWrapperPresence();’, in order to ensure the presence of the needed native libraries. Also, make sure that the Assets/Resources-folder from KinectExtras-package exists in your project.
8. If you use only the KinectManager-component (but not any of the KinectExtras-managers) in the scene, Open KinectScripts/KinectManager.cs and at the start of its Update()-method add this line: ‘KinectWrapper.UpdateKinectSensor();’. Normally, the KinectExtras-managers do that for you.
9. Run the scene to check if the integration works properly and without errors.