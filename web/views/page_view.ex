defmodule Beta.PageView do
  use Beta.Web, :view

  def format_date(date) do
    months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ]
    year = Integer.to_string(date.year)
    month = Enum.at(months, date.month - 1)
    day = Integer.to_string(date.day)
    month <> " " <> day <> ", " <> year
  end
end
