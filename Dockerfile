FROM python:3.6
RUN apt-get update
RUN apt-get install -y build-essential
RUN pip install jupyter numpy matplotlib gym tensorflow
#COPY . .
#WORKDIR slides/
CMD ["mkdir", "home/rl_notebook"]
WORKDIR /home/rl_notebook

# Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

#CMD ["jupyter", "notebook", "/slides/JupyDockerSlides.ipynb","--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root","--NotebookApp.token='pydata'"]
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root","--NotebookApp.token='aiotlab'"]
