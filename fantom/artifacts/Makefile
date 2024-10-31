PREFIX ?= /usr/local

.PHONY: install

# This is the only necessary target in the Makefile
# and it's expected to place the language interpretter
# or compiler in the path.
install:
	curl -o fantom.zip -L https://github.com/fantom-lang/fantom/releases/download/v1.0.80/fantom-1.0.80.zip
	unzip fantom.zip -d fantom
	mv fantom/fantom-1.0.80 rel
	chmod +x rel/bin/*
	rm -rf fantom && rm -f fantom.zip
	echo -e "\n\njdkHome=$$JAVA_HOME/\ndevHome=/artifacts/fan/\n" >> rel/etc/build/config.props
	git clone --depth=1 https://github.com/fantom-lang/fantom fan
	echo -e "\n\njdkHome=$$JAVA_HOME/" >> fan/etc/build/config.props
	rel/bin/fan fan/src/buildall.fan superclean
	rel/bin/fan fan/src/buildboot.fan compile
	fan/bin/fan fan/src/buildpods.fan compile
