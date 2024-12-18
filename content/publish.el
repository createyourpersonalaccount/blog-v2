(defvar blog-prefix (or (getenv "BLOG_PREFIX") ""))
(setq enable-local-variables :all)
(setq org-publish-project-alist
      `(("blog"
         :components ("blog-pages" "blog-assets"))
        ("blog-pages"
         :author "Nikolaos Chatzikonstantinou"
         :with-email t
         :email "nchatz314@gmail.com"
         :time-stamp-file nil
         :html-metadata-timestamp-format "%Y-%m-%d %a"
         :html-head ,(format "<link rel=\"stylesheet\" href=\"%s/css/style.css\">" blog-prefix)
         :html-mathjax-options ((path ,(format "%s/mathjax/tex-chtml.js" blog-prefix)))
         :html-validation-link ""
         :html-head-include-default-style nil
         :html-head-include-scripts nil
         :base-directory "."
         :base-extension "org"
         :recursive t
         :auto-sitemap t
         :sitemap-format-entry
         (lambda (entry sitemap-style project)
           (let ((title (org-publish-find-title entry project))
                 (date (org-publish-find-date entry project))
                 (has-date (zerop
                            (call-process "awk" nil nil nil
                                         "NR<=10 && /^#\\+DATE:/ {f=1} END {exit !f}"
                                         entry))))
             (if (file-directory-p entry)
                 (capitalize entry)
               (format "[[./%s][%s]]%s"
                       entry title
                       (if has-date
                           (format-time-string ", %Y-%m-%d %a" date)
                         "")))))
         :publishing-function org-html-publish-to-html
         :publishing-directory "../../public")
        ("blog-assets"
         :base-directory "../assets"
         :base-extension ".*"
         :recursive t
         :publishing-function org-publish-attachment
         :publishing-directory "../../public")))
