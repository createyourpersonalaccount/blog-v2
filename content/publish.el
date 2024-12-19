(defvar blog-prefix (or (getenv "BLOG_PREFIX") ""))
(defun format-dir-nav-sidebar (entry)
  "Format a directory for the navigation sidebar"
  (capitalize (replace-regexp-in-string "-" " " entry)))
(defun format-blog-entry-nav-sidebar (entry project)
  "Format a blog entry for the navigation sidebar"
  (let ((title (org-publish-find-title entry project))
        (date (org-publish-find-date entry project))
        (has-date (zerop
                   (call-process "awk" nil nil nil
                                 "NR<=10 && /^#\\+DATE:/ {f=1} END {exit !f}"
                                 entry))))
    (format "[[./%s][%s]]%s"
            entry title
            (if has-date
                (format-time-string ", %Y-%m-%d %a" date)
              ""))))
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
         :html-divs ((preamble "header" "preamble")
                     (content "main" "content")
                     (postamble "footer" "postamble"))
         :base-directory "."
         :base-extension "org"
         :recursive t
         :auto-sitemap t
         :sitemap-format-entry
         (lambda (entry sitemap-style project)
           (if (file-directory-p entry)
               (format-dir-nav-sidebar entry)
             (format-blog-entry-nav-sidebar entry project)))
         :publishing-function org-html-publish-to-html
         :publishing-directory "../../public")
        ("blog-assets"
         :base-directory "../assets"
         :base-extension ".*"
         :recursive t
         :publishing-function org-publish-attachment
         :publishing-directory "../../public")))
