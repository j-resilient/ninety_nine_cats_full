# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  end_date   :date             not null
#  start_date :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cat_id     :integer          not null
#
# Indexes
#
#  index_cat_rental_requests_on_cat_id  (cat_id)
#
class CatRentalRequest < ApplicationRecord
    validates :end_date, :start_date, :cat_id, presence: true
    validates :status, inclusion: %w(PENDING APPROVED DENIED)
    # validation to make sure all requests are in the future

    belongs_to :cat,
        primary_key: :id,
        class_name: :Cat,
        foreign_key: :cat_id

    def overlapping_requests
        CatRentalRequest
            .where(cat_id: self.cat_id)
            .where.not(id: self.id)
            .where('? > start_date AND end_date > ?', self.end_date, self.start_date)

    end
end
