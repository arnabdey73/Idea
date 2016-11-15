# -*- encoding: utf-8 -*-
# stub: knife-ec2 0.12.0 ruby lib

Gem::Specification.new do |s|
  s.name = "knife-ec2"
  s.version = "0.12.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Adam Jacob", "Seth Chisamore"]
  s.date = "2015-10-06"
  s.description = "EC2 Support for Chef's Knife Command"
  s.email = ["adam@opscode.com", "schisamo@opscode.com"]
  s.homepage = "https://github.com/opscode/knife-ec2"
  s.licenses = ["Apache-2.0"]
  s.rubygems_version = "2.5.1"
  s.summary = "EC2 Support for Chef's Knife Command"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fog>, ["~> 1.29.0"])
      s.add_runtime_dependency(%q<knife-windows>, ["~> 1.0"])
      s.add_development_dependency(%q<chef>, [">= 12.2.1", "~> 12.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<rake>, ["~> 10.1"])
      s.add_development_dependency(%q<sdoc>, ["~> 0.3"])
    else
      s.add_dependency(%q<fog>, ["~> 1.29.0"])
      s.add_dependency(%q<knife-windows>, ["~> 1.0"])
      s.add_dependency(%q<chef>, [">= 12.2.1", "~> 12.0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<rake>, ["~> 10.1"])
      s.add_dependency(%q<sdoc>, ["~> 0.3"])
    end
  else
    s.add_dependency(%q<fog>, ["~> 1.29.0"])
    s.add_dependency(%q<knife-windows>, ["~> 1.0"])
    s.add_dependency(%q<chef>, [">= 12.2.1", "~> 12.0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<rake>, ["~> 10.1"])
    s.add_dependency(%q<sdoc>, ["~> 0.3"])
  end
end
