import json
import sys
from unittest import result
import wave
import struct
import sys
import os
import io
import argparse
from google.cloud import speech_v1p1beta1 as speech
from google.cloud import language_v1

os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = '/home/ec2-user/SpeechToText.json'
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = '/home/ec2-user/SentimentAnalysis.json'
     

def transcribe_file(speech_file):
    """Transcribe the given audio file asynchronously."""
    
    client = speech.SpeechClient()

    #with open(speech_file, "rb") as audio_file:
       #content = audio_file.read()

    """
     Note that transcription is limited to a 60 seconds audio file.
     Use a GCS file for audio longer than 1 minute.
    """
    audio = speech.RecognitionAudio(content=speech_file.read())

    config = speech.RecognitionConfig(
        encoding=speech.RecognitionConfig.AudioEncoding.MP3,
        sample_rate_hertz=16000,
        language_code="en-US",
        enable_automatic_punctuation=True,
    )


    operation = client.long_running_recognize(config=config, audio=audio)

    print("Waiting for operation to complete...")
    response = operation.result(timeout=90)

    text = ' '

    # Each result is for a consecutive portion of the audio. Iterate through
    # them to get the transcripts for the entire audio file.
    for result in response.results:
        # The first alternative is the most likely one for this portion.
        print(u'Transcript: {}'.format(result.alternatives[0].transcript))
        print('Confidence: {:.2f}'.format(result.alternatives[0].confidence))
        text += result.alternatives[0].transcript

    #print(text)

     
    
    client = language_v1.LanguageServiceClient()

    language = "en"
    document = language_v1.Document(content=text, type_= language_v1.Document.Type.PLAIN_TEXT, language= language)
    encoding_type = language_v1.EncodingType.UTF8
    sentiment = client.analyze_sentiment(request={"document": document, 'encoding_type': encoding_type})
    
    for sentence in sentiment.sentences:
        print(u"Sentence text: {}".format(sentence.text.content))
        print(u"Sentence sentiment score: {:.2f}".format(sentence.sentiment.score))
        print(u"Sentence sentiment magnitude: {:.2f}".format(sentence.sentiment.magnitude))
    
    
    
if __name__ == "__main__":
    with open(sys.argv[1], 'r') as f:
        data = json.load(f)

    temp_file = io.BytesIO()
    with wave.open(temp_file, 'wb') as temp_input:
        temp_input.setnchannels(1)
        temp_input.setsampwidth(2)
        temp_input.setframerate(8000)

        for i in data:
            temp_input.writeframesraw(struct.pack('<h', i))

    # move the cursor back to the beginning of the "file"
    temp_file.seek(0)

    # Do speech recognition
    #temp_file.read()
    
    transcribe_file(temp_file)
