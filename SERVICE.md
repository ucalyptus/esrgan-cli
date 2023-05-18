The server code for the ESRGAN CLI package is responsible for running the Flask application and handling image processing requests. Here's an overview of the server code functionality:

```
from flask import Flask, request, jsonify, send_from_directory
import torch
from PIL import Image
import numpy as np
import requests
import os
from io import BytesIO
from RealESRGAN import RealESRGAN
from pyngrok import ngrok, conf
import threading
os.makedirs('/content/output',exist_ok=True)
app = Flask(__name__)

device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

model = RealESRGAN(device, scale=4)
model.load_weights('weights/RealESRGAN_x4.pth', download=True)

@app.route('/process_image', methods=['POST'])
def process_image():
    url = request.json['url']
    response = requests.get(url)
    image = Image.open(BytesIO(response.content)).convert("RGB")

    output_filename = request.json.get('output_filename', 'output')
    sr_image = model.predict(image)

    output_path = f'output/{output_filename}.png'
    sr_image.save(output_path)

    return send_from_directory('output', output_filename + '.png', as_attachment=True)

def run_flask_app():
    app.run(host='localhost', port=5000)

if __name__ == '__main__':
    thread = threading.Thread(target=run_flask_app)
    thread.start()

    conf.get_default().auth_token = <NGROK_AUTHTOKEN>
    
    # Start ngrok tunnel
    ngrok_tunnel = ngrok.connect(5000)
    
    try:
        # Get the public URL
        public_url = ngrok_tunnel.public_url
        print('Ngrok URL:', public_url)

        # Keep the main thread alive while the other threads are running
        while True:
            pass
    except KeyboardInterrupt:
        # Close the ngrok tunnel on KeyboardInterrupt (Ctrl+C)
        ngrok.kill()

```

The server code sets up a Flask application that listens for POST requests to the /process_image route. When a request is received, the server downloads the image from the provided URL, performs image enhancement using the ESRGAN model, and saves the enhanced image. The enhanced image is then returned as a downloadable attachment.

The server code also includes integration with ngrok to create a public URL for the Flask app. This allows external clients to access the image processing functionality. The ngrok tunnel is started and managed within the script.

You can run the server code by executing the script in your preferred Python environment. It will start the Flask app and display the ngrok URL for external access.

```
pip install git+https://github.com/sberbank-ai/Real-ESRGAN.git flask pyngrok
```
