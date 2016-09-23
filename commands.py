#!/usr/bin/env python3

import speech_recognition as sr
import subprocess
import simplejson as json
import os

r = sr.Recognizer()
confirm = ["yes", "affirmative", "ok", "sure", "do it", "yeah", "yep", "affirmative soldier", "confirm"]
cancel = ["no", "negative", "don't", "not yet", "cancel", "negative soldier"]


def get_input(prompt="Say Something"):
    with sr.Microphone() as source:
        print(prompt)
        audio = r.listen(source)

    command = ""

    try:
        command = r.recognize_google(audio)
    except sr.UnknownValueError:
        print("Google Speech Recognition could not understand audio")
        respond("I didn't get that.  Try again.")
        ip = get_input()
        return ip
    except sr.RequestError as e:
        print("Could not request results from Google Speech Recognition service; {0}".format(e))
    return r.recognize_google(audio)


class Response:
    def __init__(self):
        pass

def respond(text):
    subprocess.call('say "' + str(text) + '"', shell=True)

def send_email():
    respond("Who would you like to send it to?")
    name = get_input("Name:")
    if name:
        respond("Ok.  I'll send it to " + name + ".  What do you want to say?")
        message = get_input("Message:")
        respond("Ok.  This is your email.  Ready to send?")
        print(message)
        action = get_input("confirm?")
        if action in confirm:
            respond("Ok.  Sent.")
            exec("./compose_email.sh 'nickgermaine1024@gmail.com' 'Some Subject' '"+message+"'")
        elif action in cancel:
            respond("Ok.  I won't send it.")

def generate_joke():
    joke = "An irish man walks out of a bar."
    respond(joke)
    print(joke)
    return True


class Commander:
    def __init__(self):
        pass

    def discover(self, text):
        if "how are you" in text:
            respond("I'm fine, thanks for asking.")
        elif "where are you" in text:
            respond("I can't really say.  I can't see anything.")
        elif "what" in text and "your name" in text:
            respond("My name is SB1099R2.  But you can call me Lianna")
        elif "send email" in text:
            send_email()
        elif "what" in text and "can you do" in text:
            respond("I can send emails for you, search the web, get sports updates, and so much more.")
        elif "tell" in text and "joke" in text:
            generate_joke()
        elif "launch" or "open" in text:
            app = text.split(" ", 1)[-1]
            os.system("open -a " + app + ".app")

        else:
            respond("I didn't get that.")

        return True


