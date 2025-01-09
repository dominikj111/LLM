to use gguf after run the docker image, do in the container:

conda install -c huggingface transformers
conda install -c conda-forge ctransformers


conda install pytorch torchvision torchaudio cpuonly -c pytorch
conda install -c conda-forge cmake
pip install --no-cache-dir --force-reinstall --verbose ctransformers