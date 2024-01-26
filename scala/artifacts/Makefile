install:
	curl -fL https://github.com/coursier/coursier/releases/download/v2.1.8/cs-x86_64-pc-linux.gz | gzip -d > cs && chmod +x cs
	# Coursier doesn't work with musl libc, so we need to use gcompat in alpine
	./cs setup --install-dir /usr/local/bin