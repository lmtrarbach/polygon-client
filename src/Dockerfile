FROM python:3.9-slim

COPY polygon-web3-client /app/polygon-web3-client
RUN pip install web3 pyyaml
WORKDIR /app/polygon-web3-client
CMD ["python", "polygon_client.py"]