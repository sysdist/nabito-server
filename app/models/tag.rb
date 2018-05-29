# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  tag_type   :string
#  user_ref   :string
#  token      :string
#  pin        :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  belongs_to :user
  
  
  
end
