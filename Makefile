build:
	mkdir -p quqrantine_dir
	chmod +x antivirusd.sh restore.sh

run: build
	./antivirusd.sh test_dir quqrantine_dir 3

restore: build
	./restore.sh test_dir quqrantine_dir

clean:
	rm -rf quqrantine_dir directory-info.last directory-info.new