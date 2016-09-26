#!/usr/bin/env python3

import speech_recognition as sr
import subprocess
import simplejson as json
from commands import Commander, Response
import pyaudio
import wave
import sys, os
from PyQt5.QtCore import *
from PyQt5.QtGui import *
from PyQt5.Qt import *
from PyQt5.QtQuick import *
from . import icons_rc


def open_file(filename):
    chunk = 1024
    wf = wave.open(filename, 'rb')
    p = pyaudio.PyAudio()

    stream = p.open(
        format=p.get_format_from_width(wf.getsampwidth()),
        channels=wf.getnchannels(),
        rate=wf.getframerate(),
        output=True)
    data = wf.readframes(chunk)

    while data:
        stream.write(data)
        data = wf.readframes(chunk)

    stream.close()
    p.terminate()

r = sr.Recognizer()

def say(text):
    subprocess.call('say -v "Samantha" ' + text, shell=True)

quit = ["bye", "by", "goody bye", "buy", "quit", "seeya", "later", "shutdown"]

active = True

if __name__ == "__main__":
    # Create the application instance.
    app = QGuiApplication(sys.argv)

    # Create a QML engine.
    engine = QQmlApplicationEngine()

    engine.addImportPath("/usr/lib/qt/qml/")

    # Create a component factory and load the QML script.
    engine.load(QUrl.fromLocalFile("main.qml"))

    win = engine.rootObjects()[0]
    win.show()
    sys.exit(app.exec_())


    '''QApplication,
    open_file('./audio/audio_initiate.wav')
    with sr.Microphone() as source:
        print("Say something")
        audio = r.listen(source)

    open_file('./audio/audio_end.wav')

    command = ""

    # recognize speech using Google Speech Recognition
    try:
        # for testing purposes, we're just using the default API key
        # to use another API key, use `r.recognize_google(audio, key="GOOGLE_SPEECH_RECOGNITION_API_KEY")`
        # instead of `r.recognize_google(audio)`
        # print("Google Speech Recognition thinks you said " + r.recognize_google(audio))
        command = r.recognize_google(audio)
    except sr.UnknownValueError:
        print("Google Speech Recognition could not understand audio")
    except sr.RequestError as e:
        print("Could not request results from Google Speech Recognition service; {0}".format(e))

    if command in quit:
        say("Bye")
        active = False
    else:
        commander = Commander()
        commander.discover(command)
        active = False
    '''

