FROM python:3.8.2


WORKDIR /root

COPY . /root

RUN pip install -r requirements.txt

# Install kubectl 
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


# Install GCLOUD SDK 
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y
      

EXPOSE 8888 8000
# ENTRYPOINT ["/bin/bash"]
# CMD ["jupyter", "lab","--ip=0.0.0.0","--allow-root"]
CMD ["jupyter", "notebook","--ip=0.0.0.0","--allow-root"]