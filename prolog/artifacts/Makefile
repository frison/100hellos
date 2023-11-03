install:
	git clone https://github.com/SWI-Prolog/swipl-devel.git
	cd swipl-devel && git submodule update --init
	mkdir -p swipl-devel/build
	cd swipl-devel/build && cmake -DCMAKE_INSTALL_PREFIX=$HOME -DCMAKE_BUILD_TYPE=PGO -G Ninja ..
	cd swipl-devel/build && ninja
	cd swipl-devel/build && ninja install
	sudo cp /artifacts/swipl-devel/build/src/swipl /usr/local/bin
