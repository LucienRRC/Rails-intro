class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  include ActiveModel::Validations
  include ActiveRecord::Validations
end
