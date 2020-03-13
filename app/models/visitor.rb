class Visitor < ApplicationRecord
  validates :request_count, numericality: { greater_than_or_equal_to: 0 }
  validates :IP, presence: true

  has_many :visitor_locations
  has_many :visitor_emails


  def save_visitor
    ip = request.remote_ip
    @visitor = Visitor.find_by(IP: ip)
    if @visitor.nil?
      @visitor = Visitor.create(IP: ip)
    else
      @visitor.request_count += 1
      @visitor.save
    end
  end
end
