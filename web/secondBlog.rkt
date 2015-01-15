


#lang web-server/insta

;Uses the concept of dispatchers and handlers

; A blog is a list of posts
; and a post is a struct with a title and a body

;rendering HTML using xexpressions
;(define xexpr/c 
;  (flat-rec-contract 
;    xexpr
;     (or/c string? 
;           (cons/c symbol? (listof xexpr))
;           (cons/c symbol? 
;                   (cons/c (listof (list/c symbol? string?))
;                           (listof xexpr)
;                   )))))


;Make struct a liost of mutable posts
(struct blog (posts) #:mutable)

; Post consist of a title and a body
(struct post (title body))
  
(define firstpost (post "My first post" "This is the body of my first post."))
(define secondpost (post "My second post" "This is the body of my second post."))
(define thirdpost (post "My third post" "This is the body of my third post."))
(define fourthpost (post "My fourth post" "This is the body of my fourth post."))

(define BLOG (list firstpost secondpost thirdpost fourthpost))

;blog-insert-posts! : (blog? (listof post?) . -> . void
(define (blog-insert-posts! a-blog a-post)
  (set-blog-posts! a-blog
                   (cons a-post (blog-posts a-blog))))
 

;Main entry point for request processing
;Starts rendering all list items in BLOG.

(define (start request)
  (render-blog-page BLOG request))

;render-blog-page: blog request -> response
;Consumes a blog and a request and produces an HTML page
;of all the content in the blog.
(define (render-blog-page a-blog request)
  (local [(define (response-generator embed/url)
      (response/xexpr 
        `(html (head (title "MyBlog"))
           (body (h1 "My Blog")
                 ,(render-posts a-blog)
                (form ((action
                         ,(embed/url insert-post-handler)))
                  (input ((name "title")))
                  (input ((name "body")))
                  (input ((type "submit"))))))))
          
          (define (insert-post-handler request)
             (render-blog-page
               (cons (parse-post (request-bindings request))
                     a-blog)
              request))]
    (send/suspend/dispatch response-generator)))

;render-greeting string -> response
;consumes a name, and produces a dynamic content

(define (render-greeting a-name)
  (response/xexpr
    `(html (head (title "Welcome"))
           (body (p ,(string-append "Hello " a-name))))
  )
)

; render-post post -> string
; consumes a post and returns a x-expression representing the content.
; Here is a sample input and output from render-post
; (render-post (post "First Post." "This is my second post"))
; '(div ((class "post")) "Firsdt post!" (p "This is a firsdt post."))

(define (render-post a-post)
     `(div ((class "post")) 
       ,(post-title a-post) 
       (p ,(post-body a-post))))
  
;render-as-itemized-list: (listof expr) -> xexpr
;consumes a list of iteemsd and produces a rendering 
;as an unordered list.
(define (render-as-itemized-list a-fragments)
        `(ul ,@(map render-as-item a-fragments)))

;render-as-item: xexpr -> xexpr
;Consumes a xexpr and produces a rendering
; as a list item
(define (render-as-item a-fragment)
  `(li a-fragment))

;render-posts: list-of-posts -> xexpr
;Consumes a list of posts and produces an xexpr for the content
;As examples
; (render-posts empty) should return '(div ((class "posts")))
;
;(render-posts (list (post "Post 1" "Body 1")
;                    (post "Post 2" "Body 2")))
;
; '(div ((class "posts"))
;      (div ((class "post")) "Post 1" (p "Body 1"))
;      (div ((class "post")) "Post 2" (p "Body 2")))

(define (render-posts a-blog)
   `(div ((class "posts"))
         ,@(map render-post a-blog)))


;can-parse-post:  (bindings ? -> . boolean?)
;can-parse-post? that consumes a set of bindings. It produces #t if there
;exist bindings both for the symbols 'title and 'body, and #f otherwise.
(define (can-parse-post? bindings)
  (and (exists-binding? 'title bindings)
       (exists-binding? 'body bindings))
)

;parse-post:(bindings? . -> . post?)
;that consumes a set of bindings. Assuming that the bindings structure 
;has values for the symbols 'title and 'body, parse-post should produce a post containing those values.
(define (parse-post bindings)
  (post (extract-binding/single 'title bindings)
        (extract-binding/single 'body bindings)))


