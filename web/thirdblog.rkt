#lang web-server/insta

#|*************************************************************************************
  
 Third - more refined blog application.

  Seeing all the posts and comments on one page may be a bit overwhelming, 
  so maybe we should hold off on showing the comments on the main blog page. 
  Instead, let’s make a secondary “detail” view of a post and present its comments there. 
  Accordingly, the top-level view of a blog will show only the title and body of a post, 
  and the number of its comments.

***************************************************************************************|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; BASIC MODEL of a Blog
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; A blog is a structure (blog posts)
; where posts is a list of mutable post.
(struct blog (posts) #:mutable)

; and the post is a (post title bodt and list(comment))
(struct post (title body comments) #:mutable)

; The initial blog structure
; BLOG: blog
; The initial BLOG.
(define BLOG
  (blog
   (list (post "Second Post"
               "This is another post"
               (list))
         (post "First Post"
               "This is my first post"
               (list "First comment!")))))


; blog-insert-post!: blog-post -> void
; Consumes a blog and a post, adds the post to the top of the blog.
(define (blog-insert-post! a-blog a-post)
  set-blog-posts! a-blog
          (cons a-post (blog-posts a-blog)))


; post-insert-comment!: post string -> void
; Consumes a post and a comment. It appends the post to the 
; list of comments in the post.
(define (post-insert-comment! a-post a-comment)
  (set-post-comments! 
     a-post
     (append (post-comments a-post) (list a-comment))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; main request propcessing function
; start: request -> doesn't return
; consumes a request and produces a page that displays all the web
; content
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (start request)
  (render-blog-page request))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; All blog rendering functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Page Handlers
;================

; render-blog-page: request -> void
; produces an HTML page from the contents of BLOG
(define (render-blog-page request)
  (local [(define (response-generator embed/url)
            (response/xexpr
              `(html (head (title "My test Blog"))
                     (body (hi "My Test Blog")
                           ,(render-posts embed/url)
                           (form ((action ,(embed/url insert-post-handler)))
                                 (input ((name "title")))
                                 (input ((name "body")))
                                 (input ((type "submit"))))))))
          ; parse-post: bindings -> post
          ; Extracts a post out of the bindings
          (define (parse-post bindings)
            (post (extract-binding/single 'title bindings)
                  (extract-binding/single 'body bindings)
                  (list)))
          
          ; Inserts the post handler
          (define (insert-post-handler request)
            (blog-insert-post!
              BLOG (parse-post (request-bindings request)))
            (render-blog-page request))]
    
   (send/suspend/dispatch response-generator)))

; render-post-detail-page: post request -> doesn't return
; Consumes a post and request, and produces a detail page
; of the post. The user will be able to insert new comments.
(define (render-post-detail-page a-post request)
  (local [(define (response-generator embed/url)
            (response/xexpr
             `(html (head (title "Post Details"))
                    (body
                     (h1 "Post Details")
                     (h2 ,(post-title a-post))
                     (p ,(post-body a-post))
                     ,(render-as-itemized-list
                       (post-comments a-post))
                     (form ((action
                             ,(embed/url insert-comment-handler)))
                           (input ((name "comment")))
                           (input ((type "submit"))))))))
 
          (define (parse-comment bindings)
            (extract-binding/single 'comment bindings))
 
          (define (insert-comment-handler a-request)
            (post-insert-comment!
             a-post (parse-comment (request-bindings a-request)))
            (render-post-detail-page a-post a-request))]
 
 
    (send/suspend/dispatch response-generator)))
 
; render-posts: (handler -> string) -> xexpr
; Consumes a embed/url, and produces an xexpr fragment
; of all its posts.
(define (render-posts embed/url)
  (local [ (define (render-post/embed/url a-post)
             (render-post a-post embed/url))]
    `(div ((class "posts")
            ,@(map render-post/embed/url (blog-posts BLOG))))))

; render-post: post (handler -> string) -> xexpr
; Consumes a post, produces an xexpr fragment of the post.
; The fragment contains a link to show a detailed view of the post.
(define (render-post a-post embed/url)
 (local[(define (view-post-handler request)
          (render-post-detail-page a-post request))]
   `(div ((class "post"))
         (a ((href ,(embed/url view-post-handler)))
            ,(post-title a-post))
         (p ,(post-body a-post))
         `(div ,(number->string (length (post-comments a-post)))
              " comment(s)"))))

; render-as-itemized-list: (listof xexpr) -> xexpr
; Consumes a list of items, and produces a rendering as
; an unorderered list.
(define (render-as-itemized-list fragments)
  '(ui ,@(map render-as-item fragments)))


; render-as-item: xexpr -> xexpr
; Consumes an xexpr, and produces a rendering
; as a list item.
(define (render-as-item a-fragment)
  `(li ,(a-fragment)))





