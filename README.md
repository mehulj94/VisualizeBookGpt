**Context:**

I was recently reading “Desert Solitaire” by Edward Abbey where he paints the Moab scenery with a powerful and passionate brush. The author's descriptions of the scenery were so vivid and detailed that I found it difficult to visualize the scene as quickly as I would have liked. So I came up with an idea of generating images based on the highlighted text.

**Idea:**
* User will highlight the text on reader and after highlighting they will see an option to generate image
* Software will use highlighted text as the prompt to Image generation models (StabilityAI/Dall-e/Titan etc)
* User will see the generated images

<img width="345" alt="kindle-img-generation-demo2" src="https://github.com/user-attachments/assets/d91d10d6-d890-486c-9fdf-ddf29696349a">
<img width="351" alt="kindle-img-generation-demo1" src="https://github.com/user-attachments/assets/f17fbed6-9dec-406a-982d-e646396ffcba">


 
**My Setup:**
* I am running Stability AI diffusion model on ec2. Follow this git repository to set it up: https://github.com/AUTOMATIC1111/stable-diffusion-webui
* Create SSH tunnel to the ec2 instance : ssh -N -L 192.168.86.43:7860:127.0.0.1:7860 -i ec2_key.pem username@ip-address
* Running KOReader on Android simulator on mac. In directory koreader/plugins create folder visualizebookgpt.koplugin and copy and paster files from repo to the plugin folder

**Demo:**


https://github.com/user-attachments/assets/175b9da3-4f49-44c9-b16d-7faea465168f
