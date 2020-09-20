static:
	rm -rf vendor/tidy-html5
	git clone https://github.com/htacg/tidy-html5 -b 5.6.0 --depth=1 --single-branch vendor/tidy-html5
	sh build.sh
