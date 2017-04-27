FROM mxnet/python:gpu
 
 MAINTAINER Soonmin Hwang <smhwang@rcv.kaist.ac.kr>
 
 # 0. Add my account
 RUN groupadd -r rcvlab -g 1000 && \ 
 	 useradd -u 1000 -g rcvlab -m -s /bin/bash rcvlab && \ 
 	 echo 'cd ~' >> /home/rcvlab/.bashrc 
 
 # 1. INSTALL Basic things
 RUN apt-get update 
 RUN apt-get install -y git vim sudo build-essential
 
 RUN ["/bin/bash"]
