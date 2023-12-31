# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "action_view"


class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper
    CAT_COLORS = ['orange', 'black', 'white', 'calico']


    validates :birth_date, presence: true
    validates :color, presence: true, inclusion: { in: CAT_COLORS }
    validates :name, presence: true
    validates :sex, presence: true, inclusion: { in: ['M', 'F'] }
    validate :birth_date_cannot_be_future

    def age
        ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
    end

    private
    def birth_date_cannot_be_future
        if birth_date > Date.today
            errors.add(:birth_date, "cannot be after today\'s date")
        end
    end



end
