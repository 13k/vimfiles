require 'fileutils'
require 'yaml'

#
# bundle specs:
#
# Array of "scm:name:url"
#
# scms:
#   git
#   hg
#
# shortcuts:
#   "gh:user/repository" -> "git:repository:https://github.com/user/repository.git"
#
def load_bundles(bundles_file)
  bundle_re = /(.*?):(.*?):(.*)/
  bundles = YAML.load_file(bundles_file)
  bundles.map! do |repo|
    bundle = case repo
      when /^gh:(.*)/
        "git:#{File.basename($1)}:https://github.com/#{$1.sub /\.git$/, ''}.git"
      else
        repo
    end

    match = bundle.match(bundle_re)

    {
      scm: match[1].to_sym,
      name: match[2],
      url: match[3],
    }
  end
end
