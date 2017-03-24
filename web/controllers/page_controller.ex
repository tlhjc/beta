defmodule Beta.PageController do
  use Beta.Web, :controller
  alias Beta.Post

  def index(conn, _params) do
    posts = Repo.all(Post)
    render conn, "index.html", date: get_todays_date(), posts: posts
  end

  def get_todays_date() do
    {{year, month, day}, {_hour, _minute, _second}} = :calendar.local_time()
    date = NaiveDateTime.utc_now()
    months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ]
    days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ]

    current_month_date = Integer.to_string(day)
    current_day_of_week = Enum.at(days, Date.day_of_week(date) - 1)
    current_month = Enum.at(months, month - 1)
    current_year = Integer.to_string(year)

    date = current_day_of_week <> ", " <> current_month <> " " <> current_month_date <> ", " <> current_year
    upper_case_date = String.upcase(date)
    upper_case_date
  end
end
