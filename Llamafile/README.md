# DOCKERIZED LLAMAFILE GENERATOR

**Simple way** to run, serve and **generate single executable system agnostic Llamafile**.

Tested with these models:

- [tinyllama-1.1b-chat-v0.3.Q2_K.gguf](https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v0.3-GGUF)
- [Wizard-Vicuna-7B-Uncensored.Q5_K_M.gguf](https://huggingface.co/TheBloke/Wizard-Vicuna-7B-Uncensored-GPTQ)
- [orca-2-13b-alpaca-uncensored.gguf.q4_k_m.bin](https://huggingface.co/athirdpath/Orca-2-13b-Alpaca-Uncensored)
- [orca-2-13b-alpaca-uncensored.gguf.q8_0.bin](https://huggingface.co/athirdpath/Orca-2-13b-Alpaca-Uncensored)
- [mixtral-8x7b-v0.1.Q4_K_M.gguf](https://huggingface.co/TheBloke/Mixtral-8x7B-v0.1-GGUF)
- [dolphin-2.5-mixtral-8x7b.Q8_0.gguf](https://huggingface.co/TheBloke/dolphin-2.5-mixtral-8x7b-GGUF)

Not all models are quick, but once generated you can start build your own project upon it.

There is only **single requirement**, what is the Docker.

## How to use

- Firstly, create an `env.sh` file according to the `env_sample.sh` template.
- Next you need to build a container by `sh build.sh` command (`bash build.sh` in case there is a "source not found" error).
- To play with the basic model (tinyllama-1.1b-chat-v0.3.Q2_K.gguf), do `sh run.sh`, where the question is "What is the best way to build a robot?" set as default (see the help `sh run.sh --help` for more details).
- To generate single executable web server, do `sh pack.sh`.

## Serving the web application

Do `sh serve.sh` and open the browser with `http://localhost:8080`.

See the help `sh serve.sh --help` for more details.

## Other options

The other options to run, pack and serve the application are available. In doubt, do `sh run.sh --help`, `sh pack.sh --help` or `sh serve.sh --help`.

To change the model, download the model, move into the `./models` folder and pass the name or relative path to it.

## Some examples

- `sh run.sh --model ./models/Wizard-Vicuna-7B-Uncensored.Q5_K_M.gguf --prompt "The receipt for a sponge cake: "`
- `sh serve.sh --model ./models/Wizard-Vicuna-7B-Uncensored.Q5_K_M.gguf`
- `sh pack.sh -m ./models/orca-2-13b-alpaca-uncensored.gguf.q4_k_m.bin`
- `sh pack.sh --model orca-2-13b-alpaca-uncensored.gguf.q4_k_m.bin`

## Credits

- [Mozilla-Ocho/llamafile](https://github.com/Mozilla-Ocho/llamafile)
- [ggerganov/llama.cpp](https://github.com/ggerganov/llama.cpp)
