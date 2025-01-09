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

to use gguf after run the docker image, do in the container:

conda install -c huggingface transformers
conda install -c conda-forge ctransformers


conda install pytorch torchvision torchaudio cpuonly -c pytorch
conda install -c conda-forge cmake
pip install --no-cache-dir --force-reinstall --verbose ctransformers
