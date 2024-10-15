class Eventlog < ApplicationRecord
  belongs_to :user, dependency: :destroy
end
