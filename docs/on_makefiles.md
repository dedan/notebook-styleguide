# Makefiles

When we work with external datasets we often have to execute several steps of processing before we can work with them. I just recently had a case, working with geodata, where I downloaded shapefiles, unzipped them, converted them to GeoJSON while filtering on a property and in the end converted everything to TopoJSON. Already a day later I had no idea what were all the steps to create my dataset that I plotted. Then I remembered that Mike Bostock, the creator of D3, often uses Makefiles in his examples and even wrote an article about why we should use them.

* they automate the data processing workflow
* and at the same time document what we did

[Here](Makefile) is the example of a makefile I used to do all the steps described above. If I now want to recreate my dataset from scratch (even including the download), I just have to run make clean and make all. To try it out, save this script in a file called Makefile and call make all in the same folder.

It basically describes a few steps that depend on each other.