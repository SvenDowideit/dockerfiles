
serve:
	docker rm -f resume
	# consider the 'clean', 'kendall' and 'spartacus' themes
	docker run -dit --name resume \
		-v $(CURDIR):/data/ \
		-p 4000:4000 svendowideit/jsonresume serve --theme spartacus

run:
	docker run --rm -it -v $(CURDIR):/data/ svendowideit/jsonresume

build:
	docker build -t svendowideit/jsonresume .
