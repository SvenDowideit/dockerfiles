default: update
	docker build -t buildroot-iso .
	docker run --rm buildroot-iso > buildroot.iso

update:
	wget -c http://buildroot.org/downloads/buildroot-2014.11.tar.gz
	echo "run make oldconfig?"
