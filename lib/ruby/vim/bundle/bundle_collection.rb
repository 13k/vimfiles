require 'yaml'

require 'vim/bundle/bundle'

#
# bundle specs:
#
# Array of "src:name:url"
#
# src: fs | git | hg
#
# shortcuts:
#   "gh:<user>/<repository>" -> "git:<repository>:https://github.com/<user>/<repository>.git"
#   "fs:<directory>" -> "fs:<directory_name>:file://<directory>"
#
class BundleCollection
  BUNDLE_SPEC_RE = /\A(?<src>.+?):(?<name>.+?):(?<url>.+)\z/.freeze

  BUNDLE_SPEC_SHORTCUTS = {
    /^fs:(.*)/ => ->(match) { "fs:#{File.basename(match[1])}:file://#{match[1]}" },
    /^gh:(.*)/ => ->(match) { "git:#{File.basename(match[1])}:https://github.com/#{match[1].sub(/\.git$/, '')}.git" },
  }.freeze

  def initialize(bundles_file, bundles_dir)
    @bundles_file = bundles_file
    @bundles_dir = bundles_dir
  end

  def bundles
    @bundles ||= begin
      specs = load_bundles_specs
      specs.map {|spec| Bundle.new(spec) }
    end
  end

  def removed_bundles
    @bundles_dir.each_child.select do |child|
      child.directory? && !include?(child.basename.to_s)
    end.map do |child|
      Bundle.new(name: child.basename.to_s)
    end
  end

  def find(name)
    bundles.find {|b| b.name == name.to_s }
  end
  alias [] find

  def include?(name)
    !find(name).nil?
  end

  private

  def load_bundles_specs
    specs = YAML.load_file(@bundles_file)
    specs.map do |spec|
      parse_bundle_spec(spec)
    end
  end

  def parse_bundle_spec(spec)
    BUNDLE_SPEC_SHORTCUTS.each do |re, transform|
      if match = re.match(spec)
        spec = transform.call(match)
        break
      end
    end

    match = BUNDLE_SPEC_RE.match(spec)
    BUNDLE_SPEC_RE.named_captures.keys.reduce({}) do |bundle, key|
      key = key.to_sym
      value = match[key]
      value = value.to_sym if key == :src
      bundle.update(key => value)
    end
  end
end
