# == Schema Information
#
# Table name: batch_payments
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  due_date   :date
#  money      :decimal(15, 2)   default(0.0), not null
#  number     :integer          not null
#  pay_date   :date
#  payed      :boolean          default(FALSE)
#  total      :decimal(15, 2)   default(0.0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sale_id    :bigint
#
# Indexes
#
#  index_batch_payments_on_sale_id  (sale_id)
#
# Foreign Keys
#
#  fk_rails_...  (sale_id => sales.id)
#
class BatchPayment < ApplicationRecord
	has_one :sale


	def expired?
		self.due_date < Time.new
	end

end	