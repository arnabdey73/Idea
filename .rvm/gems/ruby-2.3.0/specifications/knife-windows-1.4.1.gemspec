# -*- encoding: utf-8 -*-
# stub: knife-windows 1.4.1 ruby lib

Gem::Specification.new do |s|
  s.name = "knife-windows"
  s.version = "1.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Seth Chisamore"]
  s.date = "2016-05-04"
  s.description = "Plugin that adds functionality to Chef's Knife CLI for configuring/interacting with nodes running Microsoft Windows"
  s.email = ["schisamo@chef.io"]
  s.homepage = "https://github.com/chef/knife-windows"
  s.licenses = ["Apache-2.0"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.1")
  s.rubygems_version = "2.5.1"
  s.summary = "Plugin that adds functionality to Chef's Knife CLI for configuring/interacting with nodes running Microsoft Windows"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<winrm>, ["~> 1.7"])
      s.add_development_dependency(%q<pry>, [">= 0"])
    else
      s.add_dependency(%q<winrm>, ["~> 1.7"])
      s.add_dependency(%q<pry>, [">= 0"])
    end
  else
    s.add_dependency(%q<winrm>, ["~> 1.7"])
    s.add_dependency(%q<pry>, [">= 0"])
  end
end
