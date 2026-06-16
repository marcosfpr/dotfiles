"=============================================================================
" Vimwiki Breadcrumbs. 
"
" Configuration:
" vimwiki_breadcrumbs_include_self (boolean): include link to current page
"
" Style:
" - Configure the separator via g:vimwiki_breadcrumbs_sep (string)
"   Examples:
"     let g:vimwiki_breadcrumbs_sep = ' / '
"     let g:vimwiki_breadcrumbs_sep = ' | '
"     let g:vimwiki_breadcrumbs_sep = ' - '
"
"=============================================================================

if exists('g:loaded_vimwiki_breadcrumbs')
  finish
endif
let g:loaded_vimwiki_breadcrumbs = 1

"------------------------------------------------------------------------------
" User configuration
"------------------------------------------------------------------------------

if !exists('g:vimwiki_breadcrumbs_include_self')
  let g:vimwiki_breadcrumbs_include_self = 1
endif

if !exists('g:vimwiki_breadcrumbs_default_root_label')
  let g:vimwiki_breadcrumbs_default_root_label = 'Wiki'
endif

if !exists('g:vimwiki_breadcrumbs_sep')
  let g:vimwiki_breadcrumbs_sep = '/'
endif

"------------------------------------------------------------------------------
" Helpers
"------------------------------------------------------------------------------

function! s:normpath(path) abort
  return simplify(fnamemodify(expand(a:path), ':p'))
endfunction

function! s:capitalize_words(text) abort
  let l:words = split(a:text, '\s\+')
  if empty(l:words)
    return ''
  endif

  for l:i in range(0, len(l:words) - 1)
    let l:w = l:words[l:i]
    if !empty(l:w)
      let l:words[l:i] = toupper(strpart(l:w, 0, 1)) . strpart(l:w, 1)
    endif
  endfor

  return join(l:words, ' ')
endfunction

function! s:title_from(path) abort
  if !filereadable(a:path)
    return ''
  endif

  for l:line in readfile(a:path, '', 20)
    if l:line =~# '^= .\+ =$'
      return substitute(l:line, '^= \| =$', '', 'g')
    endif
  endfor

  return ''
endfunction

function! s:titleize(seg) abort
  let l:s = substitute(a:seg, '[_-]', ' ', 'g')
  return toupper(strpart(l:s, 0, 1)) . strpart(l:s, 1)
endfunction

function! s:relpath(from_dir, to_path) abort
  let l:from = split(simplify(fnamemodify(a:from_dir, ':p')), '/')
  let l:to   = split(simplify(fnamemodify(a:to_path,  ':p')), '/')

  while !empty(l:from) && !empty(l:to) && l:from[0] ==# l:to[0]
    call remove(l:from, 0)
    call remove(l:to, 0)
  endwhile

  let l:rel = repeat(['..'], len(l:from)) + l:to
  return empty(l:rel) ? '.' : join(l:rel, '/')
endfunction

function! s:wiki_link(from_dir, target, label) abort
  let l:rel  = s:relpath(a:from_dir, a:target)
  let l:path = substitute(l:rel, '\.wiki$', '', '')

  if l:path ==# 'index'
    let l:path = './index'
  endif

  return '[[' . l:path . '|' . a:label . ']]'
endfunction

"------------------------------------------------------------------------------
" Vimwiki list integration
"------------------------------------------------------------------------------

function! s:find_vimwiki_for_file(file) abort
  let l:file = s:normpath(a:file)

  let l:best = {}
  let l:best_len = -1

  for l:wiki in get(g:, 'vimwiki_list', [])
    if type(l:wiki) != type({})
      continue
    endif

    let l:root = get(l:wiki, 'path', '')
    if empty(l:root)
      continue
    endif

    let l:rootp = s:normpath(l:root)
    if empty(l:rootp) || !isdirectory(l:rootp)
      continue
    endif

    if l:rootp[-1:] !=# '/'
      let l:rootp .= '/'
    endif

    if l:file[:len(l:rootp)-1] ==# l:rootp
      if len(l:rootp) > l:best_len
        let l:best = copy(l:wiki)
        let l:best.root = l:rootp
        let l:best.ext  = get(l:wiki, 'ext', '.wiki')
        let l:best.name = s:capitalize_words(get(l:wiki, 'name', ''))
        let l:best_len = len(l:rootp)
      endif
    endif
  endfor

  return l:best
endfunction

function! s:root_label(wiki) abort
  let l:root = get(a:wiki, 'root', '')
  if empty(l:root)
    return get(g:, 'vimwiki_breadcrumbs_default_root_label', 'Wiki')
  endif

  let l:index = l:root . 'index.wiki'
  let l:title = s:title_from(l:index)
  if !empty(l:title)
    return l:title
  endif

  let l:name = get(a:wiki, 'name', '')
  if !empty(l:name)
    return l:name
  endif

  return get(g:, 'vimwiki_breadcrumbs_default_root_label', 'Wiki')
endfunction

"------------------------------------------------------------------------------
" Breadcrumb construction
"------------------------------------------------------------------------------

function! s:vimwiki_breadcrumbs() abort
  if expand('%:e') !=# 'wiki'
    return ''
  endif

  let l:file = s:normpath(expand('%:p'))
  let l:dir  = fnamemodify(l:file, ':h')

  let l:wiki = s:find_vimwiki_for_file(l:file)
  if empty(l:wiki)
    return ''
  endif

  let l:root = l:wiki.root
  let l:root_index = l:root . 'index.wiki'
  if !filereadable(l:root_index)
    return ''
  endif

  let l:crumbs = []
  call add(l:crumbs, s:wiki_link(l:dir, l:root_index, s:root_label(l:wiki)))

  let l:rel_dir = substitute(l:dir[len(l:root):], '^/', '', '')
  if !empty(l:rel_dir)
    let l:path = l:root[:-2]  " strip trailing slash for concatenation
    for l:seg in split(l:rel_dir, '/')
      let l:path  .= '/' . l:seg
      let l:index  = l:path . '/index.wiki'

      let l:label = s:title_from(l:index)
      if empty(l:label)
        let l:label = s:titleize(l:seg)
      endif

      call add(l:crumbs, s:wiki_link(l:dir, l:index, l:label))
    endfor
  endif

  if get(g:, 'vimwiki_breadcrumbs_include_self', 0) && expand('%:t') !=# 'index.wiki'
    let l:self_title = s:title_from(l:file)
    if !empty(l:self_title)
      call add(l:crumbs, '[[' . expand('%:t:r') . '|' . l:self_title . ']]')
    endif
  endif

  let l:sep = get(g:, 'vimwiki_breadcrumbs_sep', '/')
  return join(l:crumbs, l:sep)
endfunction

"------------------------------------------------------------------------------
" Update/insert breadcrumbs near top of file
"------------------------------------------------------------------------------

function! s:vimwiki_update_breadcrumbs() abort
  let l:bc = s:vimwiki_breadcrumbs()
  if empty(l:bc)
    return
  endif

  let l:head = search('^=.\+=\s*$', 'n')
  if l:head == 0
    return
  endif

  let l:line = l:head - 1
  while l:line > 0 && getline(l:line) ==# ''
    let l:line -= 1
  endwhile

  if getline(l:line) =~# '^\[\[.\+\]\]'
    call setline(l:line, l:bc)
  else
    call append(l:line, l:bc)
  endif
endfunction

"------------------------------------------------------------------------------
" Command + autocommands
"------------------------------------------------------------------------------

command! VimwikiBreadcrumbs call <SID>vimwiki_update_breadcrumbs()
