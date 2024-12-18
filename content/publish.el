(setq enable-local-variables :all)
(setq org-publish-project-alist
      '(("blog"
         :components ("blog-pages" "blog-assets"))
        ("blog-pages"
         :author "Nikolaos Chatzikonstantinou"
         :with-email t
         :email "nchatz314@gmail.com"
         :time-stamp-file nil
         :html-metadata-timestamp-format "%Y-%m-%d %a"
         :html-head "<link rel=\"stylesheet\" href=\"/css/style.css\">"
         :html-mathjax-options ((path "mathjax/tex-chtml.js"))
         :html-validation-link ""
         :base-directory "."
         :base-extension "org"
         :recursive t
         :auto-sitemap t
         :sitemap-filename "index.org"
         :publishing-function org-html-publish-to-html
         :publishing-directory "../../public")
        ("blog-assets"
         :base-directory "../assets"
         :base-extension ".*"
         :recursive t
         :publishing-function org-publish-attachment
         :publishing-directory "../../public")))
