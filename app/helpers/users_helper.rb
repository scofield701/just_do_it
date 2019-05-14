module UsersHelper
  require "date"
  def current_user?(user)
    user == current_user
  end

  def age(y,m,d)
    date_format = "%Y%m%d"
    birthday = y.to_s + sprintf("%02d",m).to_s + sprintf("%02d",d).to_s
    (Date.today.strftime(date_format).to_i - birthday.to_i) / 10000
  end
end
