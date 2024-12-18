.PHONY: all img publish

all: img publish

img:
	make -C img

publish:
	emacs	--quick --batch \
		--load 'publish.el' \
		--file pages/index.org \
		--eval '(org-publish-current-project t)'
	rm -f ../public/sitemap.html
