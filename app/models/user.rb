class User < ActiveRecord::Base


  
	before_save { self.email = email.downcase }

  before_create :create_remember_token

  has_many :thankyous_sent, foreign_key: "sender_id" , class_name: "Thankyou"
  has_many :thankyous_received, foreign_key: "recipient_id" , class_name: "Thankyou"

  has_many :sent_to_users, through: :thankyous_sent, source: :recipient
  has_many :received_from_users, through: :thankyous_received, source: :sender



	validates(:name, presence: true, length: {maximum: 50})
#	validates :name,  presence: true, length: { maximum: 50 }

	VALID_EMAIL_REGEX =	/\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates(:email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false })
	 
	has_secure_password
	validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def send_password_reset
    generate_password_reset_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    self.save!(validate: false)
    UserMailer.password_reset(self).deliver
  end

  private

    def generate_password_reset_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end


    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

end

