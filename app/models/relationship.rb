class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :influence, class_name: "User"
end
