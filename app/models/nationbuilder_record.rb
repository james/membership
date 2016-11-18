class NationbuilderRecord < ActiveRecord::Base
  establish_connection :nationbuilder
  self.abstract_class = true
end
