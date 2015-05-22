require 'find'
require 'pathname'

DOTDIR_PRUNE_FILE = Pathname.new(".dotdir")

def dotfiles(dotfiles_dir)
  dotfiles = []
  dotfiles_dir = Pathname.new(dotfiles_dir).realpath

  dotfiles_dir.find do |path|
    next if path == dotfiles_dir

    dotfiles << path

    if path.directory? && path.children(false).include?(DOTDIR_PRUNE_FILE)
      Find.prune
    end
  end

  dotfiles
end
