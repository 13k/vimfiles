" It's a common mistake to type the capital letter instead of the lowercased one
command W w
command Q q

" Convert old-style Ruby hash syntax to new-style and properly format them
command -range RubyHashes <line1>,<line2>s/\v([^:]):(\w+)(\s*)\=\>/\1\2:/ge
