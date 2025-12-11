# Unity-HDRP-Vioso-Lablab
Unity HDRP example project with Vioso integration for the Lablab studio.

## Installation

If you are a first time user, we recommend installing this sample project first to ensure that everything is working correctly. To install this project, follow the steps "Installing the sample project" below.

If you are an experienced user and already have an existing project, follow the "Merging into your project" steps below.

### Installing the sample project (recommended for first time users)

1. Download or clone this project on your computer.

2. Download the Vioso calibration file [here](https://gofile.me/67omf/yH5xHTjiS) and add it to the Assets/Plugins/Vioso/ folder. 

3. Open the SampleScene scene.

4. Follow the Game View setup below.

5. Press Play. You should see the wall outputs in the first game view, and the floor outputs in the second game view, as shown in the screenshot below.


### Merging into your project

1. Copy the Assets/Plugins/Vioso folder from this project into the Assets/Plugins folder of your project. 

2. Copy the Assets/ProjectionSetup folder from this project into the Assets folder of your project.

3. Copy the Assets/Resources folder from this project into the Assets folder of your project.

4. Download the Vioso calibration file [here](https://gofile.me/67omf/yH5xHTjiS) and add it to the Assets/Plugins/Vioso/ folder. 

5. Add the ViosoWarpBlendPP to the After Post Process section of the HDRP Global Settings.

<img src="https://github.com/Theoriz/Unity-HDRP-Vioso-Lablab/blob/main/Resources/Documentation/Screenshots/HDRPGlobalSettings.jpg" width="50%" height="50%">

6. Replace the camera in your scene by the ProjectionSetup prefab from the ProjectionSetup/Prefab folder.

7. Follow the Game view setup below.


### Game View setup

To work with the Lablab video projectors setup, the Unity application creates 3 full screen windows. The window on display 1 is for the wall outputs, the window on display 2 is empty as it is the monitoring display, the window on display 3 is for the floor outputs.

To previsualize this in Unity :

1. Open a first Game View tab, set its output to Display 1, and its resolution to 3840x2400.

2. Open a second Game View tab, set its output to Display 3, and its resolution to 3840x2400.

With this setup, you should see the following output in the sample scene :

![](https://github.com/Theoriz/Unity-HDRP-Vioso-Lablab/blob/main/Resources/Documentation/Screenshots/OutputsMire.jpg)

> [!TIP]
> The Lablab studio model is disabled by default in the prefab. You can activate it for debugging purposes by enabling the Lablab object in the ProjectionSetup prefab.

## Building your application

After building your application, copy the vioso calibration file (.vwf) and VIOSOWarpBlend.ini files from the Unity Assets/Plugins/Vioso folder to your build folder in [your_build_path..]/[your_application_name]_Data/Plugins/[your_architecture]/ next to the ViosoWarpBlend.dll file.

> [!NOTE]
> When building for Windows 64 bits, the ViosoBuildPostProcessor script should automatically make this copy.

## Usage

### ProjectionSetup prefab

The projection setup for the Lablab studio is created in the ProjectionSetup prefab located in the ProjectionSetup/Lablab/Prefab/ folder.

![](https://github.com/Theoriz/Unity-HDRP-Vioso-Lablab/blob/main/Resources/Documentation/Screenshots/ProjectionSetupPrefab.jpg)

Add this prefab to your scene and disable other cameras in order to setup your scene for projection in the Lablab studio.

For example in this project SampleScene, this projection setup as been added to the First person controller to replace the default camera of the First person controller.

![](https://github.com/Theoriz/Unity-HDRP-Vioso-Lablab/blob/main/Resources/Documentation/Screenshots/ProjectionSetupInSampleScene.jpg)


### Using the studio model

In the ProjectionSetup prefab, the Lablab object is a 3D model of the studio for debugging purposes. It is enabled to help you visualize the physical space of the studio in your 3D world and validate the outputs. Once it is setup correctly, you can disable the Lablab component of the ProjectionSetup to see the final output of your scene.

![](https://github.com/Theoriz/Unity-HDRP-Vioso-Lablab/blob/main/Resources/Documentation/Screenshots/ProjectionSetupInSampleSceneMireDisabled.jpg)
![](https://github.com/Theoriz/Unity-HDRP-Vioso-Lablab/blob/main/Resources/Documentation/Screenshots/Outputs.jpg)

## Unity Version

Last tested with Unity 6000.3.0f1.
