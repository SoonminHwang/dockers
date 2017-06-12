# Repository for dockerfiles
---

0. cuda-caffe-matlab

		Ubuntu 14.04 + cuda 8.0 + cudnnv5 + caffe/matlab dependencies

0. matlab-anaconda-cuda7.0-cudnn4

		Ubuntu 14.04 + cuda7.0 + cudnnv4 + matlab dependencies + anaconda

0. PSPNet: based on "matlab-anaconda-cuda7.0-cudnn4"

		caffe dependencies

0. MXNet for Resnet-38 segmentation [[Link](https://github.com/itijyou/ademxapp)]

		Ubuntu 14.04 + cuda 8.0 + cudnnv5.1 + mxnet


# Usage
---

## Pull docker image
0. Choose one of these [IMAGE_NAME]: cuda-caffe-matlab, matlab-anaconda-cuda7.0-cudnn4, pspnet, mxnet

		docker pull soonminh/IMAGE_NAME


## Or Build Docker image on your machine

0. Preparation: generate Dockerfile with name

		./make_dockerfile.sh matlab-anaconda-cuda7.0-cudnn4

0. matlab-anaconda-cuda7.0-cudnn4

		docker build -t soonminh/baseenv:mat-py-cuda7.0-cudnn4 matlab-anaconda-cuda7.0-cudnn4/


## Run docker image

0. To use gui interface,
	- Use follow options:

			-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
			-e DISPLAY=$DISPLAY


0. To use matlab in docker container,
	- Specify several variables (modify follows depending on your MATLAB version & mac address)

			export MATLAB_ROOT=/usr/local/MATLAB/R2015b
			export MATLAB_LOGS=/home/rcvlab/matlab-logs
			export MATLAB_MAC_ADDRESS=11:22:33:44:55:66

	- Use follow options:

			-v "$MATLAB_ROOT":/usr/local/MATLAB/from-host \
			-v "$MATLAB_LOGS":/var/log/matlab \
			--mac-address="$MATLAB_MAC_ADDRESS"

	- For more details, please refer original description (ninjaben/matlab-support)

0. Example

	- My case,

			$ export MATLAB_ROOT=/usr/local/MATLAB/R2015b
			$ export MATLAB_LOGS=/home/rcvlab/matlab-logs
			$ export MATLAB_MAC_ADDRESS=11:22:33:44:55:66

			$ echo 'alias caffematlabos='sudo nvidia-docker run -it -u rcvlab \
					-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
					-e DISPLAY=$DISPLAY \
					-v "$MATLAB_ROOT":/usr/local/MATLAB/from-host \
					-v "$MATLAB_LOGS":/var/log/matlab \
					--mac-address="$MATLAB_MAC_ADDRESS" \
					soonminh/baseenv:mat-py-cuda7.0-cudnn4' >> ~/.bashrc

			$ source ~/.bashrc
			$ caffematlabos

## Tips
	- Use mount in container (connect network drive)
			$ sudo nvidia-docker run -it \
			--cap-add SYS_ADMIN --device /dev/fuse --security-opt apparmor:unconfined $DOCKER_IMAGE_NAME

	- Add your account into sudo group & set password,	
			$ sudo nvidia-docker run -it --name base -u root soonminh/baseenv:mat-py-cuda7.0-cudnn4
			$ adduser USER_NAME sudo
			$ passwd USER_NAME
			$ exit
			$ docker commit base soonminh/baseenv:mat-py-cuda7.0-cudnn4


	- Deprecated (Below procedure is already done in Dockerfile),
			
			$ id (remember id number = USER_ID_NUM)
			$ sudo nvidia-docker run -it -name base -u root soonminh/baseenv:mat-py-cuda7.0-cudnn4
			$ groupadd -r USER_NAME -g USER_ID_NUM
			$ useradd -u USER_ID_NUM -g USER_NAME -m -s /bin/bash USER_NAME
			$ adduser USER_NAME sudo
			$ passwd USER_NAME
			$ docker commit base soonminh/baseenv:mat-py-cuda7.0-cudnn4

	- Set alias,

			$ echo -e alias pspnetos=\"sudo nvidia-docker run -it -u ${USER_NAME} \\n
				\t -v /tmp/.X11-unix:/tmp/.X11-unix:ro \\n
				\t -e DISPLAY=$DISPLAY \\n
				\t -v $MATLAB_ROOT:/usr/local/MATLAB/from-host \\n
				\t -v $MATLAB_LOGS:/var/log/matlab \\n
				\t --mac-address=$MATLAB_MAC_ADDRESS \\n
				\t -v ~/workspace:/home/rcvlab/workspace \\n
	            \t -v /mnt/HDD4TB:/mnt/HDD4TB \\n
	            \t -v /media/rcvlab/New4TB:/media/rcvlab/New4TB \\n
				\t soonminh/pspnet:latest\" >> ~/.bashrc
			$ source ~/.bashrc
