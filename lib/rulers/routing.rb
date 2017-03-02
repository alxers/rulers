module Rulers
  class Application
    def get_controller_and_action(env)
      _before, cont, action, _after = env['PATH_INFO'].split('/', 4)
      # Our controller name will look like 'ExampleController'
      cont = cont.capitalize
      cont += 'Controller'
      [Object.const_get(cont), action]
    end
  end
end
