import json
import sys
import wave
import struct
import os
import io
from google.cloud import speech_v1p1beta1 as speech
from google.cloud import language_v1

def transcribe_file(speech_file):
    """Transcribe the given audio file asynchronously."""

    client = speech.SpeechClient()

    with open(speech_file, "rb") as audio_file:
        content = audio_file.read()

    """
     Note that transcription is limited to a 60 seconds audio file.
     Use a GCS file for audio longer than 1 minute.
    """
    audio = speech.RecognitionAudio(content=content)

    config = speech.RecognitionConfig(
        encoding=speech.RecognitionConfig.AudioEncoding.LINEAR16,
        sample_rate_hertz=8000,
        language_code="en-US",
    )


    operation = client.long_running_recognize(config=config, audio=audio)

    print("Waiting for operation to complete...")
    response = operation.result(timeout=90)

    # Each result is for a consecutive portion of the audio. Iterate through
    # them to get the transcripts for the entire audio file.
    for result in response.results:
        # The first alternative is the most likely one for this portion.
        print(u"Transcript: {}".format(result.alternatives[0].transcript))
        print("Confidence: {}".format(result.alternatives[0].confidence))

    text = 'Transcript: {}'.format(result.alternatives[0].transcript)

    client = language_v1.LanguageServiceClient()

    document = language_v1.Document(content=text, type_= language_v1.Document.Type.PLAIN_TEXT)
    sentiment = client.analyze_sentiment(request={"document": document})

    score = sentiment.document_sentiment.score
    magnitude = sentiment.document_sentiment.magnitude
    for index, sentence in enumerate(sentiment.sentences):
        sentence_sentiment = sentence.sentiment.score
        print("Sentence {} has a sentiment score of {}".format(index, sentence_sentiment))
    print("Overall Sentiment: score of {} with magnitude of {}".format(score, magnitude))


if __name__ == "_main":

    with open(sys.argv[1], 'r') as f:
        data = json.load(f)

    out = wave.open('output.wav','w')
    out.setnchannels(1)
    out.setsampwidth(2)
    out.setframerate(8000)

    for i in data:
        print(i)
        out.writeframesraw(struct.pack('<h', i))

    out.close()

    transcribe_file(out)

    f.close()   