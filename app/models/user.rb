# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  enum role: {student: 0, teacher: 10, admin: 30}

  # Reservation Tableを予約者（生徒）から参照
  has_many :active_reservations, class_name: "Reservation", foreign_key: "reserver_id", dependent: :destroy

  # Reservation Tableを被予約者（教師）から参照
  has_many :passive_reservations, class_name: "Reservation", foreign_key: "reserved_id", dependent: :destroy

  # 予約した相手（教師）を参照
  has_many :reservings, through: :active_reservations, source: :reserved

  # 予約してきた相手（生徒）を参照
  has_many :reservers, through: :passive_reservations, source: :reserver

  def reserve(user, start_date, end_date)
    active_reservations.create(reserved_id: user.id)
  end

  def unreserve(user, start_date, end_date)
    active_reservations.find_by(reserved_id: user.id).destroy
  end

  def reserving?(user, start_date, end_date)
    reservings.include?(user, start_date, end_date)
  end

end
