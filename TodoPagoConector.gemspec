Gem::Specification.new do |s|
  s.name = 'TodoPagoConector'
  s.version = '1.1.0'
  s.date = '2015-02-03'
  s.summary="test conector"
  s.description = "Conector para la plataforma de pagos"
  s.authors = ["Softtek"]
  s.files = ["lib/todo_pago_conector.rb"]
  s.add_runtime_dependency "savon", ["= 2.8.1"]
end