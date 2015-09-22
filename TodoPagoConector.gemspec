lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'todo_pago/version'

Gem::Specification.new do |s|
  s.name = 'TodoPagoConector'
  s.version = TodoPago::VERSION
  s.date = '2015-02-03'
  s.summary="test conector"
  s.description = "Conector para la plataforma de pagos"
  s.authors = ["Softtek"]
  s.files = `git ls-files -z`.split("\x0")

  s.add_dependency "savon", ["= 2.8.1"]
  s.add_dependency "paper-cup", ["~> 0.2.1"]
end
