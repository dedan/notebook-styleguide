all: data/bayarea.json

clean:
	rm -rf data/bayarea.json build

build/bayarea_general.zip:
	mkdir -p $(dir $@)
	wget -O $@ 'https://data.sfgov.org/download/ye46-7n65/ZIP'

build/bayarea_general.shp: build/bayarea_general.zip
	rm -rf -- $(basename $@)
	mkdir -p $(basename $@)
	unzip -d $(basename $@) $<
	for file in `find $(basename $@) -type f`; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rm -rf -- $(basename $@)
	touch $@

data/bayarea.json: build/bayarea_general.shp
	ogr2ogr \
	  -f GeoJSON \
	  -t_srs 'EPSG:4326' \
	  data/bayarea.json \
	  build/bayarea_general.shp
