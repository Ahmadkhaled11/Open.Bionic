# Open|Bionic

**Open**|Bionic **I**s **a**n **Accessi**bility **Read**ing **Sys**tem **t**o **he**lp **AD**HD **peo**ple **Incre**ased **Foc**us **i**n **the**ir **read**ing **sess**ions **an**d **Compreh**ension. **Th**is **itera**tion **o**f **th**e **sys**tem **i**s **OpenS**ource **und**er **MI**T **Lice**nse, **an**d **fo**r **th**e **curr**ent **vers**ion, **i**t **us**es **Fast**API **fo**r **th**e **back**end **an**d **Strea**mlit **fo**r **th**e **fro**nt **en**d, **an**d **o**n **th**e **road**map **w**e **wou**ld **intro**duce **We**b **techno**logies **fo**r **optim**ized **exper**ience **whi**le **keep**ing **Fast**API **t**o **harn**ess **cross-p**latform **compati**bility **i**f **an**y **us**er **nee**ds **t**o **us**e **i**t **i**n **a** **for**mat **sui**ts **the**ir **nee**ds.

What Problem does it solve?

As ADHD person, I suffer from shifting focus especially when reading long content because of ADHD causes executive dysfunction so we easily distracted, but we can't find easy or none commercial accessibility solutions to enable us to have immersive reading experience to enhance our reading flow, which makes us always anxious and fall into procrastination.

**Th**e **Id**ea **an**d **functio**nality **anal**ysis **con**fu **b**y **@ahmed**benaw, **Th**e **Prod**uct **Mana**ger **wh**o **anal**yzed **th**e **met**hod **an**d **tes**ted **i**t **usi**ng **HTM**L, **CS**S, **an**d **Vani**lla **JavaSc**ript. **Th**ey **@Ahmadk**haled11 **to**ok **ov**er **th**e **proj**ect **t**o **cre**ate **a** **sta**ble **vers**ion **o**f **Open**|Bionic **Co**re **t**o **b**e **a**n **open-s**ource **re**po **fo**r **th**e **accessi**bility **feat**ure **aim**ed **a**t **peo**ple **wi**th **ADH**D. **Th**e **Prod**uct **Mana**ger **(AD**HD **survi**vor) **i**s **exci**ted **t**o **rele**ase **Open**|Bionicc **Co**re **an**d **beli**eves **i**t **wi**ll **b**e **a** **valu**able **to**ol **fo**r **peo**ple **wi**th **ADH**D. **Th**ey **ho**pe **th**is **wi**ll **he**lp **impr**ove **th**e **liv**es **o**f **peo**ple **wi**th **AD**HD **an**d **all**ow **th**em **t**o **lea**rn, **gro**w, **an**d **thri**ve. 

## Backend

The backend is built with FastAPI and has two endpoints:
- The root endpoint (`/`) which returns a simple JSON message.
- The `/openbionic/{input_data}` endpoint which takes a string as a path parameter, splits it into words, and bolds half of each word. It then returns an HTML string in JSON format, where the first half of each word is wrapped in `<b>` tags.

## Frontend

The frontend is created with Streamlit and has a simple interface with a text input field and three buttons:
- The 'Reproduce' button sends the entered text to the FastAPI server and displays the returned HTML (with half-bold words) on the Streamlit app.
- The 'Download RTF' button sends the entered text to the FastAPI server and allows the user to download the returned HTML as an RTF file.
- The 'Download PDF' button sends the entered text to the FastAPI server, converts the returned HTML to a PDF file using `pdfkit`, and allows the user to download it.

## How to run the application
1. Start the backend server: `uvicorn backend:app --reload`
2. Run the frontend: `streamlit run frontend.py`

## Dependencies
- FastAPI
- Pydantic
- Streamlit
- Requests
- pdfkit
- wkhtmltopdf
- Pillow

Please make sure that `wkhtmltopdf` is installed on your system and its path is correctly specified in the `frontend.py` file.
Product Roadmap 🚀

- [ ] Rebuilding the core functionalities using web technologies in strict Vanilla JavaScript and FastAPI, to optimize performance. 🛠️
- [ ] Support saving and uploading various file formats (Word, Excel, PDF, ePub, Powerpoint, etc.) on demand 📄
- [ ] Integrate Whisperer API (OpenAI) for text-to-speech feature with accessibility options (pitch, speed, character) 🔊
- [ ] Offer multiple font styles and sizes 🖋️
- [ ] Enable dark mode and letter fixation options 🌙
- [ ] Use OpenAI to tokenize text and control saccade (manual and automatic) 🧠
- [ ] Develop plugins for Kindle, Chromium, Google Drive, Microsoft 365 🔌
- [ ] Add speed reading feature with Whisperer integration 🚀
- [ ] Launch Divergent Readers Annual Challenge to motivate users to set and achieve reading goals using our app metrics 🏆


## License
[MIT](https://choosealicense.com/licenses/mit/)
