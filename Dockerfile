FROM mcr.microsoft.com/azureml/onnxruntime:v1.3.0-cuda10.1-cudnn7
COPY . /TrWebOCR
RUN sed -i 's#http://deb.debian.org#https://mirrors.163.com#g' /etc/apt/sources.list \
    && apt update || true && apt install -y libglib2.0-dev libsm6 libxrender1 libxext-dev supervisor build-essential \
    && rm -rf /var/lib/apt/lists/*
RUN python -m pip install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip install -r /TrWebOCR/requirements.txt -i https://mirrors.aliyun.com/pypi/simple/ \
    && python /TrWebOCR/install.py
EXPOSE 8089
CMD ["supervisord","-c","/TrWebOCR/supervisord.conf"]
