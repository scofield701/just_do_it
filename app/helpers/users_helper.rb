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

  def birth_age(min_age, max_age)
    min_age = max_age if min_age == ""
    max_age = min_age if max_age == ""
    younger_birth_ymd = calc_younger_birthday(min_age).to_s
    older_birth_ymd = calc_older_birthday(max_age).to_s
    return younger_birth_ymd, older_birth_ymd
  end

  def calc_younger_birthday(age)
    Date.today.strftime("%Y%m%d").to_i - age.to_i * 10000
  end

  def calc_older_birthday(age)
    Date.today.strftime("%Y%m%d").to_i - age.to_i * 10000 - 9999
  end
end
