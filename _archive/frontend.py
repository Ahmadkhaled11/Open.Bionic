import streamlit as st
import requests
import base64
import pdfkit 
import os
from PIL import Image

# Configurations
st.set_page_config(page_title="Open Bionic", page_icon='Open_bionic_small.png', layout="wide", initial_sidebar_state="collapsed", menu_items=None)
backend_url = 'http://localhost:8000/openbionic/'

#Comment this line if running on linux
path_wkhtmltopdf = r'C:\\Program Files\\wkhtmltopdf\\bin\\wkhtmltopdf.exe'
config = pdfkit.configuration(wkhtmltopdf=path_wkhtmltopdf)

# Function to get response from the backend
def get_response(input_text):
    try:
        response = requests.get(f'{backend_url}{input_text}')
        response.raise_for_status()
        return response.json()["HTML"]
    except requests.exceptions.RequestException as err:
        st.error(f"Error: {err}")
        return None

# Function to create pdf from a text
def create_pdf(text):
    return pdfkit.from_string(text, False, configuration=config) if text else None

# Main function to run the Streamlit app
def run_app():
    image = Image.open('Open_bionic_small.png')

    # Layout
    topcol1, topcol2, topcol3 = st.columns(3)
    with topcol1:
        st.image(image, width=200)

    # User Input
    dataInput = st.text_input('Enter some text', "Hello Open Bionic")
    col1, col2, col3 = st.columns(3)

    # Get response
    if dataInput:
        output = get_response(dataInput)
        if output:
            with col1:   
                if st.button('Reproduce'):
                    st.markdown(output,  unsafe_allow_html=True)

            with col2:
                st.download_button(label='Download RTF', data=output, mime='text/rtf', file_name='openbionic_output.rtf')

            with col3:    
                st.download_button(
                    label="Download PDF",
                    data=create_pdf(output),
                    file_name='openbionic_output.pdf',
                    mime='application/octet-stream'
                )
    else:
        output = get_response("Hello Open Bionic")
        if output:
            st.markdown(output,  unsafe_allow_html=True)

# Run the app
run_app()
