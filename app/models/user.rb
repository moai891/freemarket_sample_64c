class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, password_length: 7..128
  has_many :items
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :card, dependent: :destroy
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
  validates :nickname, presence: true
  validates :password_confirmation,  presence: true, on: :create
  validates :phonenumber, presence: true
  validates :birth_date, presence: true
  validates :familyname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "全角のみで入力してください" }
  validates :firstname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "全角のみで入力してください" }
  validates :familyname_kana, presence: true, format: { with: /\A[ぁ-んー－]+\z/, message: "全角ひらがなのみで入力してください" }
  validates :firstname_kana, presence: true, format: { with: /\A[ぁ-んー－]+\z/, message: "全角ひらがなのみで入力してください" }

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  mount_uploader :avatar, AvatarUploader

end
