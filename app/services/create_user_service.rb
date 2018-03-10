class CreateUserService
  def admin
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.name = Rails.application.secrets.admin_name
        user.is_admin = true
        user.is_approved = true
      end
  end
  
  def users
    for i in 1..5 do
      User.create!(email: "user_#{i}@example.com",
                  password: "changeme",
                  password_confirmation: "changeme",
                  name: "user_#{i}")
    end
    User.create!(email: "rfid_user@nabito.org",
                  password: "changeme",
                  password_confirmation: "changeme",
                  name: "rfid_user")
  end
end
