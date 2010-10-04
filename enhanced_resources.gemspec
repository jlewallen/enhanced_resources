Gem::Specification.new do |s|
  s.name = %q{enhanced_resources}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ['Jacob Lewallen']
  s.date = %q{2010-08-18}
  s.description = %q{}
  s.email = %q{jlewalle@gmail.com}
  s.extra_rdoc_files = [
  ]
  s.files = [
    "lib/enhanced_resources.rb",
    "lib/enhanced_resources/base.rb",
    "lib/enhanced_resources/base_helpers.rb",
    "lib/enhanced_resources/class_methods.rb"
  ]
  s.homepage = %q{http://github.com/jlewallen/enhanced_resources}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.summary = %q{}
  s.test_files = [
  ]

  s.specification_version = 3
  s.add_runtime_dependency(%q<inherited_resources>)
end
