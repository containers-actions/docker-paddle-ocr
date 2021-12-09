FROM fangzhengjin/paddlehub:2.2.1
LABEL maintainer=fangzhengjin <fangzhengjin@gmail.com>

RUN wget -P /app https://github.com/PaddlePaddle/PaddleOCR/archive/refs/tags/v2.1.1.tar.gz && \
tar xzf /app/v2.1.1.tar.gz -C /app/ && rm -rf tar xzf /app/v2.1.1.tar.gz && \
pip3.7 install -r requirements.txt && rm -rf /root/.cache/* && \
wget -P /app/inference  https://paddleocr.bj.bcebos.com/PP-OCRv2/chinese/ch_PP-OCRv2_rec_infer.tar && \
tar xf /app/inference/ch_PP-OCRv2_rec_infer.tar -C /app/inference/ && rm -rf /app/inference/ch_PP-OCRv2_rec_infer.tar && \
hub install /app/deploy/hubserving/ocr_rec/

EXPOSE 9000

CMD ["/bin/bash","-c","hub serving start --modules ocr_rec -p 9000"]
