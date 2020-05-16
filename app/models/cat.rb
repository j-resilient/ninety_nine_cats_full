# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  description :text
#  name        :string           not null
#  sex         :string(1)        not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_cats_on_name  (name)
#
class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper

    CAT_COLORS = %w(white black brown orange).freeze

    validates :birth_date, :color, :name, :sex, presence: true
    validates :sex, inclusion: %w(F M)
    validates :color, inclusion: CAT_COLORS
    validate :born_previously

    # private
    def age
        time_ago_in_words(birth_date)
    end

    def born_previously
        errors[:birth_date] << "must be before today" if (birth_date <=> Date.today) == 1
    end
end