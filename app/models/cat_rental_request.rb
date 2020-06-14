# == Schema Information
#
# Table name: cat_rental_requests
#
#  id           :bigint           not null, primary key
#  end_date     :date             not null
#  start_date   :date             not null
#  status       :string           default("PENDING")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  cat_id       :integer          not null
#  requester_id :integer          not null
#
# Indexes
#
#  index_cat_rental_requests_on_cat_id        (cat_id)
#  index_cat_rental_requests_on_requester_id  (requester_id)
#
class CatRentalRequest < ApplicationRecord
    validates :end_date, :start_date, :cat_id, presence: true
    validates :status, inclusion: %w(PENDING APPROVED DENIED)
    validate :does_not_overlap_approved_request
    # validation to make sure all requests are in the future

    belongs_to :cat,
        primary_key: :id,
        class_name: :Cat,
        foreign_key: :cat_id

    def overlapping_requests
        CatRentalRequest
            .where(cat_id: self.cat_id)
            .where.not(id: self.id)
            .where('? >= start_date AND end_date >= ?', self.end_date, self.start_date)
    end

    def overlapping_approved_requests
        overlapping_requests.where(status: 'APPROVED')
    end

    def does_not_overlap_approved_request
        if overlapping_approved_requests.exists?
            errors[:Cannot] << "request cat during this period, cat is already reserved."
        end
    end

    def overlapping_pending_requests
        overlapping_requests.where(status: 'PENDING')
    end

    def approve!
        return unless self.pending?

        ActiveRecord::Base.transaction do
            overlapping_pending_requests.each do |r| 
                r.status = 'DENIED'
                r.save!
            end
            self.status = 'APPROVED'
            self.save
        end
    end

    def deny!
        return unless self.pending?

        self.status = 'DENIED'
        self.save
    end

    def pending?
        self.status == 'PENDING'
    end
end
