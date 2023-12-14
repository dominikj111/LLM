# LLAMAFILE DOCKER GENERATOR

Just my humgle effort to automate the generation of a Llamafile for anybody

I've tested successfully:
[orca-2-13b-alpaca-uncensored.gguf.q4_k_m.bin](https://huggingface.co/athirdpath/Orca-2-13b-Alpaca-Uncensored)
[orca-2-13b-alpaca-uncensored.gguf.q8_0.bin](https://huggingface.co/athirdpath/Orca-2-13b-Alpaca-Uncensored)
[tinyllama-1.1b-chat-v0.3.Q2_K.gguf](https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v0.3-GGUF)
[Wizard-Vicuna-7B-Uncensored.Q5_K_M.gguf](https://huggingface.co/TheBloke/Wizard-Vicuna-7B-Uncensored-GPTQ)
[mixtral-8x7b-v0.1.Q4_K_M.gguf](https://huggingface.co/TheBloke/Mixtral-8x7B-v0.1-GGUF)

All works very nicely (not all are quick models) and it is very easy to start building own project upon it.

There is only **single requirement**, what is the Docker.

## How to use

- First to do is to build a container by `sh build.sh` command.
- To play with the basic model (tinyllama-1.1b-chat-v0.3.Q2_K.gguf), do `sh run.sh`, where the question is "What is the best way to build a robot?" (see the `run.sh` file).
- To generate single executable web server, do `sh pack.sh`.

## How to change the model

Download the model and place into the `./models` folder. Then change the model name in the `pack.sh` and `./outoput/.args`.

## Before generating executable

Play with parameters and questions in the `run.sh` file. I would also recomend to serve the web application by the `llamafile-server` command, where requested args may go into the `./outoput/.args` file.
