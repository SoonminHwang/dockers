FROM soonminh/cuda-caffe:170222

MAINTAINER Soonmin Hwang <smhwang@rcv.kaist.ac.kr>

# This file is based on the dockerfile in ninjaben/matlab-support.
# Matlab dependencies
RUN apt-get update && apt-get install -y \
	libpng12-dev linfreetype6-dev \
	libblas-dev liblapack-dev gfortran build-essential xorg

# run the container like a matlab executable
ENV PATH="/usr/local/MATLAB/from-host/bin:${PATH}"
ENTRYPOINT ["matlab", "-logfile /var/log/matlab/matlab.log"]

# default to matlab help
CMD ["bash"]
CMD ["-h"]
