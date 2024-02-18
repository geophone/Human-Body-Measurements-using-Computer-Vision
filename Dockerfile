FROM python:3.7
RUN apt-get update
RUN apt-get install -y curl git 
RUN python -m pip install --upgrade pip
RUN apt-get -y install libglfw3 build-essential cmake
RUN apt-get -y install libglu1-mesa libglu1-mesa-dev libosmesa6-dev libosmesa6

WORKDIR /app/
RUN wget https://github.com/farazBhatti/Human-Body-Measurements-using-Computer-Vision/archive/refs/heads/master.zip
RUN unzip master.zip

WORKDIR /app/Human-Body-Measurements-using-Computer-Vision-master/
RUN wget wget https://people.eecs.berkeley.edu/~kanazawa/cachedir/hmr/models.tar.gz && tar -xf models.tar.gz
COPY ./requirements.txt .
RUN pip install numpy
RUN pip install opendr
RUN pip install vtk==8.1.2
RUn pip install mayavi==4.7.1
RUN pip install -r requirements.txt
COPY ./data data/
COPY ./models models/
COPY image1.png .
COPY image2.png .
#incompatibility binary lvl
RUN pip install --upgrade numpy 
CMD PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python python inference.py -i image1.png -ht 165 && PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python python inference.py -i image2.png -ht 175

