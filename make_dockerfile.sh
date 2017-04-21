#!/bin/bash
id | awk -F"[=()]" '{print "export USER_ID="$2}' >> tmp.sh && source tmp.sh && rm tmp.sh
id | awk -F"[=()]" '{print "export USER_NAME="$3}' >> tmp.sh && source tmp.sh && rm tmp.sh

if [ "$1" == "matlab-anaconda-cuda7.0-cudnn4" ]; then
	DOCKERFILE="FROM nvidia/cuda:7.0-cudnn4-devel-ubuntu14.04 \n
	MAINTAINER Soonmin Hwang <smhwang@rcv.kaist.ac.kr> \n
	\n
	# 0. INSTALL Basic settings \n
	RUN apt-get update \n
	RUN apt-get install -y vim git build-essential \n
	\n
	# 1. MATLAB Setting \n
	# This file is based on the dockerfile in ninjaben/matlab-support. \n
	RUN apt-get install -y \ \n
		\t libpng12-dev libfreetype6-dev \ \n
		\t libblas-dev liblapack-dev gfortran build-essential xorg \n
	\n
	# run the container like a matlab executable \ \n
	ENV PATH=\"/usr/local/MATLAB/from-host/bin:\${PATH}\" \n
	\n
	RUN groupadd -r $USER_NAME -g $USER_ID && \ \n
		\t useradd -u $USER_ID -g $USER_NAME -m -s /bin/bash $USER_NAME && \ \n
		\t echo 'cd ~' >> /home/$USER_NAME/.bashrc \n
	\n
	# 2. Anaconda \n
	# From https://github.com/ContinuumIO/docker-images/blob/master/anaconda/Dockerfile \n
	RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \ \n
		\t libglib2.0-0 libxext6 libsm6 libxrender1 \ \n
		\t git mercurial subversion \n
	\n
	RUN echo 'export PATH=/home/$USER_NAME/anaconda2/bin:\${PATH}' > /etc/profile.d/conda.sh && \ \n
		\t wget --quiet https://repo.continuum.io/archive/Anaconda2-4.3.1-Linux-x86_64.sh -O /home/$USER_NAME/anaconda.sh && \ \n
		\t /bin/bash /home/$USER_NAME/anaconda.sh -b -p /home/$USER_NAME/anaconda2 && \ \n
		\t rm /home/$USER_NAME/anaconda.sh && chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/anaconda2 \n
	\n
	RUN echo 'export PATH=/home/$USER_NAME/anaconda2/bin:\$PATH' >> /home/$USER_NAME/.bashrc \n
	RUN echo 'export LD_LIBRARY_PATH=/home/$USER_NAME/anaconda2/lib:\${LD_LIBRARY_PATH}' >> /home/$USER_NAME/.bashrc \n
	\n
	RUN [\"/bin/bash\"]"

	echo -e $DOCKERFILE>matlab-anaconda-cuda7.0-cudnn4/Dockerfile

elif [ "$1" == "cuda-caffe-matlab" ]; then
	DOCKERFILE="FROM soonminh/cuda-caffe:170222 \n
		\n
		MAINTAINER Soonmin Hwang <smhwang@rcv.kaist.ac.kr> \n
		\n
		# This file is based on the dockerfile in ninjaben/matlab-support. \n
		# Matlab dependencies \n
		RUN apt-get update && apt-get install -y \ \n
			\t libpng12-dev libfreetype6-dev \ \n
			\t libblas-dev liblapack-dev gfortran build-essential xorg \n
		\n
		# run the container like a matlab executable \n
		ENV PATH=\"/usr/local/MATLAB/from-host/bin:\${PATH}\" \n
		\n
		RUN [\"/bin/bash\"]"

	echo -e $DOCKERFILE>cuda-caffe-matlab/Dockerfile

elif [ "$1" == "pspnet" ]; then
	DOCKERFILE="FROM soonminh/baseenv:mat-py-cuda7.0-cudnn4\n
		\n
		MAINTAINER Soonmin Hwang <smhwang@rcv.kaist.ac.kr>\n
		\n
		# 0. INSTALL Caffe dependencies\n
		RUN apt-get update \n
	 	RUN apt-get install -y \ \n
	 		\t libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler \n
	 	RUN apt-get install -y --no-install-recommends libboost-all-dev \n
	 	RUN apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev \n
	 	RUN apt-get install -y libatlas-base-dev libopenblas-dev \n
	 	\n
		# 1. Clone PSPNet repository\n
		RUN git clone https://github.com/hszhao/PSPNet.git /home/$USER_NAME/PSPNet && \ \n
			\t chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/PSPNet\n
		\n
		RUN [\"/bin/bash\"]"

	echo -e $DOCKERFILE>PSPNet/Dockerfile

else
	echo "Unknown dockerfile."
fi

