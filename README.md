![](assets/Untitled-2023-05-18-0327.png)

The ESRGAN CLI package is a command-line tool that enhances images using the ESRGAN (Enhanced Super-Resolution Generative Adversarial Networks) algorithm. It provides a convenient interface to interact with an ESRGAN API service and process images for improved visual quality.

## Features:
- Enhance images using the RealESRGAN algorithm
- Simple and intuitive command-line interface
- Supports specifying the URL of the ESRGAN API service
- Process images from various sources (local file or remote URL)
- Specify custom output filenames for processed images

## Usage:
`esrgan <service_url> <img_url> <output_filename>`

Example:
- `esrgan https://cf13-35-197-62-150.ngrok-free.app "https://static.wikia.nocookie.net/breakingbad/images/b/b4/Walter_2008.png/revision/latest?cb=20200704164147" walter`

## Installation:
`pip install esrgan-cli`

Click [here](SERVICE.md) for service_url setup details.

Note: This package requires an active internet connection to access the ESRGAN API service.

Contributions and bug reports are welcome!

## Acknowledgements:
- [Real-ESRGAN](https://github.com/ai-forever/Real-ESRGAN)
