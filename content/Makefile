.PHONY: all img publish

all: img publish

img:
	make -C img

publish: pages/about.org
	emacs	--quick --batch \
		--load 'publish.el' \
		--file $< \
		--eval '(org-publish-current-project t)'
