from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import logging

# Initialize the logger
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI()

class TextInput(BaseModel):
    text: str

@app.get("/")
def read_root():
    '''Root endpoint returning a simple message.'''
    logger.info("Root endpoint accessed")
    return {"Hello": "To Open Bionic"}

@app.get("/openbionic/{input_data}")
def boldify_text(input_data: str):
    '''
    Endpoint to boldify half of each word in the input text.
    
    Args:
    input_data (str): The input string.

    Returns:
    dict: A dictionary with the HTML string of the boldified text.
    '''

    # Check for empty input
    if not input_data:
        logger.error("Input text cannot be empty.")
        raise HTTPException(status_code=400, detail="Input text cannot be empty.")

    # HTML style
    style= r'''<style>b { font-family: "SF Pro Display", "Segoe UI", sans-serif;} body { font-size: 25px;}</style>'''

    # Split the input into words
    words = input_data.split()
    boldified_words = []

    # Boldify half of each word
    for word in words:
        half_length = len(word) // 2
        if not len(word) % 2:   
            boldified_word = f"<b>{word[:half_length]}</b>{word[half_length:]}"
            boldified_words.append(boldified_word)
        else:
            boldified_word = f"<b>{word[:half_length+1]}</b>{word[half_length+1:]}"
            boldified_words.append(boldified_word)
    # Join the words back into a single string
    boldified_text = " ".join(boldified_words)

    # Create the HTML response
    html_response = f"<html>{style}<body>{boldified_text}</body></html>"

    logger.info("Text boldified successfully")

    return {"HTML": html_response}
