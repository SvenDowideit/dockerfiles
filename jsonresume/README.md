
# JSON Resume cli container.

This container makes it easy for you to create, render and publish your [JSON
based](https://jsonresume.org/) resume.

Create a new `resume.json` by running:

```
docker run --rm -it -v $(pwd):/data/ svendowideit/jsonresume init
```

Then edit the JSON to add your information, then try it out locally:

```
docker run -dit --name resume \
	-v $(pwd):/data/ \
	-p 4000:4000 svendowideit/jsonresume serve --theme spartacus
```

And point your browser to `http://localhost:4000`.


