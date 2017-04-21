FROM nvidia/cuda:7.0-cudnn4-devel-ubuntu14.04 
 MAINTAINER Soonmin Hwang <smhwang@rcv.kaist.ac.kr> 
 
 # 0. INSTALL Basic settings 
 RUN apt-get update 
 RUN apt-get install -y vim git build-essential 
 
 # 1. MATLAB Setting 
 # This file is based on the dockerfile in ninjaben/matlab-support. 
 RUN apt-get install -y \ 
 	 libpng12-dev libfreetype6-dev \ 
 	 libblas-dev liblapack-dev gfortran build-essential xorg 
 
 # run the container like a matlab executable \ 
 ENV PATH="/usr/local/MATLAB/from-host/bin:${PATH}" 
 
 RUN groupadd -r rcvlab -g 1000 && \ 
 	 useradd -u 1000 -g rcvlab -m -s /bin/bash rcvlab && \ 
 	 echo 'cd ~' >> /home/rcvlab/.bashrc 
 
 # 2. Anaconda 
 # From https://github.com/ContinuumIO/docker-images/blob/master/anaconda/Dockerfile 
 RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \ 
 	 libglib2.0-0 libxext6 libsm6 libxrender1 \ 
 	 git mercurial subversion 
 
 RUN echo 'export PATH=/home/rcvlab/anaconda2/bin:${PATH}' > /etc/profile.d/conda.sh && \ 
 	 wget --quiet https://repo.continuum.io/archive/Anaconda2-4.3.1-Linux-x86_64.sh -O /home/rcvlab/anaconda.sh && \ 
 	 /bin/bash /home/rcvlab/anaconda.sh -b -p /home/rcvlab/anaconda2 && \ 
 	 rm /home/rcvlab/anaconda.sh && chown -R rcvlab:rcvlab /home/rcvlab/anaconda2 
 
 RUN echo 'export PATH=/home/rcvlab/anaconda2/bin:$PATH' >> /home/rcvlab/.bashrc 
 RUN echo 'export LD_LIBRARY_PATH=/home/rcvlab/anaconda2/lib:${LD_LIBRARY_PATH}' >> /home/rcvlab/.bashrc 
 
 RUN ["/bin/bash"]
