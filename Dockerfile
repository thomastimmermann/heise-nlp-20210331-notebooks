FROM tensorflow/tensorflow:latest-gpu-jupyter
RUN pip3 install torch==1.6.0
RUN pip3 install transformers==3.0.2
RUN pip3 install matplotlib seaborn altair tqdm mlflow jupyterlab spacy sklearn
WORKDIR /notebooks
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
