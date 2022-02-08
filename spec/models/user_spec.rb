require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    
    before(:each) do
      @user = User.new(
        first_name: "user",
        last_name: "name",
        email: "test@test.com",
        password: "password",
        password_confirmation: "password"
        )
      # save the user to the database (this is necessary because I am checking for duplicate user credentials) 
      @user.save 
    end
    
    context "Create an initial example to ensure user will save successfully" do
      it "it is valid with valid attributes" do
        expect(@user).to be_valid
      end
    end

    context "Check password and password_confirmation validations" do
      it "it is not valid if password doesn't match password confirmation" do
        @user.password = "laber"
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "it is not valid if password is blank" do
        @user.password = nil
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "it is not valid if password confirmation is blank" do
        @user.password_confirmation = nil
        expect(@user).to_not be_valid
        puts @user.errors.full_messages
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end
    end

    context "Check that emails must be unique" do
      it "it is not valid if email already exists in database" do
        
        user2 = User.new(
          first_name: "user",
          last_name: "name",
          email: "test@test.com",
          password: "password",
          password_confirmation: "password"
        )

        expect(user2).to_not be_valid # This expect triggers the validations
        expect(user2.errors.full_messages).to include("Email has already been taken")
      end

      it "it is not valid if email (with different casing) already exists in database" do
        
        user3 = User.new(
          first_name: "user",
          last_name: "name",
          email: "TEST@TEST.com",
          password: "password",
          password_confirmation: "password"
        )

        expect(user3).to_not be_valid
        expect(user3.errors.full_messages).to include("Email has already been taken")
      end
    end


    context "Check that email, first name, and last name are not blank" do
      
      it "it is not valid without a name" do
        @user.first_name = nil
        expect(@user).to_not be_valid 
        expect(@user.errors.full_messages).to include("First name can't be blank") 
      end

      it "it is not valid without a last name" do
        @user.last_name = nil
        expect(@user).to_not be_valid 
        expect(@user.errors.full_messages).to include("Last name can't be blank") 
      end

      it "it is not valid without a email" do
        @user.email = nil
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

    end

    context "Check that password must be at least 7 characters" do
      
      it "it is not valid with a short password" do
        @user.password = "pass"
        @user.password_confirmation = "pass"
        expect(@user).to_not be_valid
        puts @user.errors.full_messages
        expect(@user.errors.full_messages).to include("Password confirmation is too short (minimum is 7 characters)")
      end

    end

    describe '.authenticate_with_credentials' do

      before(:each) do
        @person = User.create(
          first_name: "person",
          last_name: "person",
          email: "RSpec@test.com",
          password: "password",
          password_confirmation: "password"
          )
      end
    
      context "Check that .authenticate_with_credentials works" do
      
        it "it works with valid credentials" do
          expect(User.authenticate_with_credentials("RSpec@test.com", "password")).to eq(@person)
        end

        it "it doesn't with invalid email" do
          expect(User.authenticate_with_credentials("RSpec@test.test.com", "password")).to_not eq(@person)
        end

        it "it doesn't with invalid password" do
          expect(User.authenticate_with_credentials("RSpec@test.com", "passwordword")).to_not eq(@person)
        end

        it "it still works if there are leading spaces" do
          expect(User.authenticate_with_credentials("   RSpec@test.com", "password")).to eq(@person)
        end

        it "it still works if there are trailing spaces" do
          expect(User.authenticate_with_credentials("RSpec@test.com   ", "password")).to eq(@person)
        end

        it "it still works if email is typed with different casing" do
          expect(User.authenticate_with_credentials("rsPec@TEST.com", "password")).to eq(@person)
        end

      
      end
      
    end

  end
end
