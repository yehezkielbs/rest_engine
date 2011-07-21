# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rest_engine}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yehezkiel Syamsuhadi"]
  s.date = %q{2011-07-21}
  s.email = %q{yehezkielbs@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "app/controllers/rest_engine/application_controller.rb",
    "app/controllers/rest_engine/main_controller.rb",
    "config/routes.rb",
    "lib/rest_engine.rb",
    "lib/rest_engine/engine.rb"
  ]
  s.homepage = %q{http://github.com/yehezkielbs/rest_engine}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{A Rails 3 engine that provide your Rails application a restful API}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rails>, ["~> 3.0.9"])
      s.add_development_dependency(%q<sqlite3>, ["~> 1.3.3"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 2.3.1"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.15"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<factory_girl>, ["~> 1.3.3"])
    else
      s.add_dependency(%q<rails>, ["~> 3.0.9"])
      s.add_dependency(%q<sqlite3>, ["~> 1.3.3"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<rspec-rails>, ["~> 2.3.1"])
      s.add_dependency(%q<bundler>, ["~> 1.0.15"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<factory_girl>, ["~> 1.3.3"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 3.0.9"])
    s.add_dependency(%q<sqlite3>, ["~> 1.3.3"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<rspec-rails>, ["~> 2.3.1"])
    s.add_dependency(%q<bundler>, ["~> 1.0.15"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<factory_girl>, ["~> 1.3.3"])
  end
end

