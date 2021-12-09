FROM fangzhengjin/paddlehub:2.2.1
LABEL maintainer "fangzhengjin <fangzhengjin@gmail.com>"

RUN install_packages g++ libglib2.0-0 libsm6 libxrender1 libxext6 && \
wget -P /app https://github.com/PaddlePaddle/PaddleOCR/archive/refs/tags/v2.1.1.tar.gz && \
tar xzf /app/v2.1.1.tar.gz -C /app/ && cp /app/PaddleOCR-2.1.1/* /app/ -rf && rm -rf /app/PaddleOCR-2.1.1 /app/v2.1.1.tar.gz && \
pip3.7 install -r requirements.txt && rm -rf /root/.cache/* && \
wget -P /app/inference https://paddleocr.bj.bcebos.com/dygraph_v2.0/ch/ch_ppocr_mobile_v2.0_rec_infer.tar && \
tar xf /app/inference/ch_ppocr_mobile_v2.0_rec_infer.tar -C /app/inference/ && rm -rf /app/inference/ch_ppocr_mobile_v2.0_rec_infer.tar && \
hub install /app/deploy/hubserving/ocr_rec/

EXPOSE 9000

CMD ["/bin/bash","-c","hub serving start --modules ocr_rec -p 9000"]
