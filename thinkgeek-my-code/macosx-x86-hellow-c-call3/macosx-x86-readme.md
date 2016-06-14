###couple of issues under mac os x (not ubuntu I guess

1. nasm need to update to higher as the OS X comes with 0.98 no 64 bit support
	(download from nasm latest non-rc version is 2.12.01)

2. use start not _start (the convention in gcc or ... but not mac os x)

3. need to use AS-OPT = -fmacho64 for nasm

4. need to use LD-OPT = -macosx_version_min 10.7.0

5. not using cross just use local still use cross to get the path right

6. the system call is different!!! 

###reference

1. https://lord.io/blog/2014/assembly-on-osx/
2. https://gist.github.com/FiloSottile/7125822
3. http://cs.lmu.edu/~ray/notes/nasmtutorial/
