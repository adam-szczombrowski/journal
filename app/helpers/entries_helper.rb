module EntriesHelper
  def todays_date
    Date.today.strftime("%a %d/%m/%y")
  end
end
