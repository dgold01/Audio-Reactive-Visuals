# Audio-Reactive Visuals in TouchDesigner

A real-time visual system built in TouchDesigner that transforms live audio and video input into a looping, animated road of reactive blocks. Designed with modularity and clarity in mind, this project focuses on clean data handling, procedural instancing, and a scalable approach to music-driven visuals.

---

## Overview

This project explores the relationship between sound, motion, and visual feedback through generative design. Using TouchDesigner's SOP, CHOP, TOP, and DAT networks, it converts amplitude data from audio into vertical displacement of instanced geometry, while also applying video processing to complement and reinforce the motion.

The system emphasizes:
- A table-based evaluation structure for clarity and debugging
- A modular instancing pipeline using SOP → CHOP → SOP
- Real-time audio and video responsiveness, particularly suited to rhythm-heavy genres like drum and bass

---

## Outcomes

- A performant, loopable block-based visual driven by live audio
- Integrated video input and processing to add visual texture
- A clean eval table pattern (`raw → eval → logic`) to manage state
- Reusable base components structured for extension
- Technical growth in SOP/CHOP instancing, TOP-based video FX, and Python scripting

---

## Features

- **Audio-Driven Geometry**: Blocks move in sync with live amplitude data
- **Video Input & Processing**: Incoming video (e.g. webcam or feed) is processed and layered with generative visuals
- **Instancing via SOP Workflow**: Efficiently generates and updates geometry
- **Eval Table Pattern**: Separates editable input, computed state, and logic output
- **PS5 Controller Support**: Optional real-time manipulation of visual parameters
- **Clear Naming & Structure**: Avoids unnamed intermediate nodes to simplify debugging

---

## How It Works

1. A Grid SOP defines initial block positions.
2. Positions are converted to CHOPs and modulated using amplitude data.
3. The CHOP data is converted back into SOP to apply vertical displacement.
4. Blocks are instanced procedurally in 3D space.
5. Live video is processed with TOPs and optionally composited with the 3D output.
6. State is managed via raw input, eval, and logic output tables using DATs and Python scripts.
7. Custom GLSL shaders handle visual effects and animation.

---

## Technical Components

### Audio Analysis
The system analyzes incoming audio to extract amplitude information that drives visual components.

### Video Processing
Video input is processed through TOP operators for effects and can be mapped to geometry as textures or composited with the final output.

### Controller Input
The PS5 controller integration allows for real-time manipulation of parameters:
- R2 Button: Toggle animation, audio playback, and scenery movement
- R2 Value: Control animation speed, audio speed, and scenery movement speed
- Right Joystick: Camera control (yaw and pitch)

### Logic System
A table-driven logic system maintains state and handles parameter updates, keeping the codebase clean and modular.

---

## File Structure

```
/project_root
│
├── AudioReactiveVisuals.toe  # Main project file
│
├── components/              # Modular components
│   ├── base_audio_analysis/  # Audio processing
│   ├── base_audio_player/    # Audio playback
│   ├── base_controller_input/# PS5 controller input
│   ├── base_logic/           # Logic and state management
│   ├── base_render/          # Camera and rendering
│   ├── base_scenery/         # Environment elements
│   ├── base_video/           # Video components
│   └── base_walking_character/# Character animation
│
├── audio/                   # Audio files
├── models/                  # 3D model assets
├── scripts/                 # Python scripts
└── shaders/                 # GLSL shaders
```

---

## Getting Started

### Requirements
- TouchDesigner (non-commercial or commercial build)
- Audio input (e.g. microphone, system audio)
- (Optional) Video input (e.g. webcam or preloaded video file)
- (Optional) PS5 Controller for interactive control

### Usage
1. Open the `.toe` file in TouchDesigner.
2. Start music playback and/or video input.
3. The system reacts in real time, combining audio-driven movement and processed video.
4. Optional: Connect a PS5 controller for interactive manipulation.
