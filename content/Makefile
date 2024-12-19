.PHONY: all img publish

all: img publish

img:
	make -C img

publish:
	cp -r pages pages-tmp
	find pages-tmp -type f -name '*.org' \
		-exec sh -c 'printf "#+HTML: <nav class=\"sidebar\">\n#+INCLUDE: \"%s/pages-tmp/sitemap.org\" :lines \"3-\"\n#+HTML: </nav>\n" $$1 >> $$2' _ $(CURDIR) {} \;
	emacs	--quick --batch \
		--load 'publish.el' \
		--file pages-tmp/index.org \
		--eval '(org-publish-current-project t)'
	rm -rf pages-tmp
	rm -f ../public/sitemap.html
