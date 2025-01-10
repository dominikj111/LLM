# JupyterLab Environment

A dockerized JupyterLab environment with package management support.

## Package Management

### Installing Packages in Bash
When connected to the container via bash:
```bash
docker exec -it myjupyterlab bash
pip install <package_name>
```

### Installing Packages in Jupyter Notebooks
In a Jupyter notebook cell:
```python
!/opt/miniconda3/bin/pip install <package_name>
```

Note: Always use the full path to conda's pip (`/opt/miniconda3/bin/pip`) when installing packages from Jupyter notebooks to avoid system package management restrictions.





--------------- other notes ----------------

To use gguf after run the docker image, do in the container:

After build and serve, run these to be able to run the ipynb document.

python3 -m pip install tensorflow
<!-- python3 -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))" -->
<!-- pip install flax -->
<!-- pip3 install torch torchvision -->
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
pip install transformers
<!-- pip install 'transformers[torch]' -->
<!-- python -c "from transformers import pipeline; print(pipeline('sentiment-analysis')('we love you'))" -->
pip install tf-keras
<!-- python -c "from transformers import pipeline; print(pipeline('sentiment-analysis')('we love you'))" -->
pip install gguf
<!-- python -c "import torch; import gguf" -->
<!-- pip3 install torch torchvision -->

---------------

Recommendations for Speed Optimization
1. Use GPU for Inference

If your Apple M3 Pro supports GPU computation and you have the appropriate drivers, configure your container to utilize the GPU. You'll need to:

    Ensure the Docker container can access the GPU (e.g., using --gpus all in the docker run command).
    Use a library like transformers with torch compiled for GPU (install via pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118).

2. Optimize CPU Usage

If GPU isn't an option:

    Increase the CPU limit for the container. Even adding 1-2 more cores can significantly improve performance for parallelizable tasks.
    Use libraries like ONNX Runtime or TensorRT to accelerate inference on the CPU. You can convert your model to an ONNX format.