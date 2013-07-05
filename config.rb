require "sass-getunicode"

require 'redcarpet'
require 'active_support/core_ext'

Dir['./lib/*'].each { |f| require f }

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :build_dir, "tmp"
set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true,
               :gh_blockcode       => true,
               :tables             => true,
               :autolink           => true,
               :smartypants        => true,
               :no_intra_emphasis  => true,
               :pattern            => '```'

activate :livereload
activate :directory_indexes
activate :markdown_navigation
activate :array_navigation

page "/",     layout: 'layouts/default'
page "/api*", layout: 'layouts/default'
page "/requirements*", layout: 'layouts/default'

page "/sitemap.xml", :layout => false

activate :highlighter

activate :api_docs,
  default_class: 'Aura',
  repo_url: 'https://github.com/aurajs/aura'


################################################################################
# Sass Configuration
################################################################################
require 'lib/retina.rb'
require 'lib/random-color.rb'
Sass::Script::Number.precision = 20

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :cache_buster
  activate :gzip

  set :logging, true
end

# if development?
use RackEnvironment, :file => 'environment.yml' if File.exist?('./environment.yml')
