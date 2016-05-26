require Rails.root.join "lib", "my_parser"

ActsAsTaggableOn.default_parser = MyParser
