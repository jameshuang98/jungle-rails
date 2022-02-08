class User < ActiveRecord::Base
    has_secure_password

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :password, presence: true, length: { minimum: 7 }
    validates :password_confirmation, presence: true, length: { minimum: 7 }
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    before_save :downcase_email

    def self.authenticate_with_credentials(email, password)
        # make email all lowercase and remove any surrounding whitespace
        clean_email = email.downcase.strip

        # find the user with the find_by_email dynamic finder method
        user = User.find_by_email(clean_email)
        
        # returns user if the user exists and passes the authentication
        user && user.authenticate(password)
    end

    def downcase_email
        self.email.downcase!
    end

end
