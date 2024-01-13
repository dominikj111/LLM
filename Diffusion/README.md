# DOCKERIZED STABLE DIFFUSION WEB APP

**Simple way** to serve stable diffusion web application.

Tested with these models:

- [model-epoch07-float32.ckpt](https://huggingface.co/hakurei/waifu-diffusion-v1-3)
- [sd_xl_base_1.0.safetensors](https://huggingface.co/wangqyqq/sd_xl_base_1.0_inpainting_0.1.safetensors)
- [v1-5-pruned-emaonly.ckpt](https://huggingface.co/LarryAIDraw/v1-5-pruned-emaonly)
- [v2-1_768-ema-pruned-fp16.ckpt](https://huggingface.co/stabilityai/stable-diffusion-2-1)

There is only **single requirement**, what is the Docker.

<!-- markdownlint-disable MD033 -->
> [!IMPORTANT]
> The test configuration was set with 7 CPUs and 16 GB RAM.<br >
> There are running issues with lower configuration, but not sure the minimum.
<!-- markdownlint-enable MD033 -->

## How to use

- Firstly, create an `env.sh` file according to the `env_sample.sh` template.
- Next you need to build a container by `sh build.sh` command.
- `sh serve.sh` will start the web application. If there is not any model available, it will download the `v2-1_768-ema-pruned-fp16.ckpt` (see the help `sh serve.sh --help` for more details).

## Serving the web application

Do `sh serve.sh` and open the browser on `http://localhost:8080`.

See the help `sh serve.sh --help` for more details.

## Model change

To change the model, download some into the `./dependencies/assets/models/Stable-diffusion` folder and switch in served web application.

## Some results

Test prompt: "Apple tree surrounded by women's in the swimming costumes"

<!-- markdownlint-disable MD033 -->
<img src="./generated/00000-2687079802.png?raw=true" alt="Image of the `sd_xl_base_1.0.safetensors`" width="256" />

<img src="./generated/00000-561566944.png?raw=true" alt="Image of the `v1-5-pruned-emaonly.ckpt`" width="256" />

<img src="./generated/00000-2010975715.png?raw=true" alt="Image of the `model-epoch07-float32.ckpt `" width="256" />
<!-- markdownlint-enable MD033 -->

## Credits

- [AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui.git)
