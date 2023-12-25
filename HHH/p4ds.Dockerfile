# Use an NVIDIA CUDA base image compatible with your CUDA toolkit version
# FROM nvidia/cuda:11.1.1-cudnn8-runtime-ubuntu20.04 
# 런타임 이미지: 이러한 이미지(nvidia/cuda:11.1.1-cudnn8-runtime-ubuntu20.04와 같은 태그 이름의 runtime)에는 CUDA 런타임 환경이 포함, CUDA가 필요한 애플리케이션을 실행하는 데 적합하지만 'nvcc' 컴파일러와 같은 CUDA 개발 도구는 포함되어 있지 않습니다.
FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04

# Avoid interactive dialogue from apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies and Miniconda
RUN apt-get update && apt-get install -y \
    wget \
    build-essential \
    cmake \
    gcc \
    g++ \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgtk2.0-dev && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /miniconda.sh && \
    bash /miniconda.sh -b -p /opt/conda && \
    rm /miniconda.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Reset DEBIAN_FRONTEND environment variable
ENV DEBIAN_FRONTEND=

# Add Conda to PATH
ENV PATH=/opt/conda/bin:$PATH
ENV CUDA_HOME=/usr/local/cuda

# Diagnostic command to check NVCC version
RUN nvcc --version

# Set the working directory
WORKDIR /usr/src/app

# Copy the current directory contents and environment file
COPY . /usr/src/app/
COPY environment.yml /usr/src/app/

# Create the Conda environment
RUN conda env create -f environment.yml

# Make RUN commands use the new environment
SHELL ["conda", "run", "-n", "tmp", "/bin/bash", "-c"]

# Check if Flask is installed
RUN echo "Make sure flask is installed:"
RUN python -c "import flask"

# Run app.py when the container launches
CMD ["conda", "run", "--no-capture-output", "-n", "tmp", "python", "app.py"]