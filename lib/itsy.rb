module Itsy
  load_path = File.expand_path(File.dirname(__FILE__))
  require 'rubygems'
  require 'open-uri'
  require 'htmlentities'
  require 'json'
  require 'hpricot'
  require 'uri'
  require File.join(load_path, 'util','delegation')
  require File.join(load_path, 'util','enumerable')
  require File.join(load_path, 'itsy','scrapeable_entity')
  require File.join(load_path, 'itsy', 'scrapeable_entity', 'page_entity')
  require File.join(load_path, 'itsy', 'scrapeable_entity', 'element_entity')
end