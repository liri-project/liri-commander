# Liri Commander
### A smart, material, virtual assistant

## Dependencies

In order to build Liri Commander from source, you will need to install a series of dependencies.
This project is written in Python3, and will be compiled with PyInstaller to provide cross-platform binaries upon release.

### PyAudio

In order to install PyAudio you must first install Port Audio.  On macOS this is as simple as running the following command:

    brew install portaudio && sudo brew link portaudio

And then run the following command to install Pyaudio:

    pip3 install pyaudio

### PyQt5

As with all other Liri Apps, the front-end is written using Qt5.7 and QML.  To install Python bindings for Qt5, first make sure you have Qt5 installed on your system and then run:

    pip3 install sip && pip3 install pyqt5

### SpeechRecognition

We use SpeechRecognition in order to grab input from microphone sources:

    pip3 install SpeechRecognition

### PyTTSX

This package is used when Liri Commander responds to a users voice input.  The version of pyttsx in pypi is outdated and so this package needs to be compiled manually.

    git clone https://github.com/parente/pyttsx.git
    cd pyttsx
    python3 ./setup.py install