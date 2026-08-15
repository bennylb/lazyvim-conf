; extends

; kdl (restored)
(
  (comment) @lang
  (#eq? @lang "# kdl")
  .
  (indented_string_expression) @injection.content
  (#set! injection.language "kdl")
)

; tmux
(
  (comment) @lang
  (#any-of? @lang "# tmux" "# tmux.conf")
  .
  (indented_string_expression) @injection.content
  (#set! injection.language "tmux")
)
